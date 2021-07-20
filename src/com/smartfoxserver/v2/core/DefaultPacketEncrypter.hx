package com.smartfoxserver.v2.core;

/**
 * ...
 * @author vincent blanchet
 */

import com.hurlant.crypto.symmetric.ICipher;
import com.hurlant.crypto.symmetric.IPad;
import com.hurlant.crypto.symmetric.IVMode;
import com.hurlant.crypto.symmetric.PKCS5;
import com.smartfoxserver.v2.SmartFox;
import com.smartfoxserver.v2.bitswarm.BitSwarmClient;
import com.smartfoxserver.v2.protocol.serialization.DefaultObjectDumpFormatter;
import com.smartfoxserver.v2.util.CryptoKey;

import openfl.errors.IllegalOperationError;
import openfl.utils.ByteArray;

import haxe.crypto.Aes;
import haxe.crypto.mode.Mode;
import openfl.utils.Endian;

class DefaultPacketEncrypter implements IPacketEncrypter
{
	private var bitSwarm:BitSwarmClient;
	
	public function new(bitSwarm:BitSwarmClient)
	{
		this.bitSwarm = bitSwarm;
	}
	
	public function encrypt(data:ByteArray):Void
	{
		// Write encrypted data to beginning of ByteArray
		data.position = 0;
		data.writeBytes(bitSwarm.cipher.encrypt(Mode.CBC, data));
	}
	
	public function decrypt(data:ByteArray):Void
	{
		// Continually write decrypted data into ByteArray
		data.writeBytes(bitSwarm.cipher.decrypt(Mode.CBC, data));
	}
}
	

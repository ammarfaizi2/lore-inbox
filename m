Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbUKCGgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUKCGgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 01:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUKCGgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 01:36:55 -0500
Received: from dev.tequila.jp ([128.121.50.153]:33297 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S261430AbUKCGgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 01:36:50 -0500
Message-ID: <41887C56.7090000@tequila.co.jp>
Date: Wed, 03 Nov 2004 15:36:06 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@nosferatu.za.org>
CC: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net
Subject: Re: XMMS (or some other audio player) 'hang' issues with intel8x0
 and	dmix plugin [u]
References: <1099284142.11924.17.camel@nosferatu.lan>	 <41873A9E.3020909@tequila.co.jp> <1099446318.11924.23.camel@nosferatu.lan>
In-Reply-To: <1099446318.11924.23.camel@nosferatu.lan>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6FD526134B7ABB56B9CD7CB9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6FD526134B7ABB56B9CD7CB9
Content-Type: multipart/mixed;
 boundary="------------000305000901040803020608"

This is a multi-part message in MIME format.
--------------000305000901040803020608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11/03/2004 10:45 AM, Martin Schlemmer [c] wrote:

> I would appreciate that.  Any workaround currently will be nice.

attached my .asoundrc

What I did, I halfed the buffer_size from 8K to 4K. After that it worked
fine.

I really don't know why that is.

my soundcard acording to lspci is:

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97
Audio Controller (rev 02)
        Subsystem: Sony Corporation: Unknown device 80fa
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at 1c00 [size=256]
        I/O ports at 18c0 [size=64]

but I know there is a yamaha chip behind, because in windows xp, I use
yamaha drivers.

lg, clemens

--------------000305000901040803020608
Content-Type: text/plain;
 name=".asoundrc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".asoundrc"

pcm.!default {
	type plug
	slave.pcm "dmixer"
}

pcm.dsp0 {
	type plug
	slave.pcm "dmixer"
}

pcm.dmixer {
	type dmix
	ipc_key 1024
	slave {
		pcm "hw:0,0"
		period_time 0
		period_size 1024
		buffer_size 4096
		rate 44100
	}
	bindings {
		0 0
		1 1
	}
}

ctl.dmixer {
	type hw
	card 0
}

--------------000305000901040803020608--

--------------enig6FD526134B7ABB56B9CD7CB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBiHxZjBz/yQjBxz8RAtj5AJ4p+G5Bsiz7Z7nd2s2p4J09s/f28wCfaCMY
TTPmNZpEizw1HmWuNSJXx3o=
=bkaL
-----END PGP SIGNATURE-----

--------------enig6FD526134B7ABB56B9CD7CB9--

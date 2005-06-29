Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVF2MOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVF2MOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 08:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVF2MOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 08:14:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:12751 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262563AbVF2MN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 08:13:59 -0400
Message-ID: <42C29082.8060104@punnoor.de>
Date: Wed, 29 Jun 2005 14:13:54 +0200
From: Prakash Punnoor <prakash@punnoor.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050511)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, se.witt@gmx.net
Subject: Re: Linux 2.6.13-rc1 - [PATCH] Don't fill up log with atxp1 vcore
 change message
References: <Pine.LNX.4.58.0506282310040.14331@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506282310040.14331@ppc970.osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig65E439B98C6F3F897173B649"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig65E439B98C6F3F897173B649
Content-Type: multipart/mixed;
 boundary="------------080807010004040004070604"

This is a multi-part message in MIME format.
--------------080807010004040004070604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I am using atxp1 module to change vcore on my NForce2 via userspace daemon
(see punnoor.de). Currently atxp1 module will write to the log on every vcore
change, thus filling up my log - which I don't want. I am no kernel coder, but
I guess, this one-liner will change this behaviour in a wanted way, ie output
will be made for debug purposes only. (Please use the attached patch, if
inlined one got fsked up by TB.)

Cheers,

Prakash



Signed-off-by: Prakash Punnoor <prakash@punnoor.de>



--- drivers/i2c/chips/atxp1.c~	2005-06-29 13:59:04.000000000 +0200
+++ drivers/i2c/chips/atxp1.c	2005-06-29 13:59:22.164237992 +0200
@@ -144,7 +144,7 @@
 	if (vid == cvid)
 		return count;

-	dev_info(dev, "Setting VCore to %d mV (0x%02x)\n", vcore, vid);
+	dev_dbg(dev, "Setting VCore to %d mV (0x%02x)\n", vcore, vid);

 	/* Write every 25 mV step to increase stability */
 	if (cvid > vid) {




--------------080807010004040004070604
Content-Type: text/plain;
 name="atxp1_debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atxp1_debug.diff"

--- drivers/i2c/chips/atxp1.c~	2005-06-29 13:59:04.000000000 +0200
+++ drivers/i2c/chips/atxp1.c	2005-06-29 13:59:22.164237992 +0200
@@ -144,7 +144,7 @@
 	if (vid == cvid)
 		return count;
 
-	dev_info(dev, "Setting VCore to %d mV (0x%02x)\n", vcore, vid);
+	dev_dbg(dev, "Setting VCore to %d mV (0x%02x)\n", vcore, vid);
 
 	/* Write every 25 mV step to increase stability */
 	if (cvid > vid) {

--------------080807010004040004070604--

--------------enig65E439B98C6F3F897173B649
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCwpCFxU2n/+9+t5gRAmmkAJ90zMe71B1c1BzTadz8QloJ1F/GZACg2fO2
HNtMBpv0iU08ks49OFyv3H8=
=5f95
-----END PGP SIGNATURE-----

--------------enig65E439B98C6F3F897173B649--

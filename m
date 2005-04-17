Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVDQVrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVDQVrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 17:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVDQVrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 17:47:25 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:34932 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261495AbVDQVrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 17:47:16 -0400
Message-ID: <4262E809.4090809@blueyonder.co.uk>
Date: Sun, 17 Apr 2005 23:49:45 +0100
From: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: emoenke@gwdg.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11.7] sbpcd init cleanup and fix
X-Enigmail-Version: 0.91.0.0
OpenPGP: url=http://www.rossaxe.pwp.blueyonder.co.uk/.pgpkey
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3EB8A129655A1CB4C54FF4ED"
X-OriginalArrivalTime: 17 Apr 2005 21:47:54.0270 (UTC) FILETIME=[1C3B53E0:01C54397]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3EB8A129655A1CB4C54FF4ED
Content-Type: multipart/mixed;
 boundary="------------000806070807060108020203"

This is a multi-part message in MIME format.
--------------000806070807060108020203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

- Remove ugly '#ifdef MODULE's
- Use the __exit attribute on sbpcd_exit()
- Don't rename sbpcd_init() to __sbpcd_init() in modules
- Make sbpcd_init() and sbpcd_exit() static
- Ensure sbpcd_init() is actually called when the driver is compiled in
to the kernel

Signed-off-by: Ross Kendall Axe <ross.axe@blueyonder.co.uk>

--------------000806070807060108020203
Content-Type: text/x-patch;
 name="linux-2.6.11.7-sbpcd-init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.11.7-sbpcd-init.patch"

--- linux-2.6.11.7/drivers/cdrom/sbpcd.c.orig	2005-04-13 17:12:29.000000000 +0100
+++ linux-2.6.11.7/drivers/cdrom/sbpcd.c	2005-04-13 17:46:29.000000000 +0100
@@ -5639,11 +5639,7 @@ static int __init config_spea(void)
  */
 
 /* FIXME: cleanups after failed allocations are too ugly for words */
-#ifdef MODULE
-int __init __sbpcd_init(void)
-#else
-int __init sbpcd_init(void)
-#endif
+static int __init sbpcd_init(void)
 {
 	int i=0, j=0;
 	int addr[2]={1, CDROM_PORT};
@@ -5894,8 +5890,7 @@ int __init sbpcd_init(void)
 	return 0;
 }
 /*==========================================================================*/
-#ifdef MODULE
-void sbpcd_exit(void)
+static void __exit sbpcd_exit(void)
 {
 	int j;
 	
@@ -5926,11 +5921,10 @@ void sbpcd_exit(void)
 }
 
 
-module_init(__sbpcd_init) /*HACK!*/;
+module_init(sbpcd_init);
 module_exit(sbpcd_exit);
 
 
-#endif /* MODULE */
 static int sbpcd_media_changed(struct cdrom_device_info *cdi, int disc_nr)
 {
 	struct sbpcd_drive *p = cdi->handle;

--------------000806070807060108020203--

--------------enig3EB8A129655A1CB4C54FF4ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCYugO9bR4xmappRARAqRjAJ0biUg1QuoWhvLFkz4Xjr8MDb6apQCfcCMA
LlMTlL6ETlCyLyWO9mU35ZE=
=v99x
-----END PGP SIGNATURE-----

--------------enig3EB8A129655A1CB4C54FF4ED--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUCJJ6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 04:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbUCJJ6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 04:58:45 -0500
Received: from smtp-out4.xs4all.nl ([194.109.24.5]:38408 "EHLO
	smtp-out4.xs4all.nl") by vger.kernel.org with ESMTP id S262556AbUCJJ6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 04:58:39 -0500
Mime-Version: 1.0 (Apple Message framework v612)
To: Linux SCSI mailing list <linux-scsi@vger.kernel.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-Id: <65D8CA0E-7270-11D8-AFFE-000A95CD704C@kungfoocoder.org>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-29--330123600"
Cc: akpm@osdl.org, James.Bottomley@HansenPartnership.com, torvalds@osdl.org,
       atulm@lsil.com
Subject: [PATCH][BUGFIX] : Megaraid patch for 2.6 (please apply)
From: Paul Wagland <paul@kungfoocoder.org>
Date: Wed, 10 Mar 2004 09:53:27 +0100
Content-Transfer-Encoding: 7bit
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-29--330123600
Content-Type: multipart/mixed; boundary=Apple-Mail-28--330123604


--Apple-Mail-28--330123604
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hi all,

I know that LSI are working on an updated driver for 2.6, but would 
really like to see this bug fix placed in the main tree before then, 
whenever then happens to be.

This patch fixes the problem of the /proc entries for this driver being 
created in the wrong location.

Cheers,
Paul


--Apple-Mail-28--330123604
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="2-megaraid.init.patch"
Content-Disposition: attachment;
	filename=2-megaraid.init.patch

diff --recursive --ignore-all-space --unified linux-2.6.2.o/drivers/scsi/megaraid.c linux-2.6.2.megaraid/drivers/scsi/megaraid.c
--- linux-2.6.2.o/drivers/scsi/megaraid.c	2004-02-20 01:32:21.000000000 +0100
+++ linux-2.6.2.megaraid/drivers/scsi/megaraid.c	2004-02-20 01:32:26.000000000 +0100
@@ -5119,10 +5119,6 @@
 	if (max_mbox_busy_wait > MBOX_BUSY_WAIT)
 		max_mbox_busy_wait = MBOX_BUSY_WAIT;
 
-	error = pci_module_init(&megaraid_pci_driver);
-	if (error) 
-		return error;
-	
 #ifdef CONFIG_PROC_FS
 	mega_proc_dir_entry = proc_mkdir("megaraid", &proc_root);
 	if (!mega_proc_dir_entry) {
@@ -5130,6 +5126,13 @@
 				"megaraid: failed to create megaraid root\n");
 	}
 #endif
+	error = pci_module_init(&megaraid_pci_driver);
+	if (error) {
+#ifdef CONFIG_PROC_FS
+		remove_proc_entry("megaraid", &proc_root);
+#endif
+		return error;
+	}
 
 	/*
 	 * Register the driver as a character device, for applications

--Apple-Mail-28--330123604--

--Apple-Mail-29--330123600
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFATteLtch0EvEFvxURAtAtAJ90FbiZdfnCt92zSZ7GQnwYY3KPiACfatzJ
GHvDKKA/MvfurECfjj36zCY=
=8mF8
-----END PGP SIGNATURE-----

--Apple-Mail-29--330123600--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWD2RkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWD2RkK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 13:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWD2RkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 13:40:10 -0400
Received: from main.gmane.org ([80.91.229.2]:36811 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750768AbWD2RkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 13:40:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Schweizer <genstef@gentoo.org>
Subject: [PATCH 2.6.17-rc3] Fix capi reload by unregistering the correct major
Followup-To: gmane.linux.isdn.i4l.devel
Date: Sat, 29 Apr 2006 19:25:12 +0200
Message-ID: <e307i4$f1h$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2675473.aF6Kfcu60h"
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-62-245-161-128.mnet-online.de
User-Agent: KNode/0.10.2
Cc: i4ldeveloper@listserv.isdn4linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2675473.aF6Kfcu60h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I am having the bug
FATAL: Error inserting capi ([..]/capi.ko): Device or resource busy
when I try to reload capi after loading it.
in dmesg: capi20: unable to get major 68

I attached a patch to fix the issue which is caused by setting the major to
zero when registering the chrdev succeeded. Please apply
- - Stefan

errors in the dmesg:

CAPI Subsystem Rev 1.1.2.8
capifs: Rev 1.1.2.3
capi20: Rev 1.1.2.7: started up with major 0 (middleware+capifs)
<-- here you see that it was set to 0.
(after unload and retry)
capi: Rev 1.1.2.7: unloaded
CAPI Subsystem Rev 1.1.2.8
capi20: unable to get major 68
<-- the chrdev has not been unlinked
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEU6GBNJowsmZ/PzARArMZAJ9tfOoFGJ5wNd86DA15JiaZJFLsAQCfaYr7
9XF6cTgYU7Y9hzvGLgXkJqU=
=qvpL
-----END PGP SIGNATURE-----
--nextPart2675473.aF6Kfcu60h
Content-Type: text/x-diff; name="capi"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="capi"

--- drivers/isdn/capi/capi.c.orig	2006-04-29 18:40:25.000000000 +0200
+++ drivers/isdn/capi/capi.c	2006-04-29 18:27:22.000000000 +0200
@@ -1499,7 +1499,6 @@
 		printk(KERN_ERR "capi20: unable to get major %d\n", capi_major);
 		return major_ret;
 	}
-	capi_major = major_ret;
 	capi_class = class_create(THIS_MODULE, "capi");
 	if (IS_ERR(capi_class)) {
 		unregister_chrdev(capi_major, "capi20");

--nextPart2675473.aF6Kfcu60h--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268889AbUJQLiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268889AbUJQLiw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 07:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269010AbUJQLiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 07:38:52 -0400
Received: from smartmx-06.inode.at ([213.229.60.38]:65466 "EHLO
	smartmx-06.inode.at") by vger.kernel.org with ESMTP id S268889AbUJQLis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 07:38:48 -0400
Subject: [PATCH] Removal of request_module in cpia.c since it causes
	deadlock with new module-init-tools
From: Peter Pregler <Peter_Pregler@email.com>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org,
       Duncan Haldane <duncan_haldane@users.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-vJeUvvgCGt/zgfESmvDg"
Message-Id: <1098013105.5136.34.camel@gretel-wlan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 13:38:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vJeUvvgCGt/zgfESmvDg
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

newer versions of module-init-tools do some locking now which leads to a
dead-lock if cpia.c does a request_module("cpia_usb/pp"). The attached
patch against 2.6.8 removes the request_module. The problem is actually
the same as is documented in debian bug #259056 which was caused by alsa
autoloading some oss-modules. So I guess there might be more places in
the kernel where this new locking in the module-init-tools might lead to
dead-locks.

---
/usr/src/kernel-source-2.6.8/drivers/media/video/cpia.c.orig	2004-08-14
07:37:26.000000000 +0200
+++ /usr/src/kernel-source-2.6.8/drivers/media/video/cpia.c	2004-10-17
13:31:42.000000000 +0200
@@ -4044,22 +4044,13 @@ static int __init cpia_init(void)
 	proc_cpia_create();
 #endif
=20
-#ifdef CONFIG_KMOD
-#ifdef CONFIG_VIDEO_CPIA_PP_MODULE
-	request_module("cpia_pp");
-#endif
-
-#ifdef CONFIG_VIDEO_CPIA_USB_MODULE
-	request_module("cpia_usb");
-#endif
-#endif	/* CONFIG_KMOD */
-
 #ifdef CONFIG_VIDEO_CPIA_PP
 	cpia_pp_init();
 #endif
 #ifdef CONFIG_VIDEO_CPIA_USB
 	cpia_usb_init();
 #endif
+
 	return 0;
 }
=20


Signed-off-by: Peter Pregler <Peter_Pregler@email.com>

--=20
Ich verweigere pers=F6nliches Wirtschaftswachstum
	-- Maria Ziegelb=F6ck
-------------------------------
Email: Peter_Pregler@email.com

--=-vJeUvvgCGt/zgfESmvDg
Content-Disposition: attachment; filename=cpia-deadlock.patch
Content-Type: text/x-patch; name=cpia-deadlock.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- /usr/src/kernel-source-2.6.8/drivers/media/video/cpia.c.orig	2004-08-14 07:37:26.000000000 +0200
+++ /usr/src/kernel-source-2.6.8/drivers/media/video/cpia.c	2004-10-17 13:31:42.000000000 +0200
@@ -4044,22 +4044,13 @@ static int __init cpia_init(void)
 	proc_cpia_create();
 #endif
 
-#ifdef CONFIG_KMOD
-#ifdef CONFIG_VIDEO_CPIA_PP_MODULE
-	request_module("cpia_pp");
-#endif
-
-#ifdef CONFIG_VIDEO_CPIA_USB_MODULE
-	request_module("cpia_usb");
-#endif
-#endif	/* CONFIG_KMOD */
-
 #ifdef CONFIG_VIDEO_CPIA_PP
 	cpia_pp_init();
 #endif
 #ifdef CONFIG_VIDEO_CPIA_USB
 	cpia_usb_init();
 #endif
+
 	return 0;
 }
 

--=-vJeUvvgCGt/zgfESmvDg--


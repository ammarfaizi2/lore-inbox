Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270746AbTGNTEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270741AbTGNTEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:04:02 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:27923 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270736AbTGNTCY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:02:24 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.22-pre5] cpia.c compile-warning fix
Date: Mon, 14 Jul 2003 21:08:42 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307142108.42549.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

this patch fixes these compiletime warnings:
cpia.c:1912: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
cpia.c:1918: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
cpia.c:1924: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
cpia.c:1930: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
cpia.c:1949: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
cpia.c:1956: Warnung: concatenation of string literals with __FUNCTION__ is deprecated

- --- drivers/media/video/cpia.h.orig	2003-07-14 20:31:30.000000000 +0200
+++ drivers/media/video/cpia.h	2003-07-14 21:03:49.000000000 +0200
@@ -393,12 +393,14 @@
 /* ErrorCode */
 #define ERROR_FLICKER_BELOW_MIN_EXP     0x01 /*flicker exposure got below minimum exposure */
 
- -#define ALOG(lineno,fmt,args...) printk(fmt,lineno,##args)
- -#define LOG(fmt,args...) ALOG((__LINE__),KERN_INFO __FILE__":"__FUNCTION__"(%d):"fmt,##args)
+#define ALOG(function,lineno,fmt,args...) printk(fmt, function, lineno, ##args)
+#define LOG(fmt,args...) ALOG((__FUNCTION__), (__LINE__), \
+			      KERN_INFO __FILE__":%s(%d):"fmt, ##args)
 
 #ifdef _CPIA_DEBUG_
- -#define ADBG(lineno,fmt,args...) printk(fmt, jiffies, lineno, ##args)
- -#define DBG(fmt,args...) ADBG((__LINE__),KERN_DEBUG __FILE__"(%ld):"__FUNCTION__"(%d):"fmt,##args)
+#define ADBG(function,lineno,fmt,args...) printk(fmt, jiffies, function, lineno, ##args)
+#define DBG(fmt,args...) ADBG((__FUNCTION__), (__LINE__), \
+			      KERN_DEBUG __FILE__"(%ld):%s(%d):"fmt, ##args)
 #else
 #define DBG(fmn,args...) do {} while(0)
 #endif

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 21:03:56 up  2:14,  3 users,  load average: 1.10, 1.11, 1.23

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQE/Ev+6oxoigfggmSgRAqyZAJjHwQmFBfWP9eJuOyUTN3fU/qSYAJ9nFh0I
24mG+0/qdSLulRw159uMqw==
=IJ9d
-----END PGP SIGNATURE-----



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319719AbSIMRcx>; Fri, 13 Sep 2002 13:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319720AbSIMRct>; Fri, 13 Sep 2002 13:32:49 -0400
Received: from hermes.domdv.de ([193.102.202.1]:45325 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S319719AbSIMRcq>;
	Fri, 13 Sep 2002 13:32:46 -0400
Message-ID: <3D8222A9.8010409@domdv.de>
Date: Fri, 13 Sep 2002 19:38:49 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: urban@teststation.com
CC: linux-kernel@vger.kernel.org
Subject: compile warning fix for smb_debug.h
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020106000503000700070907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020106000503000700070907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
attached is a fix for gcc 3.2 deprecated usage warnings for __FUNCTION__ 
in smb_debug.h. As gcc 2.95.3 doesn't issue the warning and can't handle 
the new macro there's a macro selection based on the compiler major 
version. Patch is against 2.4.20pre7.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------020106000503000700070907
Content-Type: text/plain;
 name="smb_debug.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smb_debug.h.diff"

--- fs/smbfs/smb_debug.h.orig	2001-01-01 18:57:08.000000000 +0100
+++ fs/smbfs/smb_debug.h	2002-09-13 19:23:11.000000000 +0200
@@ -10,15 +10,24 @@
  * safety checks that should never happen ??? 
  * these are normally enabled.
  */
+
 #ifdef SMBFS_PARANOIA
+#if __GNUC__>=3
+#define PARANOIA(fmt,x...) printk(KERN_NOTICE "%s: " fmt, __FUNCTION__, ##x)
+#else
 #define PARANOIA(x...) printk(KERN_NOTICE __FUNCTION__ ": " x)
+#endif
 #else
 #define PARANOIA(x...) do { ; } while(0)
 #endif
 
 /* lots of debug messages */
 #ifdef SMBFS_DEBUG_VERBOSE
+#if __GNUC__>=3
+#define VERBOSE(fmt,x...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__, ##x)
+#else
 #define VERBOSE(x...) printk(KERN_DEBUG __FUNCTION__ ": " x)
+#endif
 #else
 #define VERBOSE(x...) do { ; } while(0)
 #endif
@@ -28,7 +37,11 @@
  * too common name.
  */
 #ifdef SMBFS_DEBUG
+#if __GNUC__>=3
+#define DEBUG1(fmt,x...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__, ##x)
+#else
 #define DEBUG1(x...) printk(KERN_DEBUG __FUNCTION__ ": " x)
+#endif
 #else
 #define DEBUG1(x...) do { ; } while(0)
 #endif

--------------020106000503000700070907--


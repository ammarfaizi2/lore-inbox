Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135258AbRDLTEm>; Thu, 12 Apr 2001 15:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135261AbRDLTEX>; Thu, 12 Apr 2001 15:04:23 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:55300 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S135258AbRDLTEU>; Thu, 12 Apr 2001 15:04:20 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256A2C.0068BA0C.00@smtpnotes.altec.com>
Date: Thu, 12 Apr 2001 14:03:56 -0500
Subject: badly punctuated parameter list in `#define' (2.4.3-ac5 and 2.4.4
	-pre2)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



When compiling 2.4.3-ac5 (and also 2.4.4-pre2) I get this:

/usr/src/linux-2.4.3-ac5/include/asm/rwsem.h:26: badly punctuated parameter list
 in `#define'

This appears to be due to some code in rwsem.h that is written for a different
version of gcc. (I'm still using gcc-2.91.66 as specified in
Documentation/Changes.)  It works for me if I replace it with the code in the
section labeled /* old gcc */.  Here's a patch to do that:

--- include/asm-i386/rwsem.h.old   Thu Apr 12 13:47:00 2001
+++ include/asm-i386/rwsem.h  Thu Apr 12 13:48:04 2001
@@ -21,16 +21,16 @@
 #include <linux/wait.h>

 #if RWSEM_DEBUG
-#define rwsemdebug(FMT,...) do { if (sem->debug) printk(FMT,__VA_ARGS__); }
while(0)
+//#define rwsemdebug(FMT,...) do { if (sem->debug) printk(FMT,__VA_ARGS__); }
while(0)
 #else
-#define rwsemdebug(FMT,...)
+//#define rwsemdebug(FMT,...)
 #endif

 /* old gcc */
 #if RWSEM_DEBUG
-//#define rwsemdebug(FMT, ARGS...) do { if (sem->debug) printk(FMT,##ARGS); }
while(0)
+#define rwsemdebug(FMT, ARGS...) do { if (sem->debug) printk(FMT,##ARGS); }
while(0)
 #else
-//#define rwsemdebug(FMT, ARGS...)
+#define rwsemdebug(FMT, ARGS...)
 #endif

 #ifdef CONFIG_X86_XADD



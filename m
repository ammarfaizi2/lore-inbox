Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVJJRQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVJJRQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVJJRQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:16:13 -0400
Received: from seqima.han-solo.net ([83.138.65.243]:8328 "EHLO
	seqima.han-solo.net") by vger.kernel.org with ESMTP
	id S1751070AbVJJRQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:16:10 -0400
Date: Mon, 10 Oct 2005 19:16:05 +0200
From: Georg Lippold <georg.lippold@gmx.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] 2.6.14-rc3 x86: COMMAND_LINE_SIZE
Message-ID: <20051010171605.GA7793@georg.homeunix.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>
References: <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com> <431DFEC3.1070309@zytor.com> <431E00C8.3060606@gmail.com> <4345A9F4.7040000@uni-bremen.de> <434A6220.3000608@gmx.de> <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com> <434A8082.9060202@zytor.com> <434A8CE8.2020404@gmx.de> <434A8D70.5060300@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434A8D70.5060300@zytor.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote on Mon, Oct 10, 2005 at 08:49:04AM -0700:
> I would suggest updating your patch to include x86-64 and documentation, 
> and submit it.  Other architectures will have to do this as it suits them.

As requested.

Signed-off-by: Georg Lippold <georg.lippold@gmx.de>

diff -ur linux~/Documentation/i386/boot.txt linux/Documentation/i386/boot.txt
--- linux~/Documentation/i386/boot.txt  2005-09-30 23:17:35.000000000 +0200
+++ linux/Documentation/i386/boot.txt   2005-10-10 18:53:11.000000000 +0200
@@ -236,7 +236,7 @@
 below.

 The kernel command line is a null-terminated string currently up to
-255 characters long, plus the final null.  A string that is too long
+1023 characters long, plus the final null.  A string that is too long
 will be automatically truncated by the kernel, a boot loader may allow
 a longer command line to be passed to permit future kernels to extend
 this limit.
diff -ur linux~/Documentation/x86_64/boot-options.txt linux/Documentation/x86_64/boot-options.txt
--- linux~/Documentation/x86_64/boot-options.txt        2005-09-30 23:17:35.000000000 +0200
+++ linux/Documentation/x86_64/boot-options.txt 2005-10-10 18:55:26.000000000 +0200
@@ -3,6 +3,9 @@
 There are many others (usually documented in driver documentation), but
 only the AMD64 specific ones are listed here.

+The kernel command line (/proc/cmdline) can have up to 1023 characters
+plus the terminating \0.
+
 Machine check

    mce=off disable machine check
diff -ur linux~/include/asm-i386/param.h linux/include/asm-i386/param.h
--- linux~/include/asm-i386/param.h     2005-09-30 23:17:35.000000000 +0200
+++ linux/include/asm-i386/param.h      2005-10-10 18:50:43.000000000 +0200
@@ -20,6 +20,6 @@
 #endif

 #define MAXHOSTNAMELEN 64      /* max length of hostname */
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 1024

 #endif
diff -ur linux~/include/asm-i386/setup.h linux/include/asm-i386/setup.h
--- linux~/include/asm-i386/setup.h     2005-09-30 23:17:35.000000000 +0200
+++ linux/include/asm-i386/setup.h      2005-10-10 18:50:09.000000000 +0200
@@ -17,7 +17,7 @@
 #define MAX_NONPAE_PFN (1 << 20)

 #define PARAM_SIZE 4096
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 1024

 #define OLD_CL_MAGIC_ADDR      0x90020
 #define OLD_CL_MAGIC           0xA33F
diff -ur linux~/include/asm-x86_64/setup.h linux/include/asm-x86_64/setup.h
--- linux~/include/asm-x86_64/setup.h   2005-09-30 23:17:35.000000000 +0200
+++ linux/include/asm-x86_64/setup.h    2005-10-10 18:51:19.000000000 +0200
@@ -1,6 +1,6 @@
 #ifndef _x8664_SETUP_H
 #define _x8664_SETUP_H

-#define COMMAND_LINE_SIZE      256
+#define COMMAND_LINE_SIZE      1024

 #endif


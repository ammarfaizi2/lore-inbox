Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267011AbTAPEfH>; Wed, 15 Jan 2003 23:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTAPEfH>; Wed, 15 Jan 2003 23:35:07 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:1001 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP
	id <S267011AbTAPEfG>; Wed, 15 Jan 2003 23:35:06 -0500
Message-ID: <3E263833.EB1C45B3@verizon.net>
Date: Wed, 15 Jan 2003 20:42:27 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] update LOG BUF SIZE config.
Content-Type: multipart/mixed;
 boundary="------------0D17B7940E6287DFD0F63756"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out003.verizon.net from [4.64.197.173] at Wed, 15 Jan 2003 22:43:56 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0D17B7940E6287DFD0F63756
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

The current LOG_BUF size is a bit confusing the first
time that "make oldconfig" is used.  It's difficult to
select anything other than the default value.

Also, you (Linus) expressed a desire to have this
configurable only if DEBUG_KERNEL or "kernel hacking"
was enabled, so I've changed it to accomplish that.

This patch also uses Kconfig in a way that Roman intended
since a patch in 2.5.52 which enables default values if
a prompt is not enabled, but lets values be chosen when
the prompt is enabled.  You also asked for this in setting
this config option.

Please apply to 2.5.58.

Thanks,
~Randy
--------------0D17B7940E6287DFD0F63756
Content-Type: text/plain; charset=us-ascii;
 name="lgbuf-2554bk4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lgbuf-2554bk4.patch"

--- ./init/Kconfig%LGBUF	Mon Jan  6 16:01:55 2003
+++ ./init/Kconfig	Mon Jan  6 16:38:35 2003
@@ -82,50 +82,21 @@
 	  building a kernel for install/rescue disks or your system is very
 	  limited in memory.
 
-choice
-	prompt "Kernel log buffer size"
-	default LOG_BUF_SHIFT_17 if ARCH_S390
-	default LOG_BUF_SHIFT_16 if X86_NUMAQ || IA64
-	default LOG_BUF_SHIFT_15 if SMP
-	default LOG_BUF_SHIFT_14
-	help
-	  Select kernel log buffer size from this list (power of 2).
-	  Defaults:  17 (=> 128 KB for S/390)
-		     16 (=> 64 KB for x86 NUMAQ or IA-64)
-	             15 (=> 32 KB for SMP)
-	             14 (=> 16 KB for uniprocessor)
-
-config LOG_BUF_SHIFT_17
-	bool "128 KB"
-	default y if ARCH_S390
-
-config LOG_BUF_SHIFT_16
-	bool "64 KB"
-	default y if X86_NUMAQ || IA64
-
-config LOG_BUF_SHIFT_15
-	bool "32 KB"
-	default y if SMP
-
-config LOG_BUF_SHIFT_14
-	bool "16 KB"
-
-config LOG_BUF_SHIFT_13
-	bool "8 KB"
-
-config LOG_BUF_SHIFT_12
-	bool "4 KB"
-
-endchoice
-
 config LOG_BUF_SHIFT
-	int
-	default 17 if LOG_BUF_SHIFT_17=y
-	default 16 if LOG_BUF_SHIFT_16=y
-	default 15 if LOG_BUF_SHIFT_15=y
-	default 14 if LOG_BUF_SHIFT_14=y
-	default 13 if LOG_BUF_SHIFT_13=y
-	default 12 if LOG_BUF_SHIFT_12=y
+	int "Kernel log buffer size" if DEBUG_KERNEL
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
 
 endmenu
 

--------------0D17B7940E6287DFD0F63756--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbTAGAi5>; Mon, 6 Jan 2003 19:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTAGAi5>; Mon, 6 Jan 2003 19:38:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33204 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267219AbTAGAix>;
	Mon, 6 Jan 2003 19:38:53 -0500
Date: Mon, 6 Jan 2003 16:44:11 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andrew Morton <akpm@digeo.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] configurable LOG_BUF_SIZE (update-2)
In-Reply-To: <3E1A17DB.D400C900@digeo.com>
Message-ID: <Pine.LNX.4.33L2.0301061620150.15416-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003, Andrew Morton wrote:

| "Randy.Dunlap" wrote:
| >
| > ...
| >  21 files changed, 540 insertions(+), 45 deletions(-)
|
| Oh gack.   And you've got stuff like "if numaq" in the sparc64
| config files.
|
| You did have a version which instantiated a common $TOPDIR/kernel/Kconfig
| and just included that in arch/<arch>/Kconfig.  Seems a better
| approach to me.

Andrew, I don't see a need just now for the new kernel/Kconfig file
since dependency/ordering issues are (supposed to be) gone in Kconfig
vs. old config.in files.

However, having the Log Buffer size selection in only one place instead
of in 20 arch-specific files is a good thing IMO.

Here's a much smaller patch that just changes the current (2.5.54-bk4)
Kconfig to depend on DEBUG_KERNEL (could be EXPERIMENTAL though) instead
of always making it visible, and makes it one number (a shift value).

I'd like to have this version applied to 2.5.54++.  Linus, how is it?

Thanks,
-- 
~Randy




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




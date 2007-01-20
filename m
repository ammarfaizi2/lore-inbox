Return-Path: <linux-kernel-owner+w=401wt.eu-S965222AbXATHvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbXATHvh (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 02:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbXATHvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 02:51:37 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:39244 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965222AbXATHvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 02:51:36 -0500
X-Originating-Ip: 74.109.98.130
Date: Sat, 20 Jan 2007 02:45:45 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove redundant (deprecated) CONFIG_FORCED_INLINING option.
Message-ID: <Pine.LNX.4.64.0701200241340.8351@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove the superfluous kernel config option FORCED_UNLINING from the
kernel debugging menu.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  based on adrian bunk's explanation, and the fact that i just noticed
this option was scheduled for removal several months ago anyway, this
option clearly has no value.

 Documentation/feature-removal-schedule.txt |    9 ---------
 include/linux/compiler-gcc4.h              |    9 ---------
 lib/Kconfig.debug                          |   14 --------------
 3 files changed, 32 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index fc53239..bf82ef5 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -109,15 +109,6 @@ Who:	Christoph Hellwig <hch@lst.de>

 ---------------------------

-What:	CONFIG_FORCED_INLINING
-When:	June 2006
-Why:	Config option is there to see if gcc is good enough. (in january
-        2006). If it is, the behavior should just be the default. If it's not,
-	the option should just go away entirely.
-Who:    Arjan van de Ven
-
----------------------------
-
 What:   eepro100 network driver
 When:   January 2007
 Why:    replaced by the e100 driver
diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
index 6f5cc6f..8249115 100644
--- a/include/linux/compiler-gcc4.h
+++ b/include/linux/compiler-gcc4.h
@@ -3,15 +3,6 @@
 /* These definitions are for GCC v4.x.  */
 #include <linux/compiler-gcc.h>

-#ifdef CONFIG_FORCED_INLINING
-# undef inline
-# undef __inline__
-# undef __inline
-# define inline			inline		__attribute__((always_inline))
-# define __inline__		__inline__	__attribute__((always_inline))
-# define __inline		__inline	__attribute__((always_inline))
-#endif
-
 #define __attribute_used__	__attribute__((__used__))
 #define __must_check 		__attribute__((warn_unused_result))
 #define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5c26818..70a9b56 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -354,20 +354,6 @@ config FRAME_POINTER
 	  some architectures or if you use external debuggers.
 	  If you don't debug the kernel, you can say N.

-config FORCED_INLINING
-	bool "Force gcc to inline functions marked 'inline'"
-	depends on DEBUG_KERNEL
-	default y
-	help
-	  This option determines if the kernel forces gcc to inline the functions
-	  developers have marked 'inline'. Doing so takes away freedom from gcc to
-	  do what it thinks is best, which is desirable for the gcc 3.x series of
-	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
-	  disabling this option will generate a smaller kernel there. Hopefully
-	  this algorithm is so good that allowing gcc4 to make the decision can
-	  become the default in the future, until then this option is there to
-	  test gcc for this.
-
 config RCU_TORTURE_TEST
 	tristate "torture tests for RCU"
 	depends on DEBUG_KERNEL




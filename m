Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267123AbTGLCJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 22:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267207AbTGLCJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 22:09:44 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:30221 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S267123AbTGLCJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 22:09:43 -0400
Date: Fri, 11 Jul 2003 21:24:23 -0500 (CDT)
Message-Id: <200307120224.h6C2ONNR016854@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: [PATCH] Allow LBD on architectures that support it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While researching the as-iosched division last night (sorry, I slept
and went to work before sending out the patch), I noticed CONFIG_LBD
wasn't in my config file.  The following architectures appear to have
the necessary asm/types.h changes:

include/asm-i386/types.h:typedef u64 sector_t;
include/asm-mips/types.h:typedef u64 sector_t;
include/asm-ppc/types.h:typedef u64 sector_t;
include/asm-s390/types.h:typedef u64 sector_t;
include/asm-sh/types.h:typedef u64 sector_t;
include/asm-x86_64/types.h:typedef u64 sector_t;


Choosing the 32 bit versions of those I selected

X86 MIPS32 PPC32 ARCH_S390_31 SUPERH

(Yes, X86_64 wouldn't need it except for defining X86.  PARISC and SPARC
might want it, not sure about m68k and the other 32 bit architectures.
For that matter, I wonder what SuperH platform will use it.  This patch
just shows what has been merged).


===== drivers/block/Kconfig 1.5 vs edited =====
--- 1.5/drivers/block/Kconfig	Sun Apr 20 18:21:17 2003
+++ edited/drivers/block/Kconfig	Fri Jul 11 02:17:02 2003
@@ -340,7 +340,7 @@
 
 config LBD
 	bool "Support for Large Block Devices"
-	depends on X86
+	depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH
 	help
 	  Say Y here if you want to attach large (bigger than 2TB) discs to
 	  your machine, or if you want to have a raid or loopback device

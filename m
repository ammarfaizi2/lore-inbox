Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161284AbWBUCad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161284AbWBUCad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 21:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161285AbWBUCad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 21:30:33 -0500
Received: from mail.renesas.com ([202.234.163.13]:12698 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1161284AbWBUCac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 21:30:32 -0500
Date: Tue, 21 Feb 2006 11:30:28 +0900 (JST)
Message-Id: <20060221.113028.796986944.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.16-rc3] m32r: enable asm code optimization
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add -O2 option to AFLAGS to enable asm code optimization for m32r.

On m32r gas, "-m32r2 -O" option enables assembler's parallel code
generation optimization for M32R2 ISA as a default.
So, "-no-parallel" option is required explicitly for a cpu core
with single instuction issuing, for example, VDEC2.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/sys_m32r.c |   61 ++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

 arch/m32r/Makefile |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/arch/m32r/Makefile
===================================================================
--- b.orig/arch/m32r/Makefile	2005-11-03 17:16:58.483118728 +0900
+++ b/arch/m32r/Makefile	2005-11-03 18:17:20.683460576 +0900
@@ -12,14 +12,14 @@ CFLAGS_MODULE += -mmodel=large
 
 ifdef CONFIG_CHIP_VDEC2
 cflags-$(CONFIG_ISA_M32R2)	+= -DNO_FPU -Wa,-bitinst
-aflags-$(CONFIG_ISA_M32R2)	+= -DNO_FPU -Wa,-bitinst
+aflags-$(CONFIG_ISA_M32R2)	+= -DNO_FPU -O2 -Wa,-bitinst -Wa,-no-parallel
 else
 cflags-$(CONFIG_ISA_M32R2)	+= -DNO_FPU -m32r2
-aflags-$(CONFIG_ISA_M32R2)	+= -DNO_FPU -m32r2
+aflags-$(CONFIG_ISA_M32R2)	+= -DNO_FPU -m32r2 -O2
 endif
 
 cflags-$(CONFIG_ISA_M32R)	+= -DNO_FPU
-aflags-$(CONFIG_ISA_M32R)	+= -DNO_FPU -Wa,-no-bitinst
+aflags-$(CONFIG_ISA_M32R)	+= -DNO_FPU -O2 -Wa,-no-bitinst
 
 CFLAGS += $(cflags-y)
 AFLAGS += $(aflags-y)

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/


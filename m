Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVDUXI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVDUXI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 19:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVDUXI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 19:08:29 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:45241 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261665AbVDUXIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 19:08:21 -0400
Subject: [PATCH] fix subarch breakage in amd dual core updates
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ak@suse.de, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 19:08:02 -0400
Message-Id: <1114124883.5054.51.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch to arch/i386/kernel/cpu/amd.c relies on the variable
cpu_core_id which is defined in i386/kernel/smpboot.c.  This means it is
only present if CONFIG_X86_SMP is defined, not CONFIG_SMP (alternative
SMP harnesses won't have it, which is why it breaks voyager).

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

arch/i386/kernel/cpu/amd.c: 8d182e875cd72e64b49869386bf090ba23df6793
--- a/arch/i386/kernel/cpu/amd.c
+++ b/arch/i386/kernel/cpu/amd.c
@@ -24,7 +24,7 @@ __asm__(".align 4\nvide: ret");
 
 static void __init init_amd(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_SMP
 	int cpu = c == &boot_cpu_data ? 0 : c - cpu_data;
 #endif
 	u32 l, h;
@@ -198,7 +198,7 @@ static void __init init_amd(struct cpuin
 			c->x86_num_cores = 1;
 	}
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_SMP
 	/*
 	 * On a AMD dual core setup the lower bits of the APIC id
 	 * distingush the cores.  Assumes number of cores is a power



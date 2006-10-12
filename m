Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750698AbWJLTPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbWJLTPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWJLTPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:15:51 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:1927 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1750698AbWJLTPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:15:50 -0400
Date: Thu, 12 Oct 2006 12:17:52 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch] 2.6.19-rc1: Fix build breakage with CONFIG_X86_VSMP
Message-ID: <20061012191752.GA3775@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
2.6.19-rc1 does not compile with CONFIG_X86_VSMP.  

arch/x86_64/kernel/built-in.o(.init.text+0xab13): In function `vsmp_init':
arch/x86_64/kernel/vsmp.c:32: undefined reference to `ioremap'
arch/x86_64/kernel/built-in.o(.init.text+0xab24):arch/x86_64/kernel/vsmp.c:33:
undefined reference to `readl'

Probably due to some header file cleanups in 2.6.19-rc1. Please apply this fix.

Thanks,
Kiran

---
From: Ravikiran Thirumalai <kiran@scalex86.org>

Kernel build breaks with CONFIG_X86_VSMP.  Probably due to some header file 
cleanups in 2.6.19-rc1.  

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.19-rc1/arch/x86_64/kernel/vsmp.c
===================================================================
--- linux-2.6.19-rc1.orig/arch/x86_64/kernel/vsmp.c	2006-10-09 21:03:36.000000000 -0700
+++ linux-2.6.19-rc1/arch/x86_64/kernel/vsmp.c	2006-10-09 21:12:06.000000000 -0700
@@ -14,6 +14,7 @@
 #include <linux/pci_ids.h>
 #include <linux/pci_regs.h>
 #include <asm/pci-direct.h>
+#include <asm/io.h>
 
 static int __init vsmp_init(void)
 {

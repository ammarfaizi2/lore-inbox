Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVFUQoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVFUQoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVFUQcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:32:13 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:58095 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262182AbVFUQ2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:28:16 -0400
Date: Tue, 21 Jun 2005 18:28:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 10/16] s390: kernel stack overflow panic.
Message-ID: <20050621162818.GJ6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 10/16] s390: kernel stack overflow panic.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

die() doesn't return, therefore print registers and then panic instead.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/traps.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2005-06-21 17:36:52.000000000 +0200
@@ -668,7 +668,10 @@ asmlinkage void space_switch_exception(s
 
 asmlinkage void kernel_stack_overflow(struct pt_regs * regs)
 {
-	die("Kernel stack overflow", regs, 0);
+	bust_spinlocks(1);
+	printk("Kernel stack overflow.\n");
+	show_regs(regs);
+	bust_spinlocks(0);
 	panic("Corrupt kernel stack, can't continue.");
 }
 

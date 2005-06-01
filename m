Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVFASgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVFASgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVFASGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:06:15 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:53684 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261522AbVFASDm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:03:42 -0400
Date: Wed, 1 Jun 2005 20:03:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 7/11] s390: kernel stack overflow panic.
Message-ID: <20050601180342.GG6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 7/11] s390: kernel stack overflow panic.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

die() doesn't return, therefore print registers and then panic instead.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/traps.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2005-03-02 08:37:55.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2005-06-01 19:43:19.000000000 +0200
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
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932759AbWAKB27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbWAKB27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbWAKB27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:28:59 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:30960 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S932759AbWAKB26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:28:58 -0500
Date: Tue, 10 Jan 2006 17:28:48 -0800
Message-Id: <200601110128.k0B1Smvi025723@dhcp153.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
       mlachwani@mvista.com
Subject: [PATCH] enable soft-irq state w/ raw state 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	MIPS needs this due to PF_IRQSOFF being set in the 
flags during start_kernel() .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.15/init/main.c
===================================================================
--- linux-2.6.15.orig/init/main.c
+++ linux-2.6.15/init/main.c
@@ -515,6 +515,7 @@ asmlinkage void __init start_kernel(void
 	 * Soft IRQ state will be enabled with the hard state.
 	 */
 	raw_local_irq_enable();
+	local_irq_enable();
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&

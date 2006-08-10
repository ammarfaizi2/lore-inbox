Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWHJUYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWHJUYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWHJUO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:58 -0400
Received: from ns.suse.de ([195.135.220.2]:38544 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932324AbWHJTgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:12 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [55/145] i386/x86-64: Remove obsolete sanity check in mptable parsing
Message-Id: <20060810193610.3ACD713C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:10 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

It apparently has never triggered in many years.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/mpparse.c   |   13 -------------
 arch/x86_64/kernel/mpparse.c |   13 -------------
 2 files changed, 26 deletions(-)

Index: linux/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mpparse.c
+++ linux/arch/x86_64/kernel/mpparse.c
@@ -223,19 +223,6 @@ static void __init MP_lintsrc_info (stru
 			m->mpc_irqtype, m->mpc_irqflag & 3,
 			(m->mpc_irqflag >> 2) &3, m->mpc_srcbusid,
 			m->mpc_srcbusirq, m->mpc_destapic, m->mpc_destapiclint);
-	/*
-	 * Well it seems all SMP boards in existence
-	 * use ExtINT/LVT1 == LINT0 and
-	 * NMI/LVT2 == LINT1 - the following check
-	 * will show us if this assumptions is false.
-	 * Until then we do not have to add baggage.
-	 */
-	if ((m->mpc_irqtype == mp_ExtINT) &&
-		(m->mpc_destapiclint != 0))
-			BUG();
-	if ((m->mpc_irqtype == mp_NMI) &&
-		(m->mpc_destapiclint != 1))
-			BUG();
 }
 
 /*
Index: linux/arch/i386/kernel/mpparse.c
===================================================================
--- linux.orig/arch/i386/kernel/mpparse.c
+++ linux/arch/i386/kernel/mpparse.c
@@ -294,19 +294,6 @@ static void __init MP_lintsrc_info (stru
 			m->mpc_irqtype, m->mpc_irqflag & 3,
 			(m->mpc_irqflag >> 2) &3, m->mpc_srcbusid,
 			m->mpc_srcbusirq, m->mpc_destapic, m->mpc_destapiclint);
-	/*
-	 * Well it seems all SMP boards in existence
-	 * use ExtINT/LVT1 == LINT0 and
-	 * NMI/LVT2 == LINT1 - the following check
-	 * will show us if this assumptions is false.
-	 * Until then we do not have to add baggage.
-	 */
-	if ((m->mpc_irqtype == mp_ExtINT) &&
-		(m->mpc_destapiclint != 0))
-			BUG();
-	if ((m->mpc_irqtype == mp_NMI) &&
-		(m->mpc_destapiclint != 1))
-			BUG();
 }
 
 #ifdef CONFIG_X86_NUMAQ

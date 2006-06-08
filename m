Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWFHMDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWFHMDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 08:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWFHMDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 08:03:41 -0400
Received: from www.osadl.org ([213.239.205.134]:35553 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751286AbWFHMDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 08:03:41 -0400
Subject: [PATCH] genirq: Fix missing initializer for unmask in no_irq_chip
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060608113534.GA5050@flint.arm.linux.org.uk>
References: <20060517001310.GA12877@elte.hu>
	 <20060517221536.GA13444@elte.hu> <20060519145225.GA12703@elte.hu>
	 <20060607165456.GC13165@flint.arm.linux.org.uk>
	 <1149700829.5257.16.camel@localhost.localdomain>
	 <1149706650.5257.19.camel@localhost.localdomain>
	 <20060608113534.GA5050@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 14:04:15 +0200
Message-Id: <1149768256.5257.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 12:35 +0100, Russell King wrote:
> Okay, works on Versatile (which is a trivial platform) it doesn't work
> on Neponset (a rather more complex setup).  Neponset has a case where
> there's an interrupt "concentrator" which consists of logically ORing
> three interrupt sources, and providing a status register so you know
> which occurred.
> 
> Hence, there is no "chip" for this, and while it works with the ARM
> IRQ subsystem, it doesn't even boot with the genirq stuff.
> 
> This doesn't happen with the ARM IRQ subsystem because the "no chip"
> handlers are all pointing at a dummy function instead of being NULL.
> Could we do the same with genirq ?

We missed to initialize unmask, which causes problems on neponset.

Signed-off-by: Thomas Gleixner <tglx@linutronix,de>

Index: linux-2.6.17-rc6/kernel/irq/handle.c
===================================================================
--- linux-2.6.17-rc6.orig/kernel/irq/handle.c	2006-06-08 13:57:57.000000000 +0200
+++ linux-2.6.17-rc6/kernel/irq/handle.c	2006-06-08 13:55:56.000000000 +0200
@@ -92,6 +92,7 @@
 	.enable		= noop,
 	.disable	= noop,
 	.ack		= ack_bad,
+	.unmask		= noop,
 	.end		= noop,
 };
 



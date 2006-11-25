Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967173AbWKYUjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967173AbWKYUjx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967166AbWKYUjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:39:53 -0500
Received: from 1wt.eu ([62.212.114.60]:43524 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S967173AbWKYUjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:39:52 -0500
Date: Sat, 25 Nov 2006 22:30:47 +0100
From: Willy Tarreau <w@1wt.eu>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
Subject: [PATCH-2.4] arm: incorrect use of "&&" instead of "&"
Message-ID: <20061125213047.GA5950@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

I'm about to merge this fix into 2.4. It's already been fixed in 2.6.
Do you have any objection ?

BTW, I have two email addresses for you, the one in the MAINTAINERS file
and the one you use on LKML. Which one do you prefer ? Just in case, I've
used both.

Thanks in advance,
Willy


>From f3779aa6e0b38c0dfdad4f98b6bcddcd570b6aa7 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sat, 25 Nov 2006 22:00:12 +0100
Subject: [PATCH] arm: incorrect use of "&&" instead of "&"

In integrator_init_irq(), the use of "&&" in the following
statement causes all interrupts to be marked valid regardless
of INTEGRATOR_SC_VALID_INT, as long as it's non-zero :

     if (((1 << i) && INTEGRATOR_SC_VALID_INT) != 0)

Obvious fix is to replace it with "&". This was already fixed
in 2.6.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/arm/mach-integrator/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-integrator/irq.c b/arch/arm/mach-integrator/irq.c
index 69d2e67..cc56534 100644
--- a/arch/arm/mach-integrator/irq.c
+++ b/arch/arm/mach-integrator/irq.c
@@ -55,7 +55,7 @@ void __init integrator_init_irq(void)
 	unsigned int i;
 
 	for (i = 0; i < NR_IRQS; i++) {
-	        if (((1 << i) && INTEGRATOR_SC_VALID_INT) != 0) {
+	        if (((1 << i) & INTEGRATOR_SC_VALID_INT) != 0) {
 		        irq_desc[i].valid	= 1;
 			irq_desc[i].probe_ok	= 1;
 			irq_desc[i].mask_ack	= sc_mask_irq;
-- 
1.4.2.4


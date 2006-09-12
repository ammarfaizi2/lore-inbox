Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWILTgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWILTgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWILTgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:36:16 -0400
Received: from rubidium.solidboot.com ([81.22.244.175]:52161 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S1030223AbWILTgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:36:16 -0400
Date: Tue, 12 Sep 2006 22:36:14 +0300
From: Imre =?iso-8859-1?Q?De=E1k?= <imre.deak@solidboot.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de
Subject: [PATCH] genirq: fix typo in IRQ resend
Message-ID: <20060912193614.GA7202@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug where the IRQ_PENDING flag is never cleared and the ISR is
called endlessly without an actual interrupt.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 kernel/irq/resend.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 872f91b..35f10f7 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -63,8 +63,7 @@ void check_irq_resend(struct irq_desc *d
 	desc->chip->enable(irq);
 
 	if ((status & (IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
-		desc->status &= ~IRQ_PENDING;
-		desc->status = status | IRQ_REPLAY;
+		desc->status = (status & ~IRQ_PENDING) | IRQ_REPLAY;
 
 		if (!desc->chip || !desc->chip->retrigger ||
 					!desc->chip->retrigger(irq)) {
-- 
1.4.1


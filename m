Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWGTQCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWGTQCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 12:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWGTQCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 12:02:53 -0400
Received: from hoboe2bl1.telenet-ops.be ([195.130.137.73]:48549 "EHLO
	hoboe2bl1.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1030354AbWGTQCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 12:02:51 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: dustin@sensoria.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smc911x: Re-release spinlock on spurious interrupt
References: <87psg1hqp8.fsf@slug.be.48ers.dk>
Date: Thu, 20 Jul 2006 06:01:47 +0200
In-Reply-To: <87psg1hqp8.fsf@slug.be.48ers.dk> (Peter Korsgaard's message of
	"Thu, 20 Jul 2006 05:59:15 +0200")
Message-ID: <87hd1cj55g.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:

 Peter> Hi,
 Peter> The smc911x driver forgets to release the spinlock on spurious
 Peter> interrupts. This little patch fixes it.

Crap - forgot to sign off :/

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

diff -Naur linux-2.6.18-rc2.orig/drivers/net/smc911x.c linux-2.6.18-rc2/drivers/net/smc911x.c
--- linux-2.6.18-rc2.orig/drivers/net/smc911x.c	2006-07-20 10:26:20.000000000 +0200
+++ linux-2.6.18-rc2/drivers/net/smc911x.c	2006-07-20 17:44:26.000000000 +0200
@@ -1092,6 +1092,7 @@
 	/* Spurious interrupt check */
 	if ((SMC_GET_IRQ_CFG() & (INT_CFG_IRQ_INT_ | INT_CFG_IRQ_EN_)) !=
 		(INT_CFG_IRQ_INT_ | INT_CFG_IRQ_EN_)) {
+		spin_unlock_irqrestore(&lp->lock, flags);
 		return IRQ_NONE;
 	}

-- 
Bye, Peter Korsgaard

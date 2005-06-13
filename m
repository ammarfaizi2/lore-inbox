Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVFMS6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVFMS6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVFMS6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:58:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46254 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261216AbVFMS6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:58:03 -0400
Date: Mon, 13 Jun 2005 20:56:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network driver disabled interrupts in PREEMPT_RT
Message-ID: <20050613185642.GA12463@elte.hu>
References: <1118688347.5792.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118688347.5792.12.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Kristian Benoit <kbenoit@opersys.com> wrote:

> Hi,
> I got lots of these messages when accessing the net running
> 2.6.12-rc6-RT-V0.7.48-25 :
> 
> "network driver disabled interrupts: tg3_start_xmit+0x0/0x629 [tg3]"
> 
> it seem to come from net/sched/sch_generic.c.

does the patch below fix it?

	Ingo

--- linux/drivers/net/tg3.c.orig
+++ linux/drivers/net/tg3.c
@@ -3242,9 +3242,9 @@ static int tg3_start_xmit(struct sk_buff
 	 * So we really do need to disable interrupts when taking
 	 * tx_lock here.
 	 */
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (!spin_trylock(&tp->tx_lock)) { 
-		local_irq_restore(flags);
+		local_irq_restore_nort(flags);
 		return NETDEV_TX_LOCKED; 
 	} 
 

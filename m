Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVAJBGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVAJBGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 20:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVAJBGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 20:06:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64519 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262027AbVAJBGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 20:06:17 -0500
Date: Mon, 10 Jan 2005 01:06:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [2/3]
Message-ID: <20050110010613.A5825@flint.arm.linux.org.uk>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20050110013508.1.patchmail@tglx> <1105318406.17853.2.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1105318406.17853.2.camel@tglx.tec.linutronix.de>; from tglx@linutronix.de on Mon, Jan 10, 2005 at 01:53:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 01:53:26AM +0100, Thomas Gleixner wrote:
> This patch adjusts the ARM entry code to use the fixed up
> preempt_schedule() handling in 2.6.10-mm2

Looks PPCish to me.

> Signed-off-by: Benedikt Spranger <bene@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  entry-armv.S |    4 +---
>  1 files changed, 1 insertion(+), 3 deletions(-)
> ---
> Index: 2.6.10-mm1/arch/ppc/kernel/entry.S
> ===================================================================
> --- 2.6.10-mm1/arch/ppc/kernel/entry.S	(revision 141)
> +++ 2.6.10-mm1/arch/ppc/kernel/entry.S	(working copy)
> @@ -624,12 +624,12 @@
>  	beq+	restore
>  	andi.	r0,r3,MSR_EE	/* interrupts off? */
>  	beq	restore		/* don't schedule if so */
> -1:	lis	r0,PREEMPT_ACTIVE@h
> +1:	li	r0,1
>  	stw	r0,TI_PREEMPT(r9)
>  	ori	r10,r10,MSR_EE
>  	SYNC
>  	MTMSRD(r10)		/* hard-enable interrupts */
> -	bl	schedule
> +	bl	entry_preempt_schedule
>  	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
>  	SYNC
>  	MTMSRD(r10)		/* disable interrupts */
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

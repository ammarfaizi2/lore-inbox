Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVAJK54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVAJK54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 05:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVAJK54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 05:57:56 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:2961
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262203AbVAJK5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 05:57:43 -0500
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [2/3] Resend
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+lkml@arm.linux.org.uk, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20050109233253.42318137.akpm@osdl.org>
References: <20050110013508.1.patchmail@tglx>
	 <1105318406.17853.2.camel@tglx.tec.linutronix.de>
	 <20050110010613.A5825@flint.arm.linux.org.uk>
	 <1105319915.17853.8.camel@tglx.tec.linutronix.de>
	 <20050109233253.42318137.akpm@osdl.org>
Content-Type: text/plain
Organization: Linutronix
Message-Id: <1105354664.3058.8.camel@lap02.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 Jan 2005 11:57:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 08:32, Andrew Morton wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > This patch adjusts the ARM entry code to use the fixed up
> >  preempt_schedule() handling in 2.6.10-mm2
> > 
> > ...
> >  Index: 2.6.10-mm1/arch/arm/kernel/entry.S
> 
> There's no such file.  I assumed you meant entry-armv.S and ended up with
> the below.

Oops. I messed that up twice. Sure it was entry-armv.S
Sorry. I'm just a perfect example for Murphy's law.

tglx

> --- 25/arch/arm/kernel/entry-armv.S~use-the-new-preemption-code-arm	2005-01-09 23:30:34.794573320 -0800
> +++ 25-akpm/arch/arm/kernel/entry-armv.S	2005-01-09 23:30:34.797572864 -0800
> @@ -136,10 +136,8 @@ svc_preempt:	teq	r9, #0				@ was preempt
>  		ldr	r1, [r6, #8]			@ local_bh_count
>  		adds	r0, r0, r1
>  		movne	pc, lr
> -		mov	r7, #PREEMPT_ACTIVE
> -		str	r7, [r8, #TI_PREEMPT]		@ set PREEMPT_ACTIVE
>  1:		enable_irq r2				@ enable IRQs
> -		bl	schedule
> +               bl      entry_preempt_schedule
>  		disable_irq r0				@ disable IRQs
>  		ldr	r0, [r8, #TI_FLAGS]		@ get new tasks TI_FLAGS
>  		tst	r0, #_TIF_NEED_RESCHED
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVAMAGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVAMAGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVAMACf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 19:02:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:37576 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261361AbVAMABL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 19:01:11 -0500
Date: Wed, 12 Jan 2005 16:05:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-mm2 Resend] Fix preemption race [1/3] (Core/i386)
Message-Id: <20050112160549.07e07a78.akpm@osdl.org>
In-Reply-To: <20050112124910.1.patchmail@tglx>
References: <20050112124910.1.patchmail@tglx>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tglx@linutronix.de wrote:
>
> --- 2.6.10-mm2/arch/i386/kernel/entry.S	(revision 148)
> +++ 2.6.10-mm2/arch/i386/kernel/entry.S	(working copy)
> @@ -189,6 +189,7 @@
>  
>  #ifdef CONFIG_PREEMPT
>  ENTRY(resume_kernel)
> +	cli
>  	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
>  	jnz restore_all
>  need_resched:
> @@ -197,10 +198,7 @@
>  	jz restore_all
>  	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
>  	jz restore_all
> -	sti
> -	call preempt_schedule
> -	cli
> -	movl $0,TI_preempt_count(%ebp)
> +	call preempt_schedule_irq(); 

whee, who needs a C compiler anyway?  Did that actually assemble?

I'll fix that one up ;)

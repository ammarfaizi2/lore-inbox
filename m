Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760279AbWLFHAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760279AbWLFHAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 02:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760282AbWLFHAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 02:00:53 -0500
Received: from www.osadl.org ([213.239.205.134]:51149 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760279AbWLFHAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 02:00:51 -0500
Subject: Re: +
	cpei-gets-warning-at-kernel-irq-migrationc27-move_masked_irq.patch added to
	-mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: akpm@osdl.org
Cc: seto.hidetoshi@jp.fujitsu.com, arjan@infradead.org, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200612060644.kB66ihYx025965@shell0.pdx.osdl.net>
References: <200612060644.kB66ihYx025965@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 08:03:57 +0100
Message-Id: <1165388637.24604.175.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 22:44 -0800, akpm@osdl.org wrote:
> It works, the warning disappeared and irqbalance still runs well.
> 
> Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> Cc: Arjan van de Ven <arjan@infradead.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Good catch.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

> 
>  kernel/irq/proc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN kernel/irq/proc.c~cpei-gets-warning-at-kernel-irq-migrationc27-move_masked_irq kernel/irq/proc.c
> --- a/kernel/irq/proc.c~cpei-gets-warning-at-kernel-irq-migrationc27-move_masked_irq
> +++ a/kernel/irq/proc.c
> @@ -54,7 +54,8 @@ static int irq_affinity_write_proc(struc
>  	unsigned int irq = (int)(long)data, full_count = count, err;
>  	cpumask_t new_value, tmp;
>  
> -	if (!irq_desc[irq].chip->set_affinity || no_irq_affinity)
> +	if (!irq_desc[irq].chip->set_affinity || no_irq_affinity ||
> +				CHECK_IRQ_PER_CPU(irq_desc[irq].status))
>  		return -EIO;
>  
>  	err = cpumask_parse_user(buffer, count, new_value);
> _
> 
> Patches currently in -mm which might be from seto.hidetoshi@jp.fujitsu.com are
> 
> cpei-gets-warning-at-kernel-irq-migrationc27-move_masked_irq.patch
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266712AbUGLEOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266712AbUGLEOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 00:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266713AbUGLEOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 00:14:52 -0400
Received: from ozlabs.org ([203.10.76.45]:32183 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266712AbUGLEOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 00:14:51 -0400
Date: Mon, 12 Jul 2004 10:02:19 +1000
From: Anton Blanchard <anton@samba.org>
To: Shai Fultheim <shai@scalex86.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Jes Sorensen'" <jes@trained-monkey.org>, mort@wildopensource.com
Subject: Re: [PATCH] PER_CPU [4/4] - PER_CPU-irq_stat
Message-ID: <20040712000218.GC30109@krispykreme>
References: <S264774AbUGIJyY/20040709095424Z+26@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S264774AbUGIJyY/20040709095424Z+26@vger.kernel.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Please find below one out of collection of patched that move NR_CPU array 
> variables to the per-cpu area.  Please consider applying, any comment will
> highly appreciated.

...

> diff -Nru a/kernel/softirq.c b/kernel/softirq.c
> --- a/kernel/softirq.c	2004-07-09 01:34:13 -07:00
> +++ b/kernel/softirq.c	2004-07-09 01:34:13 -07:00
> @@ -36,8 +36,8 @@
>   */
>  
>  #ifndef __ARCH_IRQ_STAT
> -irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
> -EXPORT_SYMBOL(irq_stat);
> +DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
> +EXPORT_PER_CPU_SYMBOL(irq_stat);
>  #endif

Is there a need for the cacheline alignment? We want to keep that per
cpu data area as packed as possible, we only want to explicitly pad if
we need to (eg other cpus are accessing that variable a lot).

Also it looks like we will have to push the above change into the other
architectures.

Anton

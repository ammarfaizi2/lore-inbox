Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270430AbTHLOxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270385AbTHLOxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:53:10 -0400
Received: from [213.95.15.193] ([213.95.15.193]:4878 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S270430AbTHLOwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:52:55 -0400
Date: Tue, 12 Aug 2003 16:52:23 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH][2.6-mm] cpumask_t - ioapic set_ioapic_affinity
Message-ID: <20030812145223.GA18538@wotan.suse.de>
References: <Pine.LNX.4.53.0308120138400.26153@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308120138400.26153@montezuma.mastecende.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
> +static void set_ioapic_affinity (unsigned int irq, cpumask_t mask)
>  {
>  	unsigned long flags;
> +	unsigned int dest;
> +
> +	dest = cpu_mask_to_apicid(mk_cpumask_const(mask));
> +
>  	/*
>  	 * Only the first 8 bits are valid.
>  	 */
> -	mask = mask << 24;
> +	dest = dest << 24;
>  
>  	spin_lock_irqsave(&ioapic_lock, flags);
> -	__DO_ACTION(1, = mask, )
> +	__DO_ACTION(1, = dest, )
>  	spin_unlock_irqrestore(&ioapic_lock, flags);

Looks ok.

-Andi

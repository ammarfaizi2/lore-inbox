Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVEXSPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVEXSPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVEXSPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:15:49 -0400
Received: from colin.muc.de ([193.149.48.1]:61969 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261938AbVEXSP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:15:28 -0400
Date: 24 May 2005 20:15:25 +0200
Date: Tue, 24 May 2005 20:15:25 +0200
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 1/5] Kprobes: Temporary disarming of reentrant probe
Message-ID: <20050524181525.GF86233@muc.de>
References: <20050524101532.GA27215@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524101532.GA27215@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -55,6 +61,9 @@ struct kprobe {
>  	/* list of kprobes for multi-handler support */
>  	struct list_head list;
>  
> +	/*count the number of times this probe was temporarily disarmed */
> +	unsigned long nmissed;

You declare a variable.

> +
>  	/* location of the probe point */
>  	kprobe_opcode_t *addr;
>  
> diff -puN kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-generic kernel/kprobes.c
> --- linux-2.6.12-rc4-mm2/kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-generic	2005-05-24 15:28:08.000000000 +0530
> +++ linux-2.6.12-rc4-mm2-prasanna/kernel/kprobes.c	2005-05-24 15:28:08.000000000 +0530
> @@ -334,6 +334,7 @@ int register_kprobe(struct kprobe *p)
>  	}
>  	spin_lock_irqsave(&kprobe_lock, flags);
>  	old_p = get_kprobe(p->addr);
> +	p->nmissed = 0;

And then you set it to 0.

And nothing more. Surely this patch does not do anything. Looks like
some code is missing.

-Andi

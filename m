Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262885AbVHEGqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbVHEGqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbVHEGqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:46:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5793 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262885AbVHEGoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:44:30 -0400
Date: Fri, 5 Aug 2005 08:46:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Petrini <d.pensator@gmail.com>
Cc: Con Kolivas <kernel@kolivas.org>, tony@atomide.com, ck@vds.kolivas.org,
       tuukka.tikkanen@elektrobit.com, linux-kernel@vger.kernel.org,
       ilias.biris@indt.org.br
Subject: Re: [ck] [PATCH] Timer Top was: i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-ID: <20050805064617.GL9369@suse.de>
References: <200508031559.24704.kernel@kolivas.org> <9268368b050804141525539666@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9268368b050804141525539666@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04 2005, Daniel Petrini wrote:
> +static LIST_HEAD(timer_list);
> +
> +struct timer_top_info {
> +	unsigned int		func_pointer;
> +	unsigned int long	counter;
> +	struct list_head 	list;      	
> +};
> +
> +struct timer_top_info top_info;
> +
> +int account_timer(unsigned int function, struct timer_top_info * top_info)
> +{
> +	struct timer_top_info *top;
> +
> +	list_for_each_entry (top, &timer_list, list) {
> +		/* if it is in the list increment its count */
> +		if (top->func_pointer == function) {
> +			top->counter += 1;
> +			return 0;
> +		}
> +	}

What protects this list?

> +	
> +	/* if you are here then it didnt find so inserts in the list */
> +
> +	top = kmalloc(sizeof(struct timer_top_info), GFP_KERNEL);
> +	if (!top) 
> +		return -ENOMEM;

You can't use GFP_KERNEL here, you are inside the timer base lock.

-- 
Jens Axboe


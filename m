Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbUK0FJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUK0FJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUK0D5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:57:35 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262465AbUKZTbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:10 -0500
Date: Thu, 25 Nov 2004 19:18:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 16/51: Disable cache reaping during suspend.
Message-ID: <20041125181809.GF1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101295167.5805.254.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101295167.5805.254.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> I have to admit to being a little unsure as to why this is needed, but
> suspend's reliability is helped a lot by disabling cache reaping while
> suspending. Perhaps one of the mm guys will be able to enlighten me
> here. Might be SMP related.

It would be good to understand it. Rather than slowing common code... why
not down(&cache_chain_sem) in suspend2?
				Pavel

>  {
>  	struct list_head *walk;
>  
> -	if (down_trylock(&cache_chain_sem)) {
> +	if ((unlikely(test_suspend_state(SUSPEND_RUNNING))) ||
> +		(down_trylock(&cache_chain_sem))) 
> +	{
>  		/* Give up. Setup the next iteration. */
>  		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
>  		return;
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


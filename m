Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTFYB4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTFYB4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:56:37 -0400
Received: from palrel11.hp.com ([156.153.255.246]:51910 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263462AbTFYB4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:56:33 -0400
Date: Tue, 24 Jun 2003 19:10:42 -0700
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Martin Diehl <lists@mdiehl.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Provide refrigerator support for irda
Message-ID: <20030625021042.GA15753@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <16121.357.838418.87410@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16121.357.838418.87410@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 11:56:53AM +1000, Neil Brown wrote:
> 
> Hi Jean.
>  2.5.73/MAINTAINERS: IRDA SUBSYSTEM
> doesn't have an "M:" field, so I'm guessing that the P: field is close
> enough.
> 
> Without this patch, kIrDAd prevents my notebook from entering suspend
> mode.
> 
> NeilBrown

	Wow ! I knew about microwave for 802.11b, but not about
refrigerator for IrDA.
	The man for sir_kthread is Martin Diehl. He is much more
intimate with kernel tasks than me, and he has other sir_dev updates
in the pipeline.
	Martin ?

	Thanks !

	Jean

>  ----------- Diffstat output ------------
>  ./drivers/net/irda/sir_kthread.c |    3 +++
>  1 files changed, 3 insertions(+)
> 
> diff ./drivers/net/irda/sir_kthread.c~current~ ./drivers/net/irda/sir_kthread.c
> --- ./drivers/net/irda/sir_kthread.c~current~	2003-06-25 11:50:36.000000000 +1000
> +++ ./drivers/net/irda/sir_kthread.c	2003-06-25 11:51:02.000000000 +1000
> @@ -166,6 +166,9 @@ static int irda_thread(void *startup)
>  			set_task_state(current, TASK_RUNNING);
>  		remove_wait_queue(&irda_rq_queue.kick, &wait);
>  
> +		if (current->flags & PF_FREEZE)
> +			refrigerator(PF_IOTHREAD);
> +
>  		run_irda_queue();
>  	}
>  

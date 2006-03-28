Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWC1TTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWC1TTt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 14:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWC1TTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 14:19:49 -0500
Received: from www.tglx.de ([213.239.205.147]:43425 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751273AbWC1TTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 14:19:48 -0500
Subject: Re: [PATCH] Call get_time() only when necessary in
	run_hrtimer_queue
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mingo@elte.hu, roe@sgi.com,
       steiner@sgi.com, clameter@sgi.com
In-Reply-To: <20060328175511.GC13918@sgi.com>
References: <20060324175136.GA10186@sgi.com>
	 <20060324142849.5cc27edb.akpm@osdl.org> <20060328165127.GC10411@sgi.com>
	 <442974BC.30304@cosmosbay.com>  <20060328175511.GC13918@sgi.com>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 21:20:39 +0200
Message-Id: <1143573640.5344.215.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 11:55 -0600, Dimitri Sivanich wrote:
> We could the following simpler change instead:
> 
> Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>
> 
> Index: linux/kernel/hrtimer.c
> ===================================================================
> --- linux.orig/kernel/hrtimer.c	2006-03-28 11:46:45.279722496 -0600
> +++ linux/kernel/hrtimer.c	2006-03-28 11:51:36.722469752 -0600
> @@ -606,6 +606,9 @@ static inline void run_hrtimer_queue(str
>  {
>  	struct rb_node *node;
>  
> +	if (!base->first)
> +		return;
> +
>  	if (base->get_softirq_time)
>  		base->softirq_time = base->get_softirq_time();
>  

Looks much better. Can you please resubmit with a proper patch
description ?

Please add: Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

	tglx



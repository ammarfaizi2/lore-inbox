Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263661AbUD2ISm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUD2ISm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUD2ISm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:18:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63383 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263661AbUD2ISk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:18:40 -0400
Date: Thu, 29 Apr 2004 13:46:42 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040429081642.GA3663@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <OF03FE1BAD.C55CA638-ONC1256E85.0029C585-C1256E85.002A6C10@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF03FE1BAD.C55CA638-ONC1256E85.0029C585-C1256E85.002A6C10@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 09:43:21AM +0200, Martin Schwidefsky wrote:
> > Looks good except that I am wondering if idle_cpu_mask should
> > really be called nohz_cpu_mask. That is what it is, after all.
> 
> I don't thinks so. The idle_cpu_mask isn't dependent on the
> no hz timer feature. I think it would make sense to set the

Well, you own patch says this :)

> +/*
> + * In a system that switches off the HZ timer idle_cpu_mask
> + * indicates which cpus entered this state. This is used
> + * in the rcu update to wait only for active cpus. For system
> + * which do not switch off the HZ timer idle_cpu_mask should
> + * always be CPU_MASK_NONE.
> + */

IOW, idle_cpu_mask is relevant (as of now) only when the
hz timer is switched off.

> bits in idle_cpu_mask even on system that use the normal hz timer.
> The tricky part is to find a way to clear the bits again after
> a wakeup interrupt. This needs to be done before the interrupt
> function is executed, you can't do it in idle().

idle_cpu_mask does not really represent CPUs that are conventionally
called "idle", it represents the ones that have hz timer switched
off (in your patch). So, why not just call it nohz_cpu_mask ?
RCU doesn't need an idle cpu mask, it has its own mechanism
for detecting idle cpus, it just needs to know about the ones
that have hz timers switched off. If you call it nohz_cpu_mask,
then it would make sense to say that for systems which do not
switch off hz timer, nohz_cpu_mask will always be CPU_MASK_NONE.

Thanks
Dipankar

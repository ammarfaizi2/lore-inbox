Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWCXW0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWCXW0h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 17:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWCXW0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 17:26:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751502AbWCXW0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 17:26:36 -0500
Date: Fri, 24 Mar 2006 14:28:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       roe@sgi.com, steiner@sgi.com, clameter@sgi.com
Subject: Re: [PATCH] Call get_time() only when necessary in
 run_hrtimer_queue
Message-Id: <20060324142849.5cc27edb.akpm@osdl.org>
In-Reply-To: <20060324175136.GA10186@sgi.com>
References: <20060324175136.GA10186@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich <sivanich@sgi.com> wrote:
>
> It seems that run_hrtimer_queue() is calling get_time() much more often
> than it needs to.
> 
> With this patch, it only calls get_time() if there's a pending timer.
> 
> Following is from a profile done without the patch:
> kernel ticks:           30841           1.02 %
>       13572       44.01    44.01      time_interpolator_get_offset
>         155        0.50    96.91      hrtimer_run_queues
> 
> And with the patch:
> 	kernel ticks:           18334           0.58 %
>          74        0.40    97.81      hrtimer_run_queues
>          43        0.23    98.63      time_interpolator_get_offset
> 
> 

This code has been extensively redone in -mm and I am planning on sending
all that to Linus within a week.

The hrtimer rework in -mm might fix this performance problem, although from
a quick peek, perhaps not.

So could you please verify that the problem still needs fixing in
2.6.16-mm1 and if so, raise a patch against that?

Thanks.

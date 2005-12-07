Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbVLGTPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbVLGTPf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbVLGTPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:15:35 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:16005 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751778AbVLGTPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:15:32 -0500
Date: Thu, 8 Dec 2005 01:04:32 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, David Singleton <dsingleton@mvista.com>
Subject: Re: More PI issues with -rt
Message-ID: <20051207193432.GA7764@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051124195601.GA9098@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20051124195601.GA9098@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ingo/David,

Resending this as I did not get any reply.
This time I am attaching the testcases where I am noticing this
Any feedback is appreciated

	-Dinakar


On Fri, Nov 25, 2005 at 01:26:01AM +0530, Dinakar Guniguntala wrote:
> Hi,
> 
> I found that PI boosted SCHED_OTHER tasks behave like they have
> SCHED_FIFO policy, while PI boosted SCHED_RR tasks continue to
> behave like they have SCHED_RR policy. This didn't seem right
> 
> Does something like the following patch make sense?
> 
> 	-Dinakar
> 
> 

> Index: linux-2.6.14/kernel/sched.c
> ===================================================================
> --- linux-2.6.14.orig/kernel/sched.c	2005-11-25 01:24:06.000000000 +0530
> +++ linux-2.6.14/kernel/sched.c	2005-11-25 01:24:26.000000000 +0530
> @@ -2986,8 +2986,9 @@
>  		 * On PREEMPT_RT, boosted tasks will also get into this
>  		 * branch and wont get their timeslice decreased until
>  		 * they have done their work.
> +		 * Boosted SCHED_OTHER tasks round-robin as well
>  		 */
> -		if ((p->policy == SCHED_RR) && !--p->time_slice) {
> +		if ((p->policy != SCHED_FIFO) && !--p->time_slice) {
>  			p->time_slice = task_timeslice(p);
>  			p->first_time_slice = 0;
>  			set_tsk_need_resched(p);


--J2SCkAp4GZ/dPZZf
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="pitests.tar.gz"
Content-Transfer-Encoding: base64

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
bbbZZpttf5X2f3BqDKoAeAAA

--J2SCkAp4GZ/dPZZf--

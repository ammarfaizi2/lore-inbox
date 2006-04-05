Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWDEXQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWDEXQU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 19:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWDEXQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 19:16:20 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:33203 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932122AbWDEXQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 19:16:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch 2.6.16-mm2 10/9] sched throttle tree extract - kill interactive task feedback loop
Date: Thu, 6 Apr 2006 09:15:05 +1000
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <1143880124.7617.5.camel@homer> <1143883915.7617.77.camel@homer> <1144258731.7894.12.camel@homer>
In-Reply-To: <1144258731.7894.12.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604060915.07036.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 April 2006 03:38, Mike Galbraith wrote:
> Greetings,
>
> The patch below stops interactive tasks from feeding off each other
> during round-robin.
>
> With this 10th patch in place, a busy server with _default_ throttle
> settings (ie tunables may now be mostly unneeded) looks like this:

> --- linux-2.6.16-mm2/kernel/sched.c-9.export_tunables	2006-03-31
> 13:37:09.000000000 +0200 +++ linux-2.6.16-mm2/kernel/sched.c	2006-04-05
> 19:22:01.000000000 +0200 @@ -3480,7 +3480,7 @@ go_idle:
>  	queue = array->queue + idx;
>  	next = list_entry(queue->next, task_t, run_list);
>
> -	if (!rt_task(next) && interactive_sleep(next->sleep_type)) {
> +	if (!TASK_INTERACTIVE(next) && interactive_sleep(next->sleep_type)) {

You can't remove that rt_task check from there can you? We shouldn't ever 
requeue a rt task.

Cheers,
Con

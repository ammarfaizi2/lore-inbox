Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWEZLJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWEZLJq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWEZLJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:09:46 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:2723 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751393AbWEZLJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:09:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
Date: Fri, 26 May 2006 21:09:20 +1000
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605262109.20808.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 14:20, Peter Williams wrote:
> These patches implement CPU usage rate limits for tasks.
>
> Although the rlimit mechanism already has a CPU usage limit (RLIMIT_CPU)
> it is a total usage limit and therefore (to my mind) not very useful.
> These patches provide an alternative whereby the (recent) average CPU
> usage rate of a task can be limited to a (per task) specified proportion
> of a single CPU's capacity.  The limits are specified in parts per
> thousand and come in two varieties -- hard and soft.  The difference
> between the two is that the system tries to enforce hard caps regardless
> of the other demand for CPU resources but allows soft caps to be
> exceeded if there are spare CPU resources available.  By default, tasks
> will have both caps set to 1000 (i.e. no limit) but newly forked tasks
> will inherit any caps that have been imposed on their parent from the
> parent.  The mimimim soft cap allowed is 0 (which effectively puts the
> task in the background) and the minimim hard cap allowed is 1.
>
> Care has been taken to minimize the overhead inflicted on tasks that
> have no caps and my tests using kernbench indicate that it is hidden in
> the noise.

The presence of tasks with caps will break smp balancing and smp nice. I 
suspect you could probably provide a reasonable workaround by altering their 
priority bias effect in the raw weighted load in smp nice for soft caps by 
the percentage cpu of the cap. Hard caps provide more "interesting" 
challenges though. I can't think of a valid biasing off hand for them, but at 
least initially using the same logic as soft caps should help.

-- 
-ck

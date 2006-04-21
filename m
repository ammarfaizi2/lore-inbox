Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWDUA2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWDUA2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWDUA2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:28:06 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:30562 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932176AbWDUA2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:28:05 -0400
Message-ID: <44482712.5030401@bigpond.net.au>
Date: Fri, 21 Apr 2006 10:28:02 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, efault@gmx.de,
       nickpiggin@yahoo.com.au, mingo@elte.hu, kernel@kolivas.org,
       kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] smpnice: don't consider sched groups which are lightly
 loaded for balancing
References: <20060328185202.A1135@unix-os.sc.intel.com>	<442A0235.1060305@bigpond.net.au>	<20060329145242.A11376@unix-os.sc.intel.com>	<442B1AE8.5030005@bigpond.net.au>	<20060329165052.C11376@unix-os.sc.intel.com>	<442B3111.5030808@bigpond.net.au>	<20060401204824.A8662@unix-os.sc.intel.com>	<442F7871.4030405@bigpond.net.au>	<20060419182444.A5081@unix-os.sc.intel.com>	<444719F8.2050602@bigpond.net.au>	<20060420095408.A10267@unix-os.sc.intel.com> <20060420164936.5988460d.akpm@osdl.org>
In-Reply-To: <20060420164936.5988460d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 21 Apr 2006 00:28:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>> updated patch appended. thanks.
> 
> Where are we up to with smpnice now?  Are there still any known
> regressions/problems/bugs/etc?

One more change to move_tasks() is required to address an issue raised 
by Suresh w.r.t. the possibility unnecessary movement of the highest 
priority task from the busiest queue (possible because of the 
active/expired array mechanism).  I hope to forward a patch for this 
later today.

After that the only thing I would like to do at this stage is modify 
try_to_wake_up() so that it tries harder to distribute high priority 
tasks across the CPUs.  I wouldn't classify this as absolutely necessary 
as it's really just a measure that attempts to reduce latency for high 
priority tasks as it should get them onto a CPU more quickly than just 
sticking them anywhere and waiting for load balancing to kick in if 
they've been put on a CPU with a higher priority task already running. 
Also it's only really necessary when there a lot of high priority tasks 
running.  So this isn't urgent and probably needs to be coordinated with 
Ingo's RT load balancing stuff anyway.

>  Has sufficient testing been done for us to
> know this?

I run smpnice kernels on all of my SMP machines all of the time.  But I 
don't have anything with more than 2 CPUs so I've been relying on their 
presence in -mm to get wider testing on larger machines.

I think that once this patch and the move_tasks() one that I'll forward 
later today are incorporated we should have something that (although not 
perfect) works pretty well.  Neither of these changes should cause a 
behavioural change in the case where all tasks are nice==0.

As load balancing is inherently probabilistic I don't think that we 
should hold out for "perfect".

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

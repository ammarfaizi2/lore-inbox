Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWAZMZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWAZMZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 07:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWAZMZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 07:25:25 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:32705 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932302AbWAZMZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 07:25:24 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: smp 'nice' bias support breaks scheduler behavior
Date: Thu, 26 Jan 2006 23:25:04 +1100
User-Agent: KMail/1.9
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
References: <20060126025220.B8521@unix-os.sc.intel.com>
In-Reply-To: <20060126025220.B8521@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601262325.05296.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 January 2006 21:52, Siddha, Suresh B wrote:
> Con,
>
> > [PATCH] sched: implement nice support across physical cpus on SMP
>
> I don't see imbalance calculations in find_busiest_group() take
> prio_bias into account. This will result in wrong imbalance value and
> will cause issues.


in 2.6.16-rc1:

find_busiest_group(....

	load = __target_load(i, load_idx, idle);
else
	load = __source_load(i, load_idx, idle);

where __target_load and __source_load is where we take into account prio_bias.

I'm not sure which code you're looking at, but Peter Williams is working on 
rewriting the smp nice balancing code in -mm at the moment so that is quite 
different from current linus tree.

Con

>
> For example on a DP system with HT, if there are three runnable processes
> (simple infinite loop with same nice value), this patch is resulting in
> bouncing of these 3 processes from one processor to another...Lets assume
> if the 3 processes are scheduled as 2 in package-0 and 1 in package1..
> Now when the busy processor on package-1 does load balance and as
> imbalance doesn't take "prio_bias" into account, this will kick active
> load balance on package-0.. And this is continuing for ever, resulting
> in bouncing from one processor to another.
>
> Even when the system is completely loaded and if there is an imbalance,
> this patch causes wrong imabalance counts and cause unoptimized
> movements.
>
> Do you want to look into this and post a patch for 2.6.16?
>
> thanks,
> suresh

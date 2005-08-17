Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVHQJED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVHQJED (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 05:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVHQJED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 05:04:03 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:63400 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751007AbVHQJEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 05:04:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Date: Wed, 17 Aug 2005 19:03:43 +1000
User-Agent: KMail/1.8.2
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <43001E18.8020707@bigpond.net.au> <6bffcb0e05081614498879a72@mail.gmail.com> <4302F0D8.6050409@bigpond.net.au>
In-Reply-To: <4302F0D8.6050409@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508171903.43985.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005 18:10, Peter Williams wrote:
> Michal Piotrowski wrote:
> > Hi,
> > here are schedulers benchmark (part2):
> > [bits deleted]
>
> Here's a summary of your output generated using the attached Python script.
>
>               |         Build Statistics | Overall Statistics
>
> -----------------------------------------------------------------------
>      Scheduler|   Real    CPU  SYS   TPT |    CPU   TPT    delay    CXSW
>
>               | (secs) (secs)  (%)   (%) | (secs)   (%)  (secs)
>
> -----------------------------------------------------------------------
>      ingosched| 3128.5 5056.3 8.18 161.6 | 5379.5 171.9 159367.4 1556452
>      staircase| 3131.2 5032.6 8.09 160.7 | 5352.9 170.9 135193.0 1670366
> spa_no_frills| 3103.8 5049.5 7.98 162.7 | 5266.7 169.7 172384.8  520937
>    zaphod(d,d)| 3561.7 4823.8 9.25 135.4 | 5132.0 144.1 148361.5 1771617
>    zaphod(d,0)| 3551.2 4809.9 9.19 135.4 | 5114.7 144.0 144022.0 1784814
>    zaphod(0,d)| 3126.8 5063.2 8.11 161.9 | 5278.1 168.8 173438.4  573587
>    zaphod(0,0)| 3105.5 5052.9 7.98 162.7 | 5254.8 169.2 165774.4  577534
>      nicksched| 3294.7 5095.1 9.10 154.6 | 5425.4 164.6 104298.2 2205665
>
> where the (x,y) after zaphod means (max_ia_bonus, max_tpt_bonus) and "d"
> means default.  I had to kill a few significant digits to squeeze it
> into 71 columns.  Overall statistics are extracted from the schedstats
> data.  In the "Build Statistics" "CPU" is the sum of the user and sys
> times and "SYS" is the percentage of that which was sys time (as I feel
> that is a better thing to compare than raw sys times).
>
> I was intrigued by the fact that zaphod(d,d) and zaphod(d,0) take longer
> in real time but use less cpu.  I was assuming that this meant that some
> other job was getting some cpu but the schedstats data doesn't support
> that.  Also it wouldn't make sense anyway as you'd expect jobs doing the
> same amount of work to use roughly the same amount of cpu.  My latest
> theory is that your machine has hyper threads and this artifact is
> caused by the mechanism in the scheduler for handling tasks with
> differing priority in sibling hyper thread channels.  Does your system
> have hyper threads?

That would only do something if there was a difference in 'nice' levels. What 
you're seeing is the fact that balancing is intimately tied in with timeslice 
size and you have increased idle time.

Cheers,
Con


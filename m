Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWAKKuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWAKKuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 05:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWAKKuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 05:50:24 -0500
Received: from tornado.reub.net ([202.89.145.182]:19410 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750753AbWAKKuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 05:50:23 -0500
Message-ID: <43C4E2BE.6050800@reub.net>
Date: Wed, 11 Jan 2006 23:49:34 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060110)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: neilb@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org>	<43BFD8C1.9030404@reub.net>	<20060107133103.530eb889.akpm@osdl.org>	<43C38932.7070302@reub.net>	<20060110104759.GA30546@elte.hu>	<43C3A85A.7000003@reub.net>	<20060110044240.3d3aa456.akpm@osdl.org>	<20060110131618.GA27123@elte.hu>	<17348.34472.105452.831193@cse.unsw.edu.au>	<43C4947C.1040703@reub.net>	<20060110213001.265a6153.akpm@osdl.org> <20060110213056.58f5e806.akpm@osdl.org>
In-Reply-To: <20060110213056.58f5e806.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2006 6:30 p.m., Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
>> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>>> I'm tempted to see if I can narrow it down to a specific -gitX release, maybe 
>>>  that would narrow it down to say, 200 or so patches ;-)
>> If -mm2 plus -mm2's linus.patch does not fail then
>> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt will
>> find the dud patch.
> 
> Actually 2.6.15-mm1 would be a better one to do the bisection on: it has
> all the md- patches separated out.

I've done some more testing - which may change the suggested approach somewhat..

2.6.15-mm1 is OK, I'm running it now, rebooted probably 15 times and it's come 
up every time.
2.6.15-git2 is OK, booted up to completion (tested once).
2.6.15-git3 was a dud, bootup hung
2.6.15- [linus.patch from -mm2, which is basically the same as -git3] won't boot
2.6.15-mm2 doesn't boot either, tested many times
2.6.15-git6 won't boot
2.6.15-git7 got stuck also, same issue

So some change that went in between -git2 and -git3 seems to have caused it. 
Nothing from -git3 onwards has ever booted to completion.

Is there any chance a patch came in, was queued in -mm but was never released in 
any -mm (1|2) release before being sent to Linus/-gitX?  (in this case, -git3). 
  The reason I suggest this is because -mm1 didn't have the problem, but in -mm2 
it was visible by just the linus.patch from that release.

I'm not sure where this leaves quilt testing.  Would quilt testing just narrow 
me down to it being the linus.patch in mm which actually caused it? (Which I 
already know is the source)..

I've put the -git7 .config and a tasks list up on 
http://www.reub.net/files/kernel/ again in case anyone wants to verify that it 
is still the same problem.

What a pain of a bug.

reuben






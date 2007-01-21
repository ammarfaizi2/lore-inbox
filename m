Return-Path: <linux-kernel-owner+w=401wt.eu-S1751065AbXAUBrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbXAUBrQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 20:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbXAUBrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 20:47:16 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:49111 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbXAUBrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 20:47:15 -0500
Date: Sun, 21 Jan 2007 04:46:44 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
Subject: Re: Possible ways of dealing with OOM conditions.
Message-ID: <20070121014644.GA12070@2ka.mipt.ru>
References: <20070118104144.GA20925@2ka.mipt.ru> <1169122724.6197.50.camel@twins> <20070118135839.GA7075@2ka.mipt.ru> <1169133052.6197.96.camel@twins> <20070118155003.GA6719@2ka.mipt.ru> <1169141513.6197.115.camel@twins> <20070118183430.GA3345@2ka.mipt.ru> <1169211195.6197.143.camel@twins> <20070119225643.GA22728@2ka.mipt.ru> <45B29953.5010505@surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <45B29953.5010505@surriel.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 21 Jan 2007 04:46:46 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2007 at 05:36:03PM -0500, Rik van Riel (riel@surriel.com) wrote:
> Evgeniy Polyakov wrote:
> >On Fri, Jan 19, 2007 at 01:53:15PM +0100, Peter Zijlstra 
> >(a.p.zijlstra@chello.nl) wrote:
> 
> >>>Even further development of such idea is to prevent such OOM condition
> >>>at all - by starting swapping early (but wisely) and reduce memory
> >>>usage.
> >>These just postpone execution but will not avoid it.
> >
> >No. If system allows to have such a condition, then
> >something is broken. It must be prevented, instead of creating special
> >hacks to recover from it.
> 
> Evgeniy, you may want to learn something about the VM before
> stating that reality should not occur.

I.e. I should start believing that OOM can not be prevented, bugs can
not be fixed and things can not be changed just because it happens right
now? That is why I'm not subscribed to lkml :)

> Due to the way everything in the kernel works, you cannot
> prevent the memory allocator from allocating everything and
> running out, except maybe by setting aside reserves to deal
> with special subsystems.
> 
> As for your "swapping early and reduce memory usage", that is
> just not possible in a system where a memory writeout may need
> one or more memory allocations to succeed and other I/O paths
> (eg. file writes) can take memory from the same pools.

When system starts swapping only when it can not allocate new page, 
then it is broken system. I bet you get warm closing way before you 
hands are frostbitten, and you do not have a liter of alcohol in the 
packet for such emergency. And to get warm closing you still need to 
go over cold street into the shop, but you will do it before weather
becomes arctic.

> With something like iscsi it may be _necessary_ for file writes
> and swap to take memory from the same pools, because they can
> share the same block device.

Of course swapping can require additional allocation, when it happens
over network it is quite obvious.

The main problem is the fact, that if system was put into the state,
when its life depends on the last possible allocation, then it is
broken.

There is a light connected to car's fuel tank which starts blinking, 
when amount of fuel is less then predefined level. Car just does not 
stop suddenly and starts to get fuel from reserve (well eventually it 
stops, but it says about problem long before it dies).

> Please get out of your fantasy world and accept the constraints
> the VM has to operate under.  Maybe then you and Peter can agree
> on something.

I can not accept the situation, when problem is not fixed, but instead
recovery path is added. There must be both ways of dealing with it -
emergency force majeur recovery and preventive steps.

What we are talking about (except pointing to obvious things and sending
to school-classes), at least how I see this, is ways of dealing with
possible OOM condition. If OOM has happend, then there must be recovery
path, but OOM must be prevented, and ways to do this were described too.

> -- 
> Politics is the struggle between those who want to make their country
> the best in the world, and those who believe it already is.  Each group
> calls the other unpatriotic.

-- 
	Evgeniy Polyakov

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318080AbSHBEDu>; Fri, 2 Aug 2002 00:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318081AbSHBEDu>; Fri, 2 Aug 2002 00:03:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20243 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318080AbSHBEDt>; Fri, 2 Aug 2002 00:03:49 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: large page patch
Date: Fri, 2 Aug 2002 04:07:10 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aid0he$1h4$1@penguin.transmeta.com>
References: <3D49D45A.D68CCFB4@zip.com.au> <737220000.1028250590@flay>
X-Trace: palladium.transmeta.com 1028261214 14253 127.0.0.1 (2 Aug 2002 04:06:54 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 2 Aug 2002 04:06:54 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <737220000.1028250590@flay>,
Martin J. Bligh <Martin.Bligh@us.ibm.com> wrote:
>> - The change to MAX_ORDER is unneeded
>
>It's not only unneeded, it's detrimental. Not only will we spend more
>time merging stuff up and down to no effect

I doubt that.  At least the naive math says that it should get
exponentially less likely(*) to merge up/down for each level, so by the
time you've reached order-10, any merging is already in the noise and
totally unmeasurable. 

And the memory footprint of the bitmaps etc should be basically zero
(since they too shrink exponentially for each order).

((*) The "exponentially less likely" simply comes from doing the trivial
experiment of what would happen if you allocated all pages in-order one
at a time, and then free'd them one at a time.  Obviously not a
realistic test, but on the other hand a realistic kernel load tends to
keep a fairly fixed fraction of memory free, which makes it sound
extremely unlikely to me that you'd get sudden collpses/buildups either. 
Th elikelihood of being at just the right border for that to happens
_also_ happens to be decreasins as 2**-n)

Of course, if you can actually measure it, that would be interesting. 
Naive math gives you a guess for the order of magnitude effect, but
nothing beats real numbers ;)

> It also makes the config_nonlinear stuff harder (or we have to
> #ifdef it, which just causes more unnecessary differentiation). 

Hmm..  This sounds like a good point, but I thought we already did all
the math relative to the start of the zone, so that the alignment thing
implied by MAX_ORDER shouldn't be an issue. 

Or were you thinking of some other effect?

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271094AbTG1V4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271108AbTG1V4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:56:13 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:39078
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271094AbTG1V4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:56:11 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Bill Davidsen <davidsen@tmr.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
Date: Tue, 29 Jul 2003 08:00:23 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1030728173045.19757A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030728173045.19757A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307290800.24003.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 07:38, Bill Davidsen wrote:
> On Mon, 28 Jul 2003, Ingo Molnar wrote:
> > On Mon, 28 Jul 2003, Con Kolivas wrote:
> > > On Sun, 27 Jul 2003 23:40, Ingo Molnar wrote:
> > > >  - further increase timeslice granularity
> > >
> > > For a while now I've been running a 1000Hz 2.4 O(1) kernel tree that
> > > uses timeslice granularity set to MIN_TIMESLICE which has stark
> > > smoothness improvements in X. I've avoided promoting this idea because
> > > of the theoretical drop in throughput this might cause. I've not been
> > > able to see any detriment in my basic testing of this small
> > > granularity, so I was curious to see what you throught was a reasonable
> > > lower limit?
> >
> > it's a hard question. The 25 msecs in -G6 is probably too low.
>
> It would seem to me that the lower limit for a given CPU is a function of
> CPU speed and cache size. One reason for longer slices is to preserve the
> cache, but the real time to get good use from the cache is not a constant,
> and you just can't pick any one number which won't be too short on a slow
> cpu or unproductively long on a fast CPU. Hyperthreading shrinks the
> effective cache size as well, but certainly not by 2:1 or anything nice.
>
> Perhaps this should be a tunable set by a bit of hardware discovery at
> boot and diddled at your own risk. Sure one factor in why people can't
> agree on HZ and all to get best results.

Agreed, and no doubt the smaller the timeslice the worse it is. I did a little 
experimenting with my P4 2.53 here and found that basically no matter how 
much longer the timeslice was there was continued benefit. However the 
benefit was diminishing the higher you got. If you graphed it out it was a 
nasty exponential curve up to 7ms and then there was a knee in the curve and 
it was virtually linear from that point on with only tiny improvements. A p3 
933 behaved surprisingly similarly. That's why on 2.4.21-ck3 it was running 
with timeslice_granularity set to 10ms. However the round robin isn't as bad 
as pure timeslice limiting because if they're still on the active array I am 
led to believe there is less cache trashing. 

There was no answer in that but just thought I'd add what I know so far.

Con


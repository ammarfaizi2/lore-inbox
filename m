Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271107AbTG1VqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271117AbTG1VqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:46:07 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:12806 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271107AbTG1VqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:46:04 -0400
Date: Mon, 28 Jul 2003 17:38:16 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
In-Reply-To: <Pine.LNX.4.44.0307280921360.3537-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1030728173045.19757A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Ingo Molnar wrote:

> 
> On Mon, 28 Jul 2003, Con Kolivas wrote:
> 
> > On Sun, 27 Jul 2003 23:40, Ingo Molnar wrote:
> > >  - further increase timeslice granularity
> > 
> > For a while now I've been running a 1000Hz 2.4 O(1) kernel tree that
> > uses timeslice granularity set to MIN_TIMESLICE which has stark
> > smoothness improvements in X. I've avoided promoting this idea because
> > of the theoretical drop in throughput this might cause. I've not been
> > able to see any detriment in my basic testing of this small granularity,
> > so I was curious to see what you throught was a reasonable lower limit?
> 
> it's a hard question. The 25 msecs in -G6 is probably too low.

It would seem to me that the lower limit for a given CPU is a function of
CPU speed and cache size. One reason for longer slices is to preserve the
cache, but the real time to get good use from the cache is not a constant,
and you just can't pick any one number which won't be too short on a slow
cpu or unproductively long on a fast CPU. Hyperthreading shrinks the
effective cache size as well, but certainly not by 2:1 or anything nice.

Perhaps this should be a tunable set by a bit of hardware discovery at
boot and diddled at your own risk. Sure one factor in why people can't
agree on HZ and all to get best results.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


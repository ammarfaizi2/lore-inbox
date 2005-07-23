Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVGWXlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVGWXlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 19:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVGWXlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 19:41:07 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:46312 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262010AbVGWXlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 19:41:05 -0400
Date: Sat, 23 Jul 2005 16:40:46 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: nish.aravamudan@gmail.com, christoph@lameter.com, azarah@nosferatu.za.org,
       diegocg@gmail.com, mbligh@mbligh.org, linux-kernel@vger.kernel.org,
       kernel@kolivas.org, davidsen@tmr.com, david.lang@digitalinsight.com,
       vojtech@suse.cz, dtor_core@ameritech.net, len.brown@intel.com,
       akpm@osdl.org, cw@f00f.org, torvalds@osdl.org, jesper.juhl@gmail.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-Id: <20050723164046.4a11d47e.rdunlap@xenotime.net>
In-Reply-To: <1121572518.14698.1.camel@mindpipe>
References: <42D3E852.5060704@mvista.com>
	<20050713134857.354e697c.akpm@osdl.org>
	<20050713211650.GA12127@taniwha.stupidest.org>
	<9a874849050714170465c979c3@mail.gmail.com>
	<1121386505.4535.98.camel@mindpipe>
	<Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
	<42D731A4.40504@gmail.com>
	<Pine.LNX.4.58.0507142158010.19183@g5.osdl.org>
	<9a874849050715061247ab4fd8@mail.gmail.com>
	<9a874849050716191324d2f8b4@mail.gmail.com>
	<29495f1d0507161935218d798@mail.gmail.com>
	<1121572518.14698.1.camel@mindpipe>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2005 23:55:17 -0400 Lee Revell wrote:

> On Sat, 2005-07-16 at 19:35 -0700, Nish Aravamudan wrote: 
> > As you've seen, I think it depends on the timesource: for the PIT, it
> > would be arch/i386/kernel/timers/timer_pit.c::setup_pit_timer().
> 
> That one looks pretty straightforward.
> arch/i386/kernel/timers/timer_tsc.c really looks like fun.  So many
> corner cases...
> 
> BTW shouldn't this code from mark_offset_tsc():
> 
> 402         if (pit_latch_buggy) {
> 403                 /* get center value of last 3 time lutch */
> 404                 if ((count2 >= count && count >= count1)
> 405                     || (count1 >= count && count >= count2)) {
> 406                         count2 = count1; count1 = count;
> 407                 } else if ((count1 >= count2 && count2 >= count)
> 408                            || (count >= count2 && count2 >= count1)) {
> 409                         countmp = count;count = count2;
> 410                         count2 = count1;count1 = countmp;
> 411                 } else {
> 412                         count2 = count1; count1 = count; count = count1;
> 413                 }
> 414         }
> 
> use an ifdef?  It only applies to cyrix_55x0, and mark_offset_tsc is a
> pretty hot path.

I see your point, but several distros build kernels that run on
almost any x86-32 machine, so I think that it's there as is
for universal-kernel support.

---
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVGYN0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVGYN0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 09:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVGYN0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 09:26:25 -0400
Received: from styx.suse.cz ([82.119.242.94]:44757 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261172AbVGYN0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 09:26:23 -0400
Date: Mon, 25 Jul 2005 15:26:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: Lee Revell <rlrevell@joe-job.com>, nish.aravamudan@gmail.com,
       christoph@lameter.com, azarah@nosferatu.za.org, diegocg@gmail.com,
       mbligh@mbligh.org, linux-kernel@vger.kernel.org, kernel@kolivas.org,
       davidsen@tmr.com, david.lang@digitalinsight.com,
       dtor_core@ameritech.net, len.brown@intel.com, akpm@osdl.org,
       cw@f00f.org, torvalds@osdl.org, jesper.juhl@gmail.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050725132622.GE976@ucw.cz>
References: <9a874849050714170465c979c3@mail.gmail.com> <1121386505.4535.98.camel@mindpipe> <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org> <42D731A4.40504@gmail.com> <Pine.LNX.4.58.0507142158010.19183@g5.osdl.org> <9a874849050715061247ab4fd8@mail.gmail.com> <9a874849050716191324d2f8b4@mail.gmail.com> <29495f1d0507161935218d798@mail.gmail.com> <1121572518.14698.1.camel@mindpipe> <20050723164046.4a11d47e.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050723164046.4a11d47e.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2005 at 04:40:46PM -0700, randy_dunlap wrote:
> On Sat, 16 Jul 2005 23:55:17 -0400 Lee Revell wrote:
> 
> > On Sat, 2005-07-16 at 19:35 -0700, Nish Aravamudan wrote: 
> > > As you've seen, I think it depends on the timesource: for the PIT, it
> > > would be arch/i386/kernel/timers/timer_pit.c::setup_pit_timer().
> > 
> > That one looks pretty straightforward.
> > arch/i386/kernel/timers/timer_tsc.c really looks like fun.  So many
> > corner cases...
> > 
> > BTW shouldn't this code from mark_offset_tsc():
> > 
> > 402         if (pit_latch_buggy) {
> > 403                 /* get center value of last 3 time lutch */
> > 404                 if ((count2 >= count && count >= count1)
> > 405                     || (count1 >= count && count >= count2)) {
> > 406                         count2 = count1; count1 = count;
> > 407                 } else if ((count1 >= count2 && count2 >= count)
> > 408                            || (count >= count2 && count2 >= count1)) {
> > 409                         countmp = count;count = count2;
> > 410                         count2 = count1;count1 = countmp;
> > 411                 } else {
> > 412                         count2 = count1; count1 = count; count = count1;
> > 413                 }
> > 414         }
> > 
> > use an ifdef?  It only applies to cyrix_55x0, and mark_offset_tsc is a
> > pretty hot path.
> 
> I see your point, but several distros build kernels that run on
> almost any x86-32 machine, so I think that it's there as is
> for universal-kernel support.
 
The same latch bug is in stone age Intel Pentium chipsets and some
medieval SiS chipsets. VIA chipsets from the middle age have another
interesting bug in the PIT.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

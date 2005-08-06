Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbVHFPC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbVHFPC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 11:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVHFPCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 11:02:36 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:51433 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263162AbVHFPB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 11:01:28 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Date: Sun, 7 Aug 2005 01:00:54 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
References: <200508021443.55429.kernel@kolivas.org> <20050806145418.GA16523@thunk.org>
In-Reply-To: <20050806145418.GA16523@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508070100.55319.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Aug 2005 00:54, Theodore Ts'o wrote:
> On Tue, Aug 02, 2005 at 02:43:55PM +1000, Con Kolivas wrote:
> > This is a code reordered version of the dynamic ticks patch from Tony
> > Lindgen and Tuukka Tikkanen - sorry about spamming your mail boxes with
> > this, but thanks for the code. There is significant renewed interest by
> > the lkml audience for such a feature which is why I'm butchering your
> > code (sorry again if you don't like me doing this). The only real
> > difference between your code and this patch is moving the #ifdef'd code
> > out of code paths and putting it into dyn-tick specific files.
> >
> > This has slightly more build fixes than the last one I posted and boots
> > and runs fine on my laptop. So far at absolute idle it appears this
> > pentiumM 1.7 is claiming to have _25%_ more battery life. I'll need to
> > investigate further to see the real power savings.
>
> Hi Con,
>
> I had a chance to try out your patch (2.6.13-rc4-dtck-2.patch) and
> using either the APIC or PIT timer, if dynamic tick is enabled, on my
> laptop, this kicks up the bus mastering activity enough so that the
> processor doesn't have a chance to enter the C4 state, and stays stuck
> at C2.  As a result, enabling dynamic tick _increases_ power
> consumption by 20% on my T40 laptop (1.6 MHz Pentium M). 

Lovely! (not)

> I monitored 
> power utilization using pmstats-0.2, and used
> /proc/acpi/processor/CPU/power to monitor bus mastering activity and the
> CPU C-states.
>
> As soon as I disabled dynamic tick using:
>
> 	echo 0 > /sys/devices/system/timer/timer0/dyn_tick_state
>
> The number of ticks went up to 1024, bus mastering activity dropped to
> zero, and the processor entered C4 state, and power utilization
> dropped by 20%.
>
> When I enabled dynamic tick using:
>
> 	echo 1 > /sys/devices/system/timer/timer0/dyn_tick_state
>
> The number of ticks dropped down to 60-70 HZ, bus mastering activity
> jumpped up to being almost always active,

Anyone know why this would happen?

> and the processor stayed 
> stuck at C2 state, and power utilization climbed back up by 20%.
>
> This was on a completely idle, freshly booted machine, without X
> running and just a console login.

Thanks for testing.

Cheers,
Con

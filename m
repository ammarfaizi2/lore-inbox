Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbUBPIcJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 03:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265445AbUBPIcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 03:32:09 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:42138 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265438AbUBPIb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 03:31:56 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Bill Anderson <banderson@hp.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: system (not HW) clock advancing really fast
Date: Mon, 16 Feb 2004 16:41:33 +0800
User-Agent: KMail/1.5.4
References: <1076910368.25980.12.camel@perseus> <200402161545.09901.mhf@linuxmail.org> <1076917697.25980.35.camel@perseus>
In-Reply-To: <1076917697.25980.35.camel@perseus>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402161641.33323.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 February 2004 15:48, Bill Anderson wrote:
> On Mon, 2004-02-16 at 00:45, Michael Frank wrote:
> > On Monday 16 February 2004 15:26, Bill Anderson wrote:
> > > On Sun, 2004-02-15 at 23:24, Michael Frank wrote:
> > > > I had this somtetimes when using ntpd doing step time update
> > > > resulting in silly values in /etc/adjtime . 
> > > > 
> > > > # mv /etc/adjtime /tmp 
> > > > # hwclock --systohc
> > > > 
> > > > and see if it goes away.
> > > 
> > > Thanks, though it didn't work. :(
> > > 
> > 
> > Please check your /etc/ntp/drift , the value in it is
> > usually between -30.0 and 30.0
> > 
> > If it is much larger than that, set it to 0.0 and restart ntpd.
> 
> 
> Done that, too. in fact, that was my first target.
> Along with stop ntpd, sync, clear drift, clear adjtime, sync again, and
> restart ntpd. Sorry, should have said that. It's been a *looong* time
> since I've posted here.

The basic suggestions were bound to be redundant ;)

> 
> I just tried some new stuff that is interesting.
> 
> MachineA is the one with the problem. MachineB is an identical machine
> (as far as two machines can be).
> 
> On MachineA I am seeing some interesting things with /proc/interrupts
> and the timer interrupt line.
> 
> On MachineA:
>   Over 10 seconds (wall clock):
>     CPU0: 107 interrupts/second (avg)
>     CPU1: 102.5 interrupts/second (avg)
>    [Over 10K interrupts difference between the two]
> On MachineB:
>   Over 10 seconds (wall clock):
>     CPU0: 46.4 interrupts/second (avg)
>     CPU1: 45.5 interrupts/second (avg)
>    [Over 10K interrupts difference between the two]
> 
> Now, the CPU differences don't make me blink. However, the slightly more
> than double the rate of timer interrupts on the problem machine is
> interesting to me. or is it a red herring/blind alley? Especially since
> it now seems to be ~2 seconds per second fast.
> 

When running vmstat, on 2.4 100+ idle interrupts/s is normal,
100 for the clock, and a few extra for what else goes on.

If the machines are _identical_, your problem points definitely 
to hardware.

a) Timer broken - too fast.
b) Generates IRQ's on both edges
c) the clock interrupt being routed into both CPU's 
   at the same time. 

You could boot with NOSMP to rule out c)

Weird breakdown anyway,

Regards
Michael


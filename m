Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbUBPHsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 02:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265413AbUBPHsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 02:48:22 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:5124 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S265401AbUBPHsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 02:48:20 -0500
Subject: Re: system (not HW) clock advancing really fast
From: Bill Anderson <banderson@hp.com>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200402161545.09901.mhf@linuxmail.org>
References: <1076910368.25980.12.camel@perseus>
	 <200402161424.49242.mhf@linuxmail.org> <1076916391.25980.23.camel@perseus>
	 <200402161545.09901.mhf@linuxmail.org>
Content-Type: text/plain
Message-Id: <1076917697.25980.35.camel@perseus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 16 Feb 2004 00:48:18 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2004 07:48:19.0275 (UTC) FILETIME=[3E6B99B0:01C3F461]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 00:45, Michael Frank wrote:
> On Monday 16 February 2004 15:26, Bill Anderson wrote:
> > On Sun, 2004-02-15 at 23:24, Michael Frank wrote:
> > > I had this somtetimes when using ntpd doing step time update
> > > resulting in silly values in /etc/adjtime . 
> > > 
> > > # mv /etc/adjtime /tmp 
> > > # hwclock --systohc
> > > 
> > > and see if it goes away.
> > 
> > Thanks, though it didn't work. :(
> > 
> 
> Please check your /etc/ntp/drift , the value in it is
> usually between -30.0 and 30.0
> 
> If it is much larger than that, set it to 0.0 and restart ntpd.


Done that, too. in fact, that was my first target.
Along with stop ntpd, sync, clear drift, clear adjtime, sync again, and
restart ntpd. Sorry, should have said that. It's been a *looong* time
since I've posted here.

I just tried some new stuff that is interesting.

MachineA is the one with the problem. MachineB is an identical machine
(as far as two machines can be).

On MachineA I am seeing some interesting things with /proc/interrupts
and the timer interrupt line.

On MachineA:
  Over 10 seconds (wall clock):
    CPU0: 107 interrupts/second (avg)
    CPU1: 102.5 interrupts/second (avg)
   [Over 10K interrupts difference between the two]
On MachineB:
  Over 10 seconds (wall clock):
    CPU0: 46.4 interrupts/second (avg)
    CPU1: 45.5 interrupts/second (avg)
   [Over 10K interrupts difference between the two]

Now, the CPU differences don't make me blink. However, the slightly more
than double the rate of timer interrupts on the problem machine is
interesting to me. or is it a red herring/blind alley? Especially since
it now seems to be ~2 seconds per second fast.

Cheers, and thanks for the help so far, Michael.

Bill


-- 
Bill Anderson <banderson@hp.com>
Red Hat Certified Engineer


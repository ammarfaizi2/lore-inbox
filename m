Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbTEIILH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTEIILH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:11:07 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:23008 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262354AbTEIILG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:11:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16059.25987.491110.330487@gargle.gargle.HOWL>
Date: Fri, 9 May 2003 10:23:31 +0200
From: mikpe@csd.uu.se
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
In-Reply-To: <20030509042659.GS8978@holomorphy.com>
References: <3EBAD63C.4070808@nortelnetworks.com>
	<20030509001339.GQ8978@holomorphy.com>
	<Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com>
	<20030509003825.GR8978@holomorphy.com>
	<Pine.LNX.4.53.0305082052160.21290@chaos>
	<3EBB25FD.7060809@nortelnetworks.com>
	<20030509042659.GS8978@holomorphy.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > On Thu, 8 May 2003, William Lee Irwin III wrote:
 > >>>>> Why would you want to use an interrupt? Just count jiffies in sched.c
 > 
 > On Thu, May 08, 2003 at 11:52:29PM -0400, Chris Friesen wrote:
 > > I'm trying to get a feel for the maximum time from an interrupt coming in 
 > > until the userspace handler gets notified.  On intel you can program the 
 > > hardware to generate interupts through /dev/rtc.  The powerpc doesn't seem 
 > > to support this.
 > > Jiffies are not accurate enough, I am expecting max latencies in the 1-2 ms 
 > > range.
 > > Unfortunately no.  USB/Firewire/Ethernet on the desktop, ethernet/serial 
 > > for compactPCI.
 > > I want to find an additional programmable interrupt source.  It bites that 
 > > cheap PCs have this, and the powerpc doesn't.
 > 
 > Try the timebase instead.

On all Moto PPCs I've checked, the time-base runs at 1/4 the bus clock
rather than at the core clock like we're used to on x86.

I believe many PPCs allow you to program one of the performance counters
to count core clocks. Be advised though that many Moto PPCs in the 750-7410
range have an errata that prevents using performance counter interrupts,
so you'd have to run the counter in non-interrupting mode.

This isn't available to user-space (yet), so you'd also have to hack
the kernel to use this facility.

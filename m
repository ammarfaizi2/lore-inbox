Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVC3V2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVC3V2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVC3V2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:28:39 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:56265 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261829AbVC3V2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:28:17 -0500
Subject: Re: 2.6.11, USB: High latency?
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kus Kusche Klaus <kus@keba.com>, linux-usb-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0503301052070.1327-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0503301052070.1327-100000@ida.rowland.org>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 16:28:14 -0500
Message-Id: <1112218094.18237.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 10:55 -0500, Alan Stern wrote:
> On Wed, 30 Mar 2005, kus Kusche Klaus wrote:
> 
> > I'm performing realtime latency tests (for details about the hardware
> > and software, see my mail "[BUG] 2.6.11: Random SCSI/USB errors when
> > reading from USB memory stick" erlier today).
> > 
> > Even when the errors described in my previous mail does not occur,
> > massive USB stick transfers cause latencies of 1 to 2 milliseconds,
> > which is way too much for realtime control systems. 
> > 
> > I observe these latencies on a vanilla 2.6.11 at any rtprio (even 99),
> > and on realtime-preempt-2.6.12-rc1-V0.7.41-11 at low rtprio (1). When
> > running the program on realtime-preempt-2.6.12-rc1-V0.7.41-11 with
> > rtprio 99, the latencies are gone, but using a rtprio higher than the
> > interrupt handlers is not realistic.
> > 
> > Is there anything which can be done about it?
> 
> The latencies are almost certainly caused by the USB host controller 
> driver.  I'm planning improvements to uhci-hcd which should help reduce 
> the latency, but it will still be on the large side.  And I won't have 
> time to write the changes to the driver for several months.
> 
> The best solution is to stop using uhci-hcd.  Get a PCI card with an OHCI 
> or EHCI (high-speed) controller.  They do much more work in hardware, 
> reducing the amount of time the driver needs to spend with interrupts 
> disabled.

I think this is connected to a problem people have been reporting on the
Linux audio lists.  With some USB chipsets, USB audio interfaces just
don't work.  There are dropouts even at very high latencies.  It appears
that interrupts are being disabled for many milliseconds.  PREEMPT_RT
does not help the problem.  We have pretty much decided it has to be the
kernel's fault.  The problem should be fixable because it seems to work
on the other OS.

Maybe we can isolate it to a certain USB chipsets.  I'll try to get more
info.

Lee


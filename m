Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVC3Pz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVC3Pz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVC3Pzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:55:55 -0500
Received: from ida.rowland.org ([192.131.102.52]:7940 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262300AbVC3Pzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:55:38 -0500
Date: Wed, 30 Mar 2005 10:55:36 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: kus Kusche Klaus <kus@keba.com>
cc: linux-usb-users@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11, USB: High latency?
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231C5@MAILIT.keba.co.at>
Message-ID: <Pine.LNX.4.44L0.0503301052070.1327-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, kus Kusche Klaus wrote:

> I'm performing realtime latency tests (for details about the hardware
> and software, see my mail "[BUG] 2.6.11: Random SCSI/USB errors when
> reading from USB memory stick" erlier today).
> 
> Even when the errors described in my previous mail does not occur,
> massive USB stick transfers cause latencies of 1 to 2 milliseconds,
> which is way too much for realtime control systems. 
> 
> I observe these latencies on a vanilla 2.6.11 at any rtprio (even 99),
> and on realtime-preempt-2.6.12-rc1-V0.7.41-11 at low rtprio (1). When
> running the program on realtime-preempt-2.6.12-rc1-V0.7.41-11 with
> rtprio 99, the latencies are gone, but using a rtprio higher than the
> interrupt handlers is not realistic.
> 
> Is there anything which can be done about it?

The latencies are almost certainly caused by the USB host controller 
driver.  I'm planning improvements to uhci-hcd which should help reduce 
the latency, but it will still be on the large side.  And I won't have 
time to write the changes to the driver for several months.

The best solution is to stop using uhci-hcd.  Get a PCI card with an OHCI 
or EHCI (high-speed) controller.  They do much more work in hardware, 
reducing the amount of time the driver needs to spend with interrupts 
disabled.

Alan Stern


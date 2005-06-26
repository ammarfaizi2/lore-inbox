Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVFZVsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVFZVsa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 17:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFZVsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 17:48:30 -0400
Received: from waste.org ([216.27.176.166]:47797 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261609AbVFZVsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 17:48:24 -0400
Date: Sun, 26 Jun 2005 14:47:45 -0700
From: Matt Mackall <mpm@selenic.com>
To: David Hollis <dhollis@davehollis.com>
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: [linux-usb-devel] usbnet ethernet duplex issue?
Message-ID: <20050626214745.GD12006@waste.org>
References: <20050617192715.GK27572@waste.org> <1119268076.19570.7.camel@dhollis-lnx.sunera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119268076.19570.7.camel@dhollis-lnx.sunera.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 07:47:56AM -0400, David Hollis wrote:
> On Fri, 2005-06-17 at 12:27 -0700, Matt Mackall wrote: 
> > I'm experimenting with a Netgear FA-120 USB 2.0 to Ethernet device and
> > seeing some strange behavior.
> > 
> > If I run a 100MB transfer (TCP, via nc and dd) over out LAN, with the
> > Netgear on the sending end, I get about 10MB/s, as expected.
> > Receiving, I get ~5MB/s. If I do simultaneous send and receive, the
> > throughput is a few K per second at best.
> > 
> > If I do the same transfers between a pair of isolated laptops, with
> > the Netgear on one end and Intel e100 or e1000 on the other, I see about
> > 500-900K per second in either direction.
> > 
> > There are no errors detected by the usbnet driver and ethtool reports
> > that the device is autonegotiating, full duplex. Setting autoneg off
> > and duplex to half lets the isolated transfers go at wirespeed.
> > 
> > So the question is, what's up with duplex? Everything I can find about
> > the hardware (including the ASIX datasheet) claims it's full-duplex
> > capable but aside from the error counters, it's really behaving like a
> > half-duplex device.
> > 
> 
> First off, I hope you are testing with 2.6.12 or so.  There are some
> patches to handle the auto-negotiation that went in 2.6.11 or 2.6.12 and
> they SHOULD be handling those cases better though it is certainly
> possible that they don't work as well as they should.  In some of my
> testing, I was finding that I only really got the LPA from
> autonegotiation on the first connect.  Subsequent ones always returned
> the same values, even if I connected into a 10mb hub or the like.  I
> haven't been able to determine if that is a shortcoming in the device or
> not. 

This appears to be fixed as of 2.6.12.1. My final test before 2.612
was running UDP streams with netcat. It appeared to be dropping just
about all outbound packets without throttling the sender and without
reporting any errors. Now all seems to be behaving correctly, 11MBps
in both directions simultaneously.

-- 
Mathematics is the supreme nostalgia of our time.

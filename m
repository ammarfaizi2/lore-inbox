Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbWIEPNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWIEPNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWIEPNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:13:25 -0400
Received: from peabody.ximian.com ([130.57.169.10]:31685 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965102AbWIEPNX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:13:23 -0400
Subject: Re: [RFC][PATCH 2/2] ACPI: handle timer ticks proactively
From: Adam Belay <abelay@novell.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
       arjan@linux.intel.com
In-Reply-To: <20060905090328.GA4888@elf.ucw.cz>
References: <20060904131027.GD6279@ucw.cz>
	 <20060905082855.GC5082@elf.ucw.cz> <20060905085319.GA2237@elf.ucw.cz>
	 <20060905090328.GA4888@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 11:16:00 -0400
Message-Id: <1157469360.3420.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 11:03 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > This patch takes advantage of the infrastructure introduced in the last
> > > > patch, and allows the processor idle algorithm to proactively choose a
> > > > c-state based on the time the next timer interrupt is expected to occur.
> > > > It preserves the residency metric, so the algorithm should, in theory,
> > > > remain effective against bursts of activity from other interrupt
> > > > sources.
> > > > 
> > > > This patch is mostly intended to be illustrative.  There may be some
> > > > "#ifdef CONFIG_ACPI" issues, and I would appreciate any advice on
> > > > implementing this more cleanly.
> > 
> > Okay, just to get you some feedback:
> > 
> > It seems to change things a _lot_. Power consumption with usb modules
> > loaded went from 14315mW to 13800mW -- that is huge
> > deal. Unfortunately something strange is going on: with stock kernel,
> > power consumption is mostly constant. With your patch, it varies a
> > lot, at 2 second timescale.
> > 
> > Power consumption with usb unloaded (only way to get reasonable power
> > on x60) went from stable 10450mW to  something rapidly changing, and
> > probably even worse than original:
> 
> I also noticed that with your patch, bus master activity tends to be constant?!

Is this the case even when userspace touches the disk?  On my hardware I
see a constant flow of short BM activity bursts.

Thanks,
Adam



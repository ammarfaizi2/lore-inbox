Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWIEKCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWIEKCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWIEKCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:02:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64490 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750988AbWIEKCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:02:14 -0400
Date: Tue, 5 Sep 2006 11:03:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: abelay@novell.com, len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
       arjan@linux.intel.com
Subject: Re: [RFC][PATCH 2/2] ACPI: handle timer ticks proactively
Message-ID: <20060905090328.GA4888@elf.ucw.cz>
References: <20060904131027.GD6279@ucw.cz> <20060905082855.GC5082@elf.ucw.cz> <20060905085319.GA2237@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905085319.GA2237@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This patch takes advantage of the infrastructure introduced in the last
> > > patch, and allows the processor idle algorithm to proactively choose a
> > > c-state based on the time the next timer interrupt is expected to occur.
> > > It preserves the residency metric, so the algorithm should, in theory,
> > > remain effective against bursts of activity from other interrupt
> > > sources.
> > > 
> > > This patch is mostly intended to be illustrative.  There may be some
> > > "#ifdef CONFIG_ACPI" issues, and I would appreciate any advice on
> > > implementing this more cleanly.
> 
> Okay, just to get you some feedback:
> 
> It seems to change things a _lot_. Power consumption with usb modules
> loaded went from 14315mW to 13800mW -- that is huge
> deal. Unfortunately something strange is going on: with stock kernel,
> power consumption is mostly constant. With your patch, it varies a
> lot, at 2 second timescale.
> 
> Power consumption with usb unloaded (only way to get reasonable power
> on x60) went from stable 10450mW to  something rapidly changing, and
> probably even worse than original:

I also noticed that with your patch, bus master activity tends to be constant?!

root@amd:/data/l/tp/tp_smapi-0.22# cat /proc/acpi/processor/CPU0/power
active state:            C3
max_cstate:              C8
bus master activity:     37244
states:
    C1:                  type[C1] latency[000] usage[00000067]
duration[00000000000000000067]
    C2:                  type[C2] latency[001] usage[00042173]
duration[00000000000454647687]
   *C3:                  type[C3] latency[057] usage[00290242]
duration[00000000003402855375]
root@amd:/data/l/tp/tp_smapi-0.22# cat /proc/acpi/processor/CPU0/power
active state:            C3
max_cstate:              C8
bus master activity:     37244
states:
    C1:                  type[C1] latency[000] usage[00000067]
duration[00000000000000000067]
    C2:                  type[C2] latency[001] usage[00042274]
duration[00000000000454688808]
   *C3:                  type[C3] latency[057] usage[00305466]
duration[00000000003595077816]
root@amd:/data/l/tp/tp_smapi-0.22#
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

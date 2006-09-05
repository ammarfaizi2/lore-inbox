Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWIEKSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWIEKSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWIEKSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:18:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43452 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750792AbWIEKSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:18:48 -0400
Date: Tue, 5 Sep 2006 10:53:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: abelay@novell.com, len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
       arjan@linux.intel.com
Subject: Re: [RFC][PATCH 2/2] ACPI: handle timer ticks proactively
Message-ID: <20060905085319.GA2237@elf.ucw.cz>
References: <20060904131027.GD6279@ucw.cz> <20060905082855.GC5082@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905082855.GC5082@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This patch takes advantage of the infrastructure introduced in the last
> > patch, and allows the processor idle algorithm to proactively choose a
> > c-state based on the time the next timer interrupt is expected to occur.
> > It preserves the residency metric, so the algorithm should, in theory,
> > remain effective against bursts of activity from other interrupt
> > sources.
> > 
> > This patch is mostly intended to be illustrative.  There may be some
> > "#ifdef CONFIG_ACPI" issues, and I would appreciate any advice on
> > implementing this more cleanly.

Okay, just to get you some feedback:

It seems to change things a _lot_. Power consumption with usb modules
loaded went from 14315mW to 13800mW -- that is huge
deal. Unfortunately something strange is going on: with stock kernel,
power consumption is mostly constant. With your patch, it varies a
lot, at 2 second timescale.

Power consumption with usb unloaded (only way to get reasonable power
on x60) went from stable 10450mW to  something rapidly changing, and
probably even worse than original:

current       average
-11200 mW avg -11274 mW
-10505 mW avg -11251 mW
-11701 mW avg -11238 mW
-11975 mW avg -11348 mW
-10432 mW avg -11313 mW
-11944 mW avg -11422 mW
-10683 mW avg -11504 mW
-10682 mW avg -11457 mW
-10402 mW avg -11432 mW
-11913 mW avg -11317 mW
-12004 mW avg -11541 mW
-12004 mW avg -11661 mW
-11945 mW avg -11781 mW
-11943 mW avg -11824 mW
-12577 mW avg -11891 mW
-12004 mW avg -11930 mW
-12019 mW avg -11944 mW
-11972 mW avg -12002 mW
-12004 mW avg -11990 mW
-11913 mW avg -12032 mW
-11083 mW avg -11903 mW

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

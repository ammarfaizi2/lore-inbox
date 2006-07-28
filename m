Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbWG1NnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWG1NnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWG1NnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:43:12 -0400
Received: from styx.suse.cz ([82.119.242.94]:14987 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1161099AbWG1NnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:43:11 -0400
Date: Fri, 28 Jul 2006 15:43:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060728134307.GD29217@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728122508.GC4158@elf.ucw.cz>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 02:25:08PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > >The applets that were doing it (yes, up to 100 times per second)
> > > >corrected their ways pretty quickly, because some machines became
> > > >unusable with the applet enabled.
> > > 
> > > Exactly -- and they've been working merrily ever since.
> > > And if you don't want to trust applet developers, cache the latest
> > > reads and refresh them only if X jiffies have passed.
> > 
> > The timer interrupt still has to happen every time their select() or
> > sleep() expires, with the system having to wake up, even when nothing
> > happened. Polling from userspace is bad.
> 
> I do not understand this. Any polling (in kernel or in userspace) will
> wake the CPU, wasting power.

The kernel, however, has all the gory details at hand, and can decide
much better about the polling frequency, than the (hopefully) hardware
agnostic userspace.

Imagine your Zaurus: You don't need to poll very often when you are on
the flat part of the LiIon discharge curve, you probably want more
detailed info near the end.

> OTOH "high/low/very low" battery applet can reasonably query battery
> every 5 minutes, while detailed, graphical thingie displaying the
> current power consumption will probably poll every 10 seconds...

-- 
Vojtech Pavlik
Director SuSE Labs

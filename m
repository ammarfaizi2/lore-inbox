Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVCOW5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVCOW5D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVCOWyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:54:01 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:51149 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261205AbVCOWjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:39:49 -0500
Date: Tue, 15 Mar 2005 15:40:46 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "J. Bruce Fields" <bfields@fieldses.org>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] APM: fix interrupts enabled in device_power_up
In-Reply-To: <20050315223339.GF11916@fieldses.org>
Message-ID: <Pine.LNX.4.61.0503151539170.23036@montezuma.fsmlabs.com>
References: <20050312131143.GA31038@fieldses.org>
 <Pine.LNX.4.61.0503120806001.17127@montezuma.fsmlabs.com>
 <20050315223339.GF11916@fieldses.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005, J. Bruce Fields wrote:

> On Sat, Mar 12, 2005 at 08:21:29AM -0700, Zwane Mwaikambo wrote:
> > On Sat, 12 Mar 2005, J. Bruce Fields wrote:
> > 
> > > On APM resume this morning on my Thinkpad X31, I got a "spin_lock is
> > > already locked" error; see below.  This doesn't happen on every resume,
> > > though it's happened before.  The kernel is 2.6.11 plus a bunch of
> > > (hopefully unrelated...) NFS patches.
> > >
> > > Mar 12 07:07:31 puzzle kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
> > > Mar 12 07:07:31 puzzle kernel: arch/i386/kernel/time.c:179: spin_lock(arch/i386/kernel/time.c:c0603c28) already locked by arch/i386/kernel/time.c/309
> > > Mar 12 07:07:31 puzzle kernel: arch/i386/kernel/time.c:316: spin_unlock(arch/i386/kernel/time.c:c0603c28) not locked
> > 
> > APM was calling device_power_down and device_power_up with interrupts 
> > enabled, resulting in a few calls to get_cmos_time being done with 
> > interrupts enabled (rtc_lock needs to be acquired with interrupts 
> > disabled).
> 
> Thanks, I haven't been following the discussion carefully, but for
> what's it worth I did apply that patch and now (a few suspend-resume
> cycles later) haven't seen the spin_lock warning or seen any other ill
> effects.
> 
> Let me know if there's any testing it would be useful for me to do.

Thanks for testing it, suspend/resume cycles are what i was most 
interested in.

	Zwane

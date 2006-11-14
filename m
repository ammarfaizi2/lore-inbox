Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966388AbWKNVmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966388AbWKNVmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966389AbWKNVmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:42:40 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:20667 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S966388AbWKNVmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:42:39 -0500
Date: Tue, 14 Nov 2006 16:42:37 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: arvidjaar@mail.ru, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI
 wakeup via sysfs
In-Reply-To: <200611141318.11080.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0611141628150.6666-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006, David Brownell wrote:

> On Monday 13 November 2006 9:15 am, Alan Stern wrote:
> > On Mon, 13 Nov 2006, David Brownell wrote:
> > 
> > > It's a *driver model* API, which is also accessible from sysfs ... to support
> > > per-device policies, for example the (a) workaround.  The mechanism exists
> > > even on kernels that don't include sysfs ... although on such systems, there
> > > is no way for users to do things like say "ignore the fact that this mouse
> > > claims to issue wakeup events, its descriptors lie".
> > 
> > Yes, it is separate from sysfs -- but it is _tied_ to the sysfs API.
> 
> I can't agree.  If you deconfigure sysfs, it still works.
> Since it's independent like that, there's no way it's "tied".

We could carry on this argument indefinitely.  Yes, the device_may_wakeup
stuff does work without sysfs.  But it doesn't do anything significant; it
amounts to no more than device_can_wakeup().  AFAIK there's no way to
change the setting of the may_wakeup flag other than via sysfs.  That's
what I meant by "tied".

> > > No; I'm saying the driver model is used to record that the hardware mechanism
> > > isn't available.   The fact that it's because of an implementation artifact
> > > (bad silicon, or board layout, etc) versus a design artifact (silicon designed
> > > without that feature) is immaterial ... in either case, the system can't use
> > > the mechanism.
> > 
> > But the information is being recorded in the wrong spot.  The correct test
> > should use device_can_wakeup, not device_may_wakeup.  The can_wakeup flag
> > is the one which records whether or not the hardware mechanism is actually
> > available.
> 
> Go look again.  "may" implies (i) can , and (ii) should.  So if there's a
> hardware quirk registered, (i) always fails.  And in the not-uncommon case
> where the device misbehavior isn't known to the kernel, userspace has the
> option of making (ii) kick in (the workaround mentioned above).  This is a
> generic approach, it works on all wakeup-capable devices.
> 
> So "may" is correct, and "can" is insufficient.

Things work differently in uhci-hcd.  I still haven't submitted the patch 
to add device_may_wakeup support (although it was written quite a while 
ago and may have been posted to linux-usb-devel; I can't remember).

However even when it is added and may_wakeup is off, autostop will still 
function.  It won't rely on interrupts or other wakeup events, though -- 
instead the root-hub status polling mechanism will be used.

Alan Stern


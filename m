Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261475AbSIZT2x>; Thu, 26 Sep 2002 15:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSIZT2x>; Thu, 26 Sep 2002 15:28:53 -0400
Received: from ida.rowland.org ([192.131.102.52]:10500 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id <S261475AbSIZT2w>;
	Thu, 26 Sep 2002 15:28:52 -0400
Date: Thu, 26 Sep 2002 15:34:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: <stern@ida.rowland.org>
To: Greg KH <greg@kroah.com>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci
 and usb
In-Reply-To: <20020926184345.GC6250@kroah.com>
Message-ID: <Pine.LNX.4.33L2.0209261522340.910-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Greg KH wrote:

> On Thu, Sep 26, 2002 at 09:14:48AM -0700, David Brownell wrote:
> > I think it _could_ be fine to do such rmmods, if all the module
> > remove races were removed ... and (for this issue) if the primitve
> > were actually "remove if the driver is not (a) in active use, or
> > (b) bound to any device".  Today we have races and (a) ... but it's
> > the lack of (b) that prevents hotplug from even trying to rmmod,
> > on the optimistic assumption there are no races.
>
> But how do we accomplish (b) for devices that we can't remove from the
> system?  Like 99.9% of the pci systems?
>
> I agree it would be "nice", but probably never realistic :)


This raises a generally interesting question:  When should a driver module
be loaded?

Should it be there all the time? -- usually not.  Or only when the device
is in active use?  Also at detection (hotplug) and removal time?  As long
as the device is installed?  What if the device is built into the system
and can never be removed?  What if the device is not subject to
hotplugging itself but is required in order to operate another device that
can be hotplugged (e.g., a USB host controller driver)?

I think it's clear that the answer must depend on the particular driver,
and that no single scheme involving usage counts (or the equivalent) can
suffice for every situation.

Is there a way to let the kernel provide a variety of mechanisms and let
the device driver (or even the user) select which one gets used?

Alan Stern


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbVJRADm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVJRADm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 20:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVJRADm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 20:03:42 -0400
Received: from soundwarez.org ([217.160.171.123]:26508 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751419AbVJRADl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 20:03:41 -0400
Date: Tue, 18 Oct 2005 02:03:38 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Adam Belay <ambx1@neo.rr.com>, dtor_core@ameritech.net,
       Greg KH <gregkh@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051018000338.GB2457@vrfy.org>
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org> <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com> <20051015150855.GA7625@vrfy.org> <20051017214430.GA5193@suse.de> <d120d5000510171454w6c59580j7c2b6901c6f750e5@mail.gmail.com> <20051017232655.GB32655@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017232655.GB32655@neo.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 07:26:55PM -0400, Adam Belay wrote:
> On Mon, Oct 17, 2005 at 04:54:52PM -0500, Dmitry Torokhov wrote:
> > On 10/17/05, Greg KH <gregkh@suse.de> wrote:
> > > So, what to do now?  Here's my proposal for the future.
> > >
> > > We figure out some way to agree on the input stuff, using class_device
> > > and get that into 2.6.15.  Personally, I like the stuff I just did and
> > > is in the -mm tree :)
> > >
> > 
> > If we are shooting at 2.6.15 I would just go with original 2-class
> > solution (input and input_dev) with doing symlinks in form of
> > /sys/class/input/mouseX/device -> /sys/class/input_dev/inputX
> > 
> > Correct me if I am wrong but this is least invasive and (at least for
> > older hotplug installations) all that is needed to make it work is a
> > symlink from input.agent to input_dev.agent.

Yes, it is almost compatible with the "old" hotplug. On modern setups
it is just one udev rule to catch the right event. On older setups a
simple symlink should work, yes.

> I'm not sure if we want to introduce an incorrect change to the sysfs
> topology only to remove it in the next release.  Currently, class devices
> are not expected to link between one another.

The easiest would be to leave the "device"-link in its current state:
  mouse0 -> ../../../devices/...
and correct that later by getting completely rid of _all_ "device" links
with the move of the device object to /sys/devices/ (the DEVPATH for
"mouse0" will then contain the _complete_ hierarchy including "input0").

Current userspace is not aware to follow two "device" links. Should not be
hard to implement, but seems not really worth the effort, if we plan to
rearrange it to a global device tree anyway.

Thanks,
Kay

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbVLFDRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbVLFDRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 22:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbVLFDRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 22:17:18 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:14213
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751537AbVLFDQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 22:16:56 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Luke-Jr <luke-jr@utopios.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Mon, 5 Dec 2005 18:34:00 -0600
User-Agent: KMail/1.8
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051203152339.GK31395@stusta.de> <20051204232205.GF8914@kroah.com> <200512050559.34464.luke-jr@utopios.org>
In-Reply-To: <200512050559.34464.luke-jr@utopios.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512051834.01384.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 December 2005 23:59, Luke-Jr wrote:
> On Sunday 04 December 2005 23:22, Greg KH wrote:
> > On Sun, Dec 04, 2005 at 04:46:31AM +0000, Luke-Jr wrote:
> > > Well, devfs does have some abilities udev doesn't: hotplug/udev
> > > doesn't detect everything, and can result in rarer or non-PnP devices
> > > not being automatically available;
> >
> > Are you sure about that today?
>
> Nope, but I don't see how udev can possibly detect something that doesn't
> let the OS know it's there-- except, of course, loading the driver for it
> and seeing if it works.

Stuff shows up in /sys whether or not Linux has a driver loaded for it.

ls -l /sys/bus/*/devices

Hotplug insertion events are for when the _device_ shows up, not for when the 
driver is loaded.

> > And udev wasn't created to do everything that devfs does.
>
> Which might be a case for leaving devfs in. *shrug*

I think it was a polite way of saying "udev doesn't suck, have unfixable 
races, randomly crash your system..."

> > What information are you talking about here?
>
> I'm assuming everything in /etc/udev/rules.d/50-udev.rules used to be in
> the kernel for devfs-- perhaps it was PAM though, I'm not sure.
> Other than that, I don't expect that simply installing a new kernel module
> will allow the device to be detected automatically, but that some hotplug
> or udev configurations will need to be updated also.

On an unrelated note, the proposed file format for busybox's mdev looks 
something like:

hd[a-z]  0:3 700
hd[a-z][0-9]* 0:3 740
.* 0:0 700

There's a little more to it than that, but really, specifying ownership and 
permissions is all we _really_ care about.  (We're not trying to obsolete 
udev.)

The point is, 90% of the complexity of udev is optional.  This _can_ be a lot 
simpler if you're not trying to tackle strange persistent naming issues 
resulting in dynamically generated symlinks, and similar fun.  (Which we may 
add the ability to do as compile-time config options later, but perhaps not 
until somebody actually misses them...)

We really don't forsee having to update mdev for deal with new kernel 
versions...  ever, if we can help it.

And a dynamic module loader hanging off of /sbin/hotplug is probably 
(conceptually) a different tool from mdev...

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.

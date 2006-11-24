Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934476AbWKXImh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934476AbWKXImh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 03:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934482AbWKXImh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 03:42:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:16088 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S934476AbWKXImf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 03:42:35 -0500
Date: Thu, 23 Nov 2006 19:59:39 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Ben Collins <ben.collins@ubuntu.com>, Nicholas Miell <nmiell@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
Message-ID: <20061124035939.GA27820@kroah.com>
References: <1163374762.5178.285.camel@gullible> <1163378981.2801.3.camel@entropy> <1163381067.5178.301.camel@gullible> <1163382425.2801.6.camel@entropy> <1163395364.5178.327.camel@gullible> <20061123102928.GA22118@kroah.com> <3ae72650611230340y750b7996s723a3f5a37a5755@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae72650611230340y750b7996s723a3f5a37a5755@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 12:40:04PM +0100, Kay Sievers wrote:
> On 11/23/06, Greg KH <greg@kroah.com> wrote:
> >On Sun, Nov 12, 2006 at 09:22:44PM -0800, Ben Collins wrote:
> >> On Sun, 2006-11-12 at 17:47 -0800, Nicholas Miell wrote:
> >> > On Sun, 2006-11-12 at 17:24 -0800, Ben Collins wrote:
> >> > > On Sun, 2006-11-12 at 16:49 -0800, Nicholas Miell wrote:
> >> > > > On Sun, 2006-11-12 at 15:39 -0800, Ben Collins wrote:
> >> > > >
> >> > > > What's wrong with making udev or whatever unbind driver A and then 
> >bind
> >> > > > driver B if the driver bound by the kernel ends up being the wrong
> >> > > > choice? (Besides the inelegance of the kernel choosing one and then
> >> > > > userspace immediately choosing the other, of course.)
> >> > > >
> >> > > > I'd argue that having multiple drivers for the same hardware is a 
> >bit
> >> > > > strange to begin with, but that's another issue entirely.
> >> > >
> >> > > If two drivers are loaded for the same device, there's no way for 
> >udev
> >> > > to tell the kernel which driver to use for a device, that I know of.
> >> >
> >> > /sys/bus/*/drivers/*/{bind,unbind}
> >>
> >> "bind" does not tell the driver core to "bind this device with this
> >> driver", it tells it to "bind this driver to whatever devices we match
> >> that aren't already bound".
> >
> >No it does not, it tells the driver core to "bind this device with this
> >driver, _if_ the driver will accept it".
> >
> >> That doesn't solve my use case.
> >
> >Yes it does:
> >        echo -n BUS_ID > /sys/bus/foo_bus/drivers/foo_driver/unbind
> >        echo -n BUS_ID > /sys/bus/foo_bus/drivers/baz_driver/bind
> >
> >and you are set.  That's the way other distros use this functionality :)
> 
> Right, I currently port that part of SUSE's sysconfig's per-device
> configuration to udev, and udev-rules will be able to specify what
> driver to use for a device, including driver-unbinding/binding.
> 
> Also modprobe will be built into udev to solve the
> performance-problems we see with parsing the modprobe-files for every
> device with a modalias.

Nice, that will make things even faster at boot time.

thanks,

greg k-h

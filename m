Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933563AbWKWKi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933563AbWKWKi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933561AbWKWKi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:38:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:54148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S933563AbWKWKi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:38:56 -0500
Date: Thu, 23 Nov 2006 02:29:28 -0800
From: Greg KH <greg@kroah.com>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Nicholas Miell <nmiell@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
Message-ID: <20061123102928.GA22118@kroah.com>
References: <1163374762.5178.285.camel@gullible> <1163378981.2801.3.camel@entropy> <1163381067.5178.301.camel@gullible> <1163382425.2801.6.camel@entropy> <1163395364.5178.327.camel@gullible>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163395364.5178.327.camel@gullible>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 09:22:44PM -0800, Ben Collins wrote:
> On Sun, 2006-11-12 at 17:47 -0800, Nicholas Miell wrote:
> > On Sun, 2006-11-12 at 17:24 -0800, Ben Collins wrote:
> > > On Sun, 2006-11-12 at 16:49 -0800, Nicholas Miell wrote:
> > > > On Sun, 2006-11-12 at 15:39 -0800, Ben Collins wrote:
> > > > 
> > > > What's wrong with making udev or whatever unbind driver A and then bind
> > > > driver B if the driver bound by the kernel ends up being the wrong
> > > > choice? (Besides the inelegance of the kernel choosing one and then
> > > > userspace immediately choosing the other, of course.)
> > > > 
> > > > I'd argue that having multiple drivers for the same hardware is a bit
> > > > strange to begin with, but that's another issue entirely.
> > > 
> > > If two drivers are loaded for the same device, there's no way for udev
> > > to tell the kernel which driver to use for a device, that I know of.
> > 
> > /sys/bus/*/drivers/*/{bind,unbind}
> 
> "bind" does not tell the driver core to "bind this device with this
> driver", it tells it to "bind this driver to whatever devices we match
> that aren't already bound".

No it does not, it tells the driver core to "bind this device with this
driver, _if_ the driver will accept it".

> That doesn't solve my use case.

Yes it does:
	echo -n BUS_ID > /sys/bus/foo_bus/drivers/foo_driver/unbind
	echo -n BUS_ID > /sys/bus/foo_bus/drivers/baz_driver/bind

and you are set.  That's the way other distros use this functionality :)

thanks,

greg k-h

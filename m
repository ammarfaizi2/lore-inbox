Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261437AbSIZSj5>; Thu, 26 Sep 2002 14:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSIZSj5>; Thu, 26 Sep 2002 14:39:57 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:6155 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261437AbSIZSj4>;
	Thu, 26 Sep 2002 14:39:56 -0400
Date: Thu, 26 Sep 2002 11:43:45 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci and usb
Message-ID: <20020926184345.GC6250@kroah.com>
References: <20020925212955.GA32487@kroah.com> <3D9250CD.7090409@pacbell.net> <20020926002554.GB518@kroah.com> <3D92749F.9050504@pacbell.net> <20020926042715.GB1790@kroah.com> <3D933278.9010905@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D933278.9010905@pacbell.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 09:14:48AM -0700, David Brownell wrote:
> 
> >Yes, Pat and I have talked a lot about the need for a driver "state".  I
> >think the current goal was to see how far we can get without needing it.
> >I was certainly cursing the lack of it today when trying to debug this
> >problem, but in the end, having it would have only masked over the
> >real problem that was there.
> 
> It'd actually be a "device state", not a "driver state" ...

Doh, yes, that's what I meant, sorry.

> >Well, that's a driver unload issue, which I think everyone agrees on the
> >fact that it's not ok to do automatic driver unload when a device is
> >removed, because of this very problem.
> 
> I think it _could_ be fine to do such rmmods, if all the module
> remove races were removed ... and (for this issue) if the primitve
> were actually "remove if the driver is not (a) in active use, or
> (b) bound to any device".  Today we have races and (a) ... but it's
> the lack of (b) that prevents hotplug from even trying to rmmod,
> on the optimistic assumption there are no races.

But how do we accomplish (b) for devices that we can't remove from the
system?  Like 99.9% of the pci systems?

I agree it would be "nice", but probably never realistic :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVCOWS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVCOWS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVCOWQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:16:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:2787 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261934AbVCOWOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:14:42 -0500
Date: Tue, 15 Mar 2005 14:14:31 -0800
From: Greg KH <greg@kroah.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050315221431.GC28880@kroah.com>
References: <20050315170834.GA25475@kroah.com> <d120d500050315094724938ffc@mail.gmail.com> <20050315193415.GA26299@kroah.com> <20050315201503.GA3591@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315201503.GA3591@isilmar.linta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 09:15:03PM +0100, Dominik Brodowski wrote:
> On Tue, Mar 15, 2005 at 11:34:15AM -0800, Greg KH wrote:
> > > And what about device_driver and device structure? Are they going to
> > > be changed over to be separately allocated linked objects?
> > 
> > The driver stuff probably will be, and the device stuff possibly.
> > However, they are used by a very small ammount of core code (the bus
> > drivers), so changing that interface is not that important at this time.
> 
> So this means every device will have yet another reference count, and you
> need to be aware of _each_ lifetime to write correct code. And the 
> _reference counting_ is the hard thing to get right, so we should make 
> _that_ easier. The existing class API was a step towards this direction, and
> with the changes you're suggesting here we'd do two jumps backwards.

You are correct, it was a step forward in this direction.

But we now have a kref to handle the reference counting for the device,
which make things a whole lot easier than ever before.

But the both of you are correct, there is a real need for the class code
to support trees of devices that are presented to userspace (which is
what the class code is for).  I'm not taking that away, just trying to
make the interface to that code simpler.

I'm also not saying that I'm going to go off and delete those functions
from the kernel today, or tomorrow.  Just that we need to slowly, over
time, make this easier to use, as it's too hard to do so today.  I will
not be removing any functionality, don't worry :)

> > > If not then its enouther reason to keep original class interface -
> > > uniformity of driver model interface.
> > 
> > Ease-of-use trumps uniformity
> 
> Ease-of-use, maybe. However, it also means
> ease-of-getting-reference-counting-wrong. And reference counting trumps it
> all :)

It will not make the reference counting logic easier to get wrong, or
easier to get right.  It totally takes it away from the user, and makes
them implement it themselves if they so wish (like the USB HCD patch
does.)

Anyway, don't worry, the code isn't going away anytime soon, we just
need to make it easier to use.  Any suggestions that any of you have to
make this that way (as you are the ones who had to use it to start with)
would be greatly appreciated.

thanks,

greg k-h

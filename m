Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVCOTvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVCOTvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVCOTso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:48:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:45720 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261816AbVCOTed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:34:33 -0500
Date: Tue, 15 Mar 2005 11:34:15 -0800
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050315193415.GA26299@kroah.com>
References: <20050315170834.GA25475@kroah.com> <d120d500050315094724938ffc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050315094724938ffc@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 12:47:38PM -0500, Dmitry Torokhov wrote:
> Hi Greg,
> 
> On Tue, 15 Mar 2005 09:08:34 -0800, Greg KH <greg@kroah.com> wrote:
> 
> > So I'll be slowly converting the kernel over to using this new
> > interface, and when finished, I can get rid of the old class apis (or
> > actually, just make them static) so that no one can implement them
> > improperly again...
> 
> I disagree with this last step. What I liked about the driver model is
> that once you convert (properly) subsystem to using it you
> automatically get your proper refcounting and memory gets released at
> proper time. The change as it proposed disconnects class device
> instance from the meat so separate refcounting implementation
> isneeded. This increases maintenance costs.

I agree.  The big point is that "properly" statement.  _Everyone_ gets
this wrong the first time they do it.  And the second.  Hopefully, if
they are persistant enough, the third time they get closer, and so on...

We need to make the driver model interface easier to use.  The class
code is used by more individual drivers than the struct device, so
that's the first place to make these kinds of changes, as it is the most
necessary.

> I always viewed class_simple as a stop-gap measure to get hotplug
> events in place until proper implementation is done. Please leave the
> original interface in place so it can still be used if one wshes to do
> so.

No, no one has so far done the "proper implementation" and I don't blame
them.  It's not simple, and it gives them a very low payback for their
time.  The old interface is good and powerful and hard to use.

> And what about device_driver and device structure? Are they going to
> be changed over to be separately allocated linked objects?

The driver stuff probably will be, and the device stuff possibly.
However, they are used by a very small ammount of core code (the bus
drivers), so changing that interface is not that important at this time.

> If not then its enouther reason to keep original class interface -
> uniformity of driver model interface.

Ease-of-use trumps uniformity in this case, sorry.  I want to make it
easy to write code.  The current interface sucks at this goal.

thanks,

greg k-h

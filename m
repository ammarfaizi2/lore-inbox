Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTLJUyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 15:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbTLJUyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 15:54:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:51428 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264110AbTLJUyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 15:54:25 -0500
Date: Wed, 10 Dec 2003 12:53:20 -0800
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Message-ID: <20031210205320.GA8621@kroah.com>
References: <3FD64BD9.1010803@pacbell.net> <Pine.LNX.4.44L0.0312092233340.6615-100000@netrider.rowland.org> <20031210153056.GA7087@kroah.com> <200312101702.16455.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312101702.16455.baldrick@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 05:02:16PM +0100, Duncan Sands wrote:
> > That's what my proposal 1 paragraph up would do.  If I get the chance
> > this afternoon, I'll try to implement it if no one beats me to it...
> 
> Hi Greg, so this means that rmmod will sleep in an unkillable state until
> all references are dropped?

Yes, that is what would happen.

Now you could get into a deadlock by trying something pathilogical like:
	rmmod usb-hcd < /sys/devices/pci0000:00/0000:00:1d.7/usb1/idVendor

but hey, if you do that, you deserve the deadlock :)

(and yes, I know you can do this for network devices, but they have
their own thread/timer/something to prevent this deadlock from
happening...)

> I don't know if you've been following this thread or not, but the oops
> occurred when I modified usbfs to hold a reference to the usb_device
> until no-one was using a given usbfs file.

That's a good thing to do.  It should work.

> I guess this means that I should change my patch so that the reference
> to the usb_device is dropped as soon as possible, right?

No, the bug should be fixed.  I've seen this bug happen if someone has a
usb-serial device open and then unload the host controller driver.  In
fact, I think there's a bugzilla entry just for that...

Yeah, here it is:
	http://bugme.osdl.org/show_bug.cgi?id=1191

The very same oops you are seeing.

So no, it's not your fault.  We need to fix the real problem.

> Thanks for looking into this,

No problem, thanks for reminding me about this.

thanks,

greg k-h

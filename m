Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269521AbTGJRHb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269509AbTGJRGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:06:35 -0400
Received: from storm.he.net ([64.71.150.66]:4264 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S269500AbTGJRGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:06:20 -0400
Date: Thu, 10 Jul 2003 10:20:57 -0700
From: Greg KH <greg@kroah.com>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74 CONFIG_USB_SERIAL_CONSOLE gone?
Message-ID: <20030710172056.GA12295@kroah.com>
References: <200307101453.57857.mflt1@micrologica.com.hk> <20030710164121.GA12055@kroah.com> <200307110113.34362.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307110113.34362.mflt1@micrologica.com.hk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 01:13:34AM +0800, Michael Frank wrote:
> On Friday 11 July 2003 00:41, Greg KH wrote:
> > On Thu, Jul 10, 2003 at 02:53:57PM +0800, Michael Frank wrote:
> > > Tried to config usb serial console on 2.5.74 but it's no more
> > > configurable.
> > >
> > > Searched the tree and these are the only references
> >
> > CONFIG_USB has to be set to Y and CONFIG_USB_SERIAL has to be set to Y
> > to be able to select this config option.
> >
> > Do you have those options selected?
> >
> > And do you _really_ want to use CONFIG_USB_SERIAL_CONSOLE?  It's pretty
> > useless for the most part :)
> >
> > thanks,
> >
> > greg k-h
> X-Spam-Status: No
> X-Spam-Probability: <1%

Nice to see that my emails aren't marked as spam :)

> I don not want to use it but I have no time to key in oopses ;) 

So you don't actually have a usb to serial converter?

> With reference to my post just sent, I guess you are right, so please
> lets make it useful

Heh, patches are always welcome :)

But if you start to use it you will see why it's not really useful.
This is primarily due to the USB core starting up _very_ late in the
boot process, the small size of the buffers of most usb to serial
devices, and the requirement that interrupts be running to send USB
data.  Those three things combined do not make for a good system to try
to capture oops messages.

Good luck,

greg k-h

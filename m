Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWARWNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWARWNy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWARWNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:13:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:33715 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932553AbWARWNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:13:53 -0500
Date: Wed, 18 Jan 2006 14:13:21 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] ehci calling put_device from irq handler
Message-ID: <20060118221321.GA20481@kroah.com>
References: <20060118212901.GA8923@kroah.com> <Pine.LNX.4.44L0.0601181648010.4974-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601181648010.4974-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 04:54:04PM -0500, Alan Stern wrote:
> On Wed, 18 Jan 2006, Greg KH wrote:
> 
> > We can not call put_device() from irq context :(
> > 
> > I added a "might_sleep()" to the driver core and get the following from
> > the ehci driver.  Any thoughts?
> 
> In principle the put_device and corresponding get_device calls aren't
> needed.  We don't release a usb_device structure until after disabling all
> its endpoints, and disabling an endpoint will wait until all the URBs for
> that endpoint have completed.  So there's no reason to keep a reference to
> the device structure for each URB.
> 
> I see that uhci-hcd is guilty of the same thing (reference acquired for 
> each QH, released while holding a spinlock).  Probably each of the 
> host controller drivers is.

Great, care to make up a patch to fix this?

:)

thanks,

greg k-h

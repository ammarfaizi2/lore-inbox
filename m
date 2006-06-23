Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWFWAil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWFWAil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWFWAil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:38:41 -0400
Received: from mail.suse.de ([195.135.220.2]:38327 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750973AbWFWAik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:38:40 -0400
Date: Thu, 22 Jun 2006 17:38:33 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Message-ID: <20060623003833.GB333@suse.de>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606221546120.6483@g5.osdl.org> <20060622234040.GB30143@suse.de> <449B3047.50704@goop.org> <20060622171732.16fd2cd1.akpm@osdl.org> <20060623002230.GA333@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623002230.GA333@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 05:22:30PM -0700, Greg KH wrote:
> On Thu, Jun 22, 2006 at 05:17:32PM -0700, Andrew Morton wrote:
> > Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> > >
> > > Greg KH wrote:
> > > > I saw this once when debugging the usb code, but could never reproduce
> > > > it, so I attributed it to an incomplete build at the time, as a reboot
> > > > fixed it.
> > > >
> > > > Is this easy to trigger for you?
> > > >   
> > > 
> > > This is the same oops as I posted yesterday: "2.6.17-mm1: oops in 
> > > Bluetooth stuff, usbdev_open".  I haven't seen it since...
> > > 
> > 
> > That's a kernel-wide list of USB devices, isn't it?  Which means that some
> > driver other than the bluetooth one has got itself freed up while still
> > being on the list.
> > 
> > If so, it could be any driver at all..
> 
> Hopefully we have the list locked properly while we are walking it, so
> that should not happen, but I'll go back and verify that I got it all
> correct...

Oh crap, that's it.  There's a race when a device switches
configurations and the endpoints disappear.  I was locking in the wrong
functions...  Let me beat on the fix for a bit to make sure I have it
right.

thanks,

greg k-h

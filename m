Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030614AbWFVGgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030614AbWFVGgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030617AbWFVGgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:36:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:53456 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030614AbWFVGgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:36:20 -0400
Date: Wed, 21 Jun 2006 23:19:05 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, pavel@suse.cz,
       linux-pm@osdl.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060622061905.GD15834@kroah.com>
References: <20060621034857.35cfe36f.akpm@osdl.org> <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621221445.GB3798@inferi.kami.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 12:14:45AM +0200, Mattia Dongili wrote:
> On Wed, Jun 21, 2006 at 11:47:46PM +0159, Jiri Slaby wrote:
> > Andrew Morton napsal(a):
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/
> > 
> > [32512.214000] Suspending device usbdev3.2_ep81
> > [32512.214040] Suspending device 3-2:1.0
> > [32512.214081] wacom 3-2:1.0: no suspend for driver wacom?
> > [32512.214128] Suspending device usbdev3.2_ep00
> > [32512.214169] Suspending device 3-2
> > [32512.214209] suspend_device(): usb_generic_suspend+0x0/0x128() returns -16
> > [32512.214319] Could not suspend device 3-2: error -16
> > [32512.214361] wacom 3-2:1.0: no resume for driver wacom?
> > [32512.242552] Some devices failed to suspend
> > 
> > Bus 003 Device 002: ID 056a:0011 Wacom Co., Ltd Graphire 2
> > 
> > Wacom messages are not new, but it now causes not suspending.
> 
> me too (again!)
> 
> [   95.408000] Suspending device 3-1
> [   95.408000] suspend_device(): usb_generic_suspend+0x0/0x144 [usbcore]() returns -16
> [   95.408000] Could not suspend device 3-1: error -16
> [   95.412000] Some devices failed to suspend
> [   95.412000] Restarting tasks... done
> 
> rmmod-ing sd_mod usb_storage usbhid uhci_hcd can finally suspend to disk
> and resume (s2ram).
> usbcore tells it is in use (count=1) and can't remove it.
> The device is a memory stick reader.
> 
> I have the same problems also with suspend to disk. BTW I can't resume
> from disk since 2.6.17-rc5-mm1, but I'll try to be more precise
> tomorrow, as it seems removing the usb stuff makes it do some more steps
> toward resumimg (eg: with usb modules this laptop immediately reboots
> after reading all pages, without them I can reach "resuming device.."
> stage).

Removing uhci-hcd causes all USB devices to be removed from the system.

Alan, you've been working in the "generic usb" section lately, any ideas
why we can't suspend that kind of device now?

thanks,

greg k-h

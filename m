Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWF0Gkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWF0Gkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWF0Gkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:40:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:35968 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932261AbWF0Gkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:40:46 -0400
Date: Mon, 26 Jun 2006 23:37:34 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] Input update for 2.6.17
Message-ID: <20060627063734.GA28135@kroah.com>
References: <200606260235.03718.dtor_core@ameritech.net> <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 11:13:19PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 26 Jun 2006, Dmitry Torokhov wrote:
> > 
> > Please pull from:
> > 
> > ????????git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> 
> I think this (or USB) may have problems.
> 
> I get a spinlock debugging fault with the current kernel on one of my 
> machines at bootup, with the trace-back being:
> 
>   Process: khubd
> 	spin_bug
> 	_raw_spin_lock
> 	_spin_lock
> 	__mutex_lock_slowpath
> 	mutex_lock
> 	input_unregister_device
> 	hidinput_disconnect
> 	hid_disconnect
> 	usb_unbind_interface
> 	__device_release
> 	device_release_driver
> 	bus_remove_device
> 	device_del
> 	usb_disable_device
> 	usb_disconnect
> 	hub_thread
> 	kthread
> 
> it happens pretty early after bootup, but I don't know what triggers that 
> usb disconnect (it may be the hand-over from UHCI->EHCI. Greg? Does that 
> make sense?)

Yes, if you have the UHCI driver loaded first, then when EHCI is loaded,
it disconnects everything on the bus and re-enumerates it.

But EHCI is built into the kernel first, before UHCI, so unless you are
using modules, nothing should be getting disconnected at boot time.

I really doubt you are using modules, so I don't know why it would be
disconnected.  What does the kernel log show right before this happened?
Any chance to enable CONFIG_USB_DEBUG?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbUCSBNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUCSBNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:13:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:29658 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261738AbUCSBNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:13:37 -0500
Date: Thu, 18 Mar 2004 17:12:28 -0800
From: Greg KH <greg@kroah.com>
To: Jakub Bogusz <qboosh@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: Oops on rmmod uhci-hcd when device is still accessed
Message-ID: <20040319011228.GF19053@kroah.com>
References: <20040317232203.GA3510@satan.blackhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040317232203.GA3510@satan.blackhosts>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:22:03AM +0100, Jakub Bogusz wrote:
> It's in drivers/usb/core/devio.c:388:
> 
> |        down(&dev->serialize);
> |        if (test_and_clear_bit(intf, &ps->ifclaimed)) {
> |                iface = dev->actconfig->interface[intf];
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> |                usb_driver_release_interface(&usbdevfs_driver, iface);
> |                err = 0;
> |        }
> |        up(&dev->serialize);
> 
> and looks like dev->actconfig is NULL

Yeah, there's a lot of nasty race conditions with usbfs that have been
around for ages.  I think someone on the linux-usb-devel mailing list
has been working on fixing them all up and has a patch set you might be
able to test.

Hope this helps,

greg k-h

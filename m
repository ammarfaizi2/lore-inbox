Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWIHUoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWIHUoc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 16:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWIHUoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 16:44:32 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:28947 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751218AbWIHUob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 16:44:31 -0400
Date: Fri, 8 Sep 2006 16:44:30 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1
In-Reply-To: <200609081626.43262.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0609081636310.7953-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Andrew Morton wrote:

> Alan, is this likely to be due to your USB PM changes?

It's possible.  Most of those changes are innocuous.  They add routines
that don't get used until a later patch.  However one of them might be
responsible.


On Fri, 8 Sep 2006, Rafael J. Wysocki wrote:

> On Friday, 8 September 2006 10:13, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> 
> ohci_hcd doesn't work after a resume from disk on HPC nx6325, worked on
> 2.6.18-rc5-mm1.
> 
> It helps if I rmmod and modprobe it after the resume.

This patch affects OHCI.  You can try reverting it, to see if that makes 
any difference.  It probably should have been left out of -mm, since it 
interacts pretty strongly with some later USB PM patches that did get left 
out.

	gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch

> Here's the relevant part of the dmesg output:
> 
> usb usb1: resuming
>  usbdev1.1_ep00: PM: resume from 0, parent usb1 still 1
> hub 1-0:1.0: PM: resume from 0, parent usb1 still 1
> hub 1-0:1.0: resuming
>  usbdev1.1: PM: resume from 0, parent usb1 still 1

If reverting that patch doesn't help, please post the relevant dmesg log 
after setting CONFIG_USB_DEBUG.

Alan Stern


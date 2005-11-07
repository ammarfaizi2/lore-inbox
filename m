Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVKGS2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVKGS2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVKGS2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:28:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:44937 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964864AbVKGS2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:28:23 -0500
Date: Mon, 7 Nov 2005 10:22:06 -0800
From: Greg KH <greg@kroah.com>
To: Frank Overton <frank@discoverycenters.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 series kernels panic on boot at PCI probe with 450nx
Message-ID: <20051107182206.GB18861@kroah.com>
References: <436BF7BB.9070900@discoverycenters.org> <20051105043056.GA25501@kroah.com> <1131384430.26641.31.camel@coco.overtonshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131384430.26641.31.camel@coco.overtonshome.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 09:27:11AM -0800, Frank Overton wrote:
> Greg,
> 
> I don't know any good way to save the oops message. I'd love a pointer
> on that. 

Serial console perhaps?  There is documentation on how to do that in the
Documentation/ directory.

> Here is a hand copy of the oops message I am seeing.
> 
> -- top of screen --
>    c316d000  c3126240  00000000 00000000  c01de368  00000000  c31262b8 
> c3126240
> 
> Call Trace: 
> [<co23e390>] class_device_create_file+0x11/0x16
> [<co1ddcaf>] pci_alloc_child_bus+0x74/0xb8
> [<co1ddda5>] pci_scan_bridge+0x90/0x1cd
> [<co1de368>] pci_scan_child_bus+0x51/0x77
> [<co1de4c2>] pci_scan_bus_parented+0x11d/0x133
> [<co29d3ec>] pci_bios_scan_root+0x3d/0x40
> [<co208e00>] acpi_pci_root_add+0x19a/0x1f0
> [<co20d825>] acpi_bus_driver_init+0x2c/0x8c
> [<co20e019>] acpi_bus_find_driver+0x110/0x21a
> [<co20e561>] acpi_bus_add+0x12c/0x152
> [<co20e68b>] acpi_bus_scan+0x104/0x156
> [<co3b7c7a>] acpi_bus_scan_init+0x48/0x5e
> [<co3a86fa>] do_initcalls+0x49/0x8e
> [<co100454>] init+0x0/0x1d8
> [<co1041d5>] kernel_thread_helper+0x5/0xb

Ugh, I really wish I knew which ddevice acpi was trying to add here.  It
looks like it is addding 2 pci busses with the same address, which would
be very odd.  How about creating a bug in bugzilla.kernel.org and
assigning it to the ACPI group?  They should be able to figure it out :)

thanks,

greg k-h

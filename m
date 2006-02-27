Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751849AbWB0XST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbWB0XST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWB0XST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:18:19 -0500
Received: from colo.lackof.org ([198.49.126.79]:65478 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751849AbWB0XSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:18:18 -0500
Date: Mon, 27 Feb 2006 16:28:41 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andi Kleen <ak@suse.de>,
       benh@kernel.crashing.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take 3)
Message-ID: <20060227232841.GB9008@colo.lackof.org>
References: <44028502.4000108@soft.fujitsu.com> <44033A2D.9000902@pobox.com> <20060227214244.GA9008@colo.lackof.org> <44037BC6.30003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44037BC6.30003@pobox.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 05:23:02PM -0500, Jeff Garzik wrote:
> Grant Grundler wrote:
> >On Mon, Feb 27, 2006 at 12:43:09PM -0500, Jeff Garzik wrote:
> >
> >>This series still leaves a lot to be desired, and creates unnecessary
> >>driver churn.
> >
> >
> >This is a pretty small change and is not necessary for every driver.
> 
> The latter is decidedly false.  The change makes no sense at all unless 
> you update every conceivable driver that will be used on the target 
> platform.  You will always be patching drivers as users stick new cards 
> in the target hardware.

It's sufficiently true if 90% of the cards plugged into the machine
are covered by 3 or 4 drivers. The remaining 10% can use IO port space
and everything will work fine.


> >If in #1 pci_enable_device() assigns I/O Port resources even though
> >the driver doesn't need it, PCI devices which _only_ support I/O Port
> >space will get screwed (depending on config). We are trying to avoid that.
> >Or do you have another way of avoiding unused resource allocation?
> 
> Fix the [firmware | device load order] to allocate I/O ports first to 
> the hardware that only supports IO port accesses.  Problem solved with 
> zero kernel mods...

After we (OS developers) have been telling firmware people to NOT
configure every device and run it's BIOS driver at power up?

OS "hotplug" now deals with resource assignment and device initialization
in most cases on these boxes. Running the BIOS/EFI driver to configure
each device just takes too long.

grant

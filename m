Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268273AbUHYS5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268273AbUHYS5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268286AbUHYS47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:56:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:42146 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268273AbUHYS4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:56:00 -0400
Date: Wed, 25 Aug 2004 11:55:19 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040825185519.GG30125@kroah.com>
References: <20040825181951.GA30125@kroah.com> <20040825184502.71622.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825184502.71622.qmail@web14922.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 11:45:02AM -0700, Jon Smirl wrote:
> it is related to this change drivers/pci/bus.c.
> -               pci_proc_attach_device(dev);
> -               pci_create_sysfs_dev_files(dev);
> 
> The pci subsystem was initializing proc and sysfs too early from bus.c.
> Both of these calls always failed and the proc_initialized flag was
> used to return the failure. These calls were never succeeding, they
> were always getting error returns.
> 
> pci_proc_init and pci_sysfs_init run later at _initcall() time and
> build proc/sys so these routines masked the initial failure in bus.c.
> 
> If you remove the calls in bus.s there is no need for the
> proc_initialized flag.

But if you remove those calls, any pci device added later on in a pci
hotplug (or in a pcmcia) system, would not have their sysfs files, or
proc files created, right?

That doesn't seem like a good change, and is unnecessary for this rom
sysfs feature, right?

thanks,

greg k-h

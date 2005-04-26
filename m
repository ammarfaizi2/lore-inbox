Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVDZRkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVDZRkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVDZRk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:40:27 -0400
Received: from colo.lackof.org ([198.49.126.79]:56540 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261417AbVDZRiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:38:46 -0400
Date: Tue, 26 Apr 2005 11:41:16 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Alexander Nyberg <alexn@dsv.su.se>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, jgarzik@pobox.com,
       cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426174116.GG2612@colo.lackof.org>
References: <20050426163734.GF2612@colo.lackof.org> <Pine.LNX.4.44L0.0504261312350.12725-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0504261312350.12725-100000@iolanthe.rowland.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 01:14:38PM -0400, Alan Stern wrote:
> On Tue, 26 Apr 2005, Grant Grundler wrote:
> 
> > Agreed - but this is a different problem than "shutting down IRQs".
> > My point was arch specific code knows how to mask all IRQs.
> > irq_disable() is expected to work regardless of what state the
> > driver is in.  On kexec "reboot", kernel drivers can unmask IRQs
> > as they normally would during initialization. No?
> 
> One has to be careful when talking about enabling/disable IRQs, because 
> there are (at least) two choke points: one on the device and one on the 
> computer's interrupt controller.  Masking IRQs takes place on the 
> controller, but I was talking about stopping interrupt requests at their 
> source on the device.  It's the only way to avoid problems when IRQ lines 
> are shared.

Yes, got it. I wouldn't object if someone said kexec can not
support shared IRQs unless both drivers sharing the IRQ implement
PCI "suspend" hook (and disable IRQ on the respective devices).
We really don't have many options to fix Shared IRQ problems.

thanks,
grant

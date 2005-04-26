Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVDZQkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVDZQkx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVDZQgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:36:20 -0400
Received: from colo.lackof.org ([198.49.126.79]:9948 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261678AbVDZQfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:35:02 -0400
Date: Tue, 26 Apr 2005 10:37:34 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Alexander Nyberg <alexn@dsv.su.se>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, jgarzik@pobox.com,
       cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426163734.GF2612@colo.lackof.org>
References: <20050426154942.GB2612@colo.lackof.org> <Pine.LNX.4.44L0.0504261200550.12725-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0504261200550.12725-100000@iolanthe.rowland.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 12:04:00PM -0400, Alan Stern wrote:
> > Sure there is. Every IRQ line goes to an IRQ controller.
> > Arch specific code deals with programming the controller and can
> > mask all interrupts (or not). Historically, they've been left unmasked
> > for ISA IRQ discovery and debugging misrouted IRQ lines.
> 
> This doesn't help.  Consider what happens when two devices share an IRQ
> line.  Suppose device B is generating interrupt requests when the driver
> for device A is probed.  The driver registers its handler, which causes
> the IRQ line to be unmasked.  Then a multitude of IRQs arrive from B, none
> of which can be handled by A's driver.  So the kernel shuts the IRQ line
> down permanently...

Agreed - but this is a different problem than "shutting down IRQs".
My point was arch specific code knows how to mask all IRQs.
irq_disable() is expected to work regardless of what state the
driver is in.  On kexec "reboot", kernel drivers can unmask IRQs
as they normally would during initialization. No?

grant

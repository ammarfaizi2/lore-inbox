Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVDZQGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVDZQGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDZQEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:04:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:11904 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261622AbVDZQEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:04:00 -0400
Date: Tue, 26 Apr 2005 12:04:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Grant Grundler <grundler@parisc-linux.org>
cc: Alexander Nyberg <alexn@dsv.su.se>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <akpm@osdl.org>,
       <jgarzik@pobox.com>, <cramerj@intel.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
In-Reply-To: <20050426154942.GB2612@colo.lackof.org>
Message-ID: <Pine.LNX.4.44L0.0504261200550.12725-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Grant Grundler wrote:

> > I looked into the possibility of having the PCI core disable interrupt
> > generation and DMA on each new device as it is discovered.  Unfortunately
> > there is no dependable, universal way to do this for IRQs.
> 
> Sure there is. Every IRQ line goes to an IRQ controller.
> Arch specific code deals with programming the controller and can
> mask all interrupts (or not). Historically, they've been left unmasked
> for ISA IRQ discovery and debugging misrouted IRQ lines.

This doesn't help.  Consider what happens when two devices share an IRQ
line.  Suppose device B is generating interrupt requests when the driver
for device A is probed.  The driver registers its handler, which causes
the IRQ line to be unmasked.  Then a multitude of IRQs arrive from B, none
of which can be handled by A's driver.  So the kernel shuts the IRQ line
down permanently...

Alan Stern


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbULPO6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbULPO6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbULPO6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:58:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:29162 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262692AbULPOzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:55:42 -0500
Subject: Re: [PATCH] add legacy I/O and memory access routines to
	/proc/bus/pci API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-pci@atrey.karlin.mff.cu,
       linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200412150900.18890.jbarnes@engr.sgi.com>
References: <200412140941.56116.jbarnes@engr.sgi.com>
	 <200412141655.04416.bjorn.helgaas@hp.com> <1103101057.6246.19.camel@gaston>
	 <200412150900.18890.jbarnes@engr.sgi.com>
Content-Type: text/plain
Date: Thu, 16 Dec 2004 15:55:22 +0100
Message-Id: <1103208922.25262.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 09:00 -0800, Jesse Barnes wrote:

> Good, because that's exactly what it does.  The arch is responsible for 
> returning the legacy I/O port or legacy ISA memory base address given a 
> pci_dev, which is used as a base for the page offset passed into mmap.  So 
> e.g. mmap(..., 0xa0000) after doing ioctl(fd, PCIIOC_MMAP_IS_LEGACY_MEM, ...) 
> would get you the VGA framebuffer for the device corresponding to 'fd'.

Sounds good... The only thing is a pci_dev may not be available if you
have a PCI->ISA bridge, tho you may just use the pci_dev of the
bridge...

> > There is some work done by Jon Smirl in this area (a VGA access
> > arbitration driver).
> 
> I think Dave Airlie did a version of the vga class driver, and the backend 
> used for /proc/bus/pci could be used for both drivers.  I'm 
> using /proc/bus/pci because it's available now and nearly good enough (i.e. 
> this patch was all I needed to get going).
> 
> Anyway, I'll post another version with Bjorn's suggestion about the ioctl for 
> choosing config or legacy I/O port read/writes, since it looks like the rest 
> of your concerns are dealt with.
> 
> Thanks,
> Jesse
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVDZPjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVDZPjq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVDZPj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:39:28 -0400
Received: from colo.lackof.org ([198.49.126.79]:20955 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261576AbVDZPjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:39:22 -0400
Date: Tue, 26 Apr 2005 09:41:49 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alexander Nyberg <alexn@dsv.su.se>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, jgarzik@pobox.com,
       cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426154149.GA2612@colo.lackof.org>
References: <1114458325.983.17.camel@localhost.localdomain> <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 04:14:13PM -0400, Alan Stern wrote:
> > Not sure what you mean by "make kexec work nicer" but if it is because
> > some devices don't work after a kexec I have some objections.
> 
> That was indeed the reason, at least in my case.  The newly-rebooted
> kernel doesn't work too well when there are active devices, with no driver
> loaded, doing DMA and issuing IRQs because they were never shut down.

This is also a problem at "normal" boot time.  BIOS may leave devices
still doing DMA if BIOS (or the arch equivalent) was using the device.
This problem is obvious for systems with an IOMMU (e.g. parisc).
See drivers/parisc/sba_iommu.c for an example of where I try to
deal with active DMA at boot time *before* PCI bus walks have occurred.
Masking IRQs is trivial in comparison to dealing with active DMA.

> > What about the kexec-on-panic?

Same problem - just much more likely to hit the issue and completely
crash the box or corrupt memory.

grant

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUAEXvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266020AbUAEXry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:47:54 -0500
Received: from bolt.sonic.net ([208.201.242.18]:23684 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S266043AbUAEXpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:45:55 -0500
Date: Mon, 5 Jan 2004 15:45:54 -0800
From: David Hinds <dhinds@sonic.net>
To: linux-kernel@vger.kernel.org, Amit <mehrotraamit@yahoo.co.in>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040105154554.B12970@sonic.net>
References: <20040105120707.A18107@sonic.net> <20040105230016.D11207@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105230016.D11207@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 11:00:16PM +0000, Russell King wrote:
> On Mon, Jan 05, 2004 at 12:07:07PM -0800, David Hinds wrote:
> > 
> > In arch/i386/kernel/setup.c we have:
> > 
> > 	/* Tell the PCI layer not to allocate too close to the RAM area.. */
> > 	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
> > 	if (low_mem_size > pci_mem_start)
> > 		pci_mem_start = low_mem_size;
> > 
> > which is meant to round up pci_mem_start to the nearest 1 MB boundary
> > past the top of physical RAM.  However this does not consider highmem.
> > Should this just be using max_pfn rather than max_low_pfn?
> > 
> > (I have a report of this failing on a laptop with a highmem kernel,
> > causing a PCI memory resource to be allocated on top of a RAM area)
> 
> Beware - people sometimes use mem= to tell the kernel how much RAM is
> available for its use.  Unfortunately, this overrides the E820 map,
> and causes the kernel to believe that all memory above the end of RAM
> is available for use.
> 
> This is not the case, especially on ACPI systems.

Yes and that was the original reason for this snippet of code.  It is
just a quick fix and shouldn't be needed if the E820 map is correct or
if the user has specified a correct mem= parameter.

-- Dave


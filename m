Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVBXVEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVBXVEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVBXVEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:04:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:954 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262473AbVBXVEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:04:02 -0500
Message-ID: <421E4132.4010006@pobox.com>
Date: Thu, 24 Feb 2005 16:03:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Terence Ripperda <tripperda@nvidia.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit pci bar on a 32-bit kernel
References: <20050224202218.GK4801@hygelac>
In-Reply-To: <20050224202218.GK4801@hygelac>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda wrote:
> Hello,
> 
> we've gotten a customer report of a problem whereby our framebuffer is
> not visible through the kernel. the kernel data structures in struct
> pci_dev have bar1 (our framebuffer) set to 0, and the bar does not
> appear in /proc/pci.
> 
> after a little investigation, it appears that the bios allocated a
> 64-bit bar in pci config space. our gpu claims 64-bit support in pci
> config space and the cpu is an em64t. but the customer is running a
> 32-bit kernel on the em64t, which is a reasonable thing to do. it
> turns out the pci driver does not like 64-bit bars on a 32-bit kernel
> and prints out the following messages during boot:
> 
> PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=5
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
> PCI: Unable to handle 64-bit address space for
> PCI: Unable to handle 64-bit address space for
> PCI: Unable to handle 64-bit address for device 03:00.0
> PCI: Unable to handle 64-bit address space for
> 
> Is this an expected problem? Is there any reason why the 32-bit kernel
> couldn't handle 64-bit bars?

hmmm, that's a good question.

I wonder if ioremap() even supports 64-bit addresses on 32-bit platforms?

64-bit MMIO is a bit different from 64-bit DMA; though its still only 
page tables...

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVGGMb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVGGMb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVGGMbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:31:55 -0400
Received: from ns.suse.de ([195.135.220.2]:35257 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261368AbVGGMao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:30:44 -0400
To: "Thomas Crowley" <tbcrowley@hotmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, len.brown@intel.com
Subject: Re: 64bit PCI IORESOURCE_MEM bugs
References: <BAY21-F20B7CAAB5A3DD44D333948A0D90@phx.gbl.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Jul 2005 14:30:42 +0200
In-Reply-To: <BAY21-F20B7CAAB5A3DD44D333948A0D90@phx.gbl.suse.lists.linux.kernel>
Message-ID: <p73r7eakdcd.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Crowley" <tbcrowley@hotmail.com> writes:
> 
> 1) in arch/x86_64/kernel/e820.c    the e820_reserve_resources function
> the line if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
> makes it so any region that
>      starts below the 4Gig mark but ends above 4Gig mark is ignored.

That is already gone in 2.6.13rc1.

> 2) I am unable to get all of my PCI devices to move there addressing
> from the default values to the hole I have given it.  I am getting
> several errors of the form: "PCI: Cannot allocate resource region 8 of
> bridge 0000:00:07.0".  Some of my devices are moving to the proper
> location.
> Neither the code in drivers/pci/probe.c pci_read_bases which gets the
> default addresses for the resources or /arch/i386/pci/i386.c
> pcibios_allocate_bus_resources check to see if the address that are
> being used are reserved.  They just attempt to allocate the memory and
> fail.  It seams like a check should be made in one of these functions
> and if the resources are reserved then the addresses should be
> changed. (Note: 64 bit uses the i386 pci code that is why I am
> pointing out potential errors in the i386 code)

Yes, that code is quite bad and in need of an overhaul. There 
are other problems in there too. Also the default hole selection
algorithm is not very reliable and some BIOS tend to put 
hidden mappings in there. Most likely it needs more support from ACPI.

> I also noticed the reserve kernel param can only take ints so large
> addresses can not be reserved


What reserve kernel param? mem= certainly supports more than 4GB.

-Andi

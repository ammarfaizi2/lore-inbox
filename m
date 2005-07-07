Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVGGPoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVGGPoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVGGPoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:44:32 -0400
Received: from bay21-f1.bay21.hotmail.com ([65.54.233.90]:17079 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261320AbVGGPoP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:44:15 -0400
Message-ID: <BAY21-F1323A627FC24FDAFEC59BA0D80@phx.gbl>
X-Originating-IP: [4.21.76.141]
X-Originating-Email: [tbcrowley@hotmail.com]
In-Reply-To: <p73r7eakdcd.fsf@verdi.suse.de>
From: "Thomas Crowley" <tbcrowley@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, len.brown@intel.com, ak@suse.de
Subject: Re: 64bit PCI IORESOURCE_MEM bugs
Date: Thu, 07 Jul 2005 11:44:10 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Jul 2005 15:44:10.0477 (UTC) FILETIME=[B7B289D0:01C5830A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info.  The reserve param I refer to is the "reserve" param 
from kernel-parameters.txt
"reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area"

On my number 2.  I have been testing just giving 4 Gigs to the OS which ends 
up getting cut into by the iomem addressing and then just trying to use the 
remaining 12Gigs.  However I have been running into trouble when I address 
into the 7-8 Gig area.  Could that be one of the hidden maps you mentioned?

Thanks
Tom

>
>1) in arch/x86_64/kernel/e820.c    the e820_reserve_resources function
>the line if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
>makes it so any region that
>      starts below the 4Gig mark but ends above 4Gig mark is ignored.

That is already gone in 2.6.13rc1.

>2) I am unable to get all of my PCI devices to move there addressing
>from the default values to the hole I have given it.  I am getting
>several errors of the form: "PCI: Cannot allocate resource region 8 of
>bridge 0000:00:07.0".  Some of my devices are moving to the proper
>location.
>Neither the code in drivers/pci/probe.c pci_read_bases which gets the
>default addresses for the resources or /arch/i386/pci/i386.c
>pcibios_allocate_bus_resources check to see if the address that are
>being used are reserved.  They just attempt to allocate the memory and
>fail.  It seams like a check should be made in one of these functions
>and if the resources are reserved then the addresses should be
>changed. (Note: 64 bit uses the i386 pci code that is why I am
>pointing out potential errors in the i386 code)

Yes, that code is quite bad and in need of an overhaul. There
are other problems in there too. Also the default hole selection
algorithm is not very reliable and some BIOS tend to put
hidden mappings in there. Most likely it needs more support from ACPI.

>I also noticed the reserve kernel param can only take ints so large
>addresses can not be reserved


What reserve kernel param? mem= certainly supports more than 4GB.

-Andi



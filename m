Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWGNOpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWGNOpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 10:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWGNOpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 10:45:06 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:48054
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1161109AbWGNOpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 10:45:05 -0400
Message-ID: <44B7ADF8.2070908@ed-soft.at>
Date: Fri, 14 Jul 2006 16:45:12 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
References: <200607141000_MC3-1-C4FF-9460@compuserve.com>
In-Reply-To: <200607141000_MC3-1-C4FF-9460@compuserve.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert schrieb:
> In-Reply-To: <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
> 
> On Thu, 13 Jul 2006 15:15:21 -0700, Linus Torvalds wrote:
> 
>>> From kernel 2.6.16 to kernel 2.6.17 a new check is made.
>>> File arch/i386/pci/mmconfig.c -> funktion pci_mmcfg_init -> check e820_all_mapped
>>> The courios thing is that this check will always fail on the
>>> Intel Macs booted through efi. Parsing of the ACPI_MCFG table
>>> returns e0000000 for the start. But this location is
>>> not in the memory map which the efi firmware have :
>>> BIOS-EFI: 00000000e00f8000 - 00000000e00f9000 (reserved)
>> It _sounds_ like you may not have converted all the EFI types 
>> (EFI_UNUSABLE_MEMORY?), but regardless, I think it would be fine to have 
>> perhaps a "PCI_FORCE_MMCONF" flag that avoided that sanity check, and then 
>> you could have some code (either the EFI code _or_ some DMI code) that 
>> sets it for the Intel Macs.
>>
>> Note that the check in pci_mmcfg_init() shouldn't be some EFI hack itself, 
>> it would be a real flag for the PCI subsystem, independently of EFI (I can 
>> see it being useful for a kernel command line option, even), and the only 
>> EFI connection would be that perhaps the EFI code ends up setting that 
>> flag (especially if there is some EFI command for doing this).
>>
>> Btw, if you do do this, I think we should make sure that the MMCONFIG base 
>> address is reserved in the PCI MMIO resource structures (which we don't do 
>> now, I think - part of the whole point of verifying that it's marked as 
>> E820_RESERVED is exactly the fact that otherwise we migth have problems 
>> with PCI MMIO resource allocations allocating a regular PCI resource over 
>> the MMCONFIG space..)
> 
> I just reposted Rajesh's patch for this (fixed the one previous complaint
> from the list.)
> 
>  Subj:  [patch, take 3] PCI: use ACPI to verify extended config space on x86
> 
> Edgar, can you get it and test?
> 
> Discussion should probably continue in that thread...
> 

I can't find the patch, can you send it ?

cu

Edgar

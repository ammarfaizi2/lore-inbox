Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbWGMVqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWGMVqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbWGMVqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:46:16 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:2743
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1030396AbWGMVqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:46:15 -0400
Message-ID: <44B6BF2F.6030401@ed-soft.at>
Date: Thu, 13 Jul 2006 23:46:23 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
References: <44A04F5F.8030405@ed-soft.at>	<Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>	<44A0CCEA.7030309@ed-soft.at>	<Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>	<44A304C1.2050304@zytor.com>	<m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>	<44A8058D.3030905@zytor.com>	<m11wt3983j.fsf@ebiederm.dsl.xmission.com>	<44AB8878.7010203@ed-soft.at> <m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I converted the efi memory map to use the e820 table.
While converting i discovered why the kernel would allways
fail to boot through efi on Intel Macs without a proper fix.

>From kernel 2.6.16 to kernel 2.6.17 a new check is made.
File arch/i386/pci/mmconfig.c -> funktion pci_mmcfg_init -> check e820_all_mapped
The courios thing is that this check will always fail on the
Intel Macs booted through efi. Parsing of the ACPI_MCFG table
returns e0000000 for the start. But this location is
not in the memory map which the efi firmware have :
BIOS-EFI: 00000000e00f8000 - 00000000e00f9000 (reserved)
So the e820_all_mapped would allways fail.
Anny suggestions how to fix this problem ? Maybe some kind
of whitelisting, using dmi_check_system ?

cu

Edgar Hucek


Eric W. Biederman schrieb:
> Edgar Hucek <hostmaster@ed-soft.at> writes:
> 
>> I agre with you to make efi use the e820 map as a long term solution.
>> But at the moment the efi part is completley broken without my patch.
> 
> But your patch isn't a fix.  It is a hack to make the system boot.
> 
> A patch that performed the same check on the efi memory map,
> or it converted the efi memory map to use an e820 map it would be a fix.
> 
>> At least on Intel Macs. 
>> Without the patch also my Imacfb driver makes no sense, since it is 
>> for efi booted Intel Macs. 
> 
> My point is that the kernel efi support is broken.  You have just found
> the location where the bone is poking through the skin.
> 
> I am tempted to write a patch to delete the x86 efi support at this
> point.  So that it is very clear that it needs to be completely redone.
> 
> Eric
> 


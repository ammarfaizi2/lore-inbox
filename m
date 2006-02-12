Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWBLPgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWBLPgd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 10:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWBLPgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 10:36:33 -0500
Received: from [85.8.13.51] ([85.8.13.51]:5255 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750793AbWBLPgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 10:36:33 -0500
Message-ID: <43EF55F0.2000706@drzeus.cx>
Date: Sun, 12 Feb 2006 16:36:16 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060119)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 1/2] [PCI] Secure Digital Host Controller id and regs
References: <20060211001523.10315.34499.stgit@poseidon.drzeus.cx> <20060212182847.375d7907.vsu@altlinux.ru>
In-Reply-To: <20060212182847.375d7907.vsu@altlinux.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> On Sat, 11 Feb 2006 01:15:23 +0100 Pierre Ossman wrote:
> 
>> diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
>> index d27a78b..e6deda5 100644
>> --- a/include/linux/pci_regs.h
>> +++ b/include/linux/pci_regs.h
>> @@ -108,6 +108,9 @@
>>  #define PCI_INTERRUPT_PIN	0x3d	/* 8 bits */
>>  #define PCI_MIN_GNT		0x3e	/* 8 bits */
>>  #define PCI_MAX_LAT		0x3f	/* 8 bits */
>> +#define PCI_SLOT_INFO		0x40	/* 8 bits */
>> +#define  PCI_SLOT_INFO_SLOTS(x)		((x >> 4) & 7)
>> +#define  PCI_SLOT_INFO_FIRST_BAR_MASK	0x07
> 
> Does this really belong here?  This register is specific to the SDHCI
> class, while all other definitions in pci_regs.h apply to all PCI
> devices.
> 
> drivers/mmc/sdhci.h seems to be a more logical place for SLOT_INFO
> definitions.
> 

Possibly. I wasn't sure of the appropriate header for PCI information.
Although specific for the SDHCI hosts, it's still a PCI register and not
a device register.

If the consensus is that this should be in the driver header then I'll
gladly move it.

Rgds
Pierre


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWBRWHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWBRWHK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 17:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWBRWHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 17:07:10 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:2945 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932225AbWBRWHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 17:07:08 -0500
Message-ID: <43F79A88.5030805@drzeus.cx>
Date: Sat, 18 Feb 2006 23:07:04 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060210)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-25966-1140300426-0001-2"
To: Sergey Vlasov <vsu@altlinux.ru>, Andrew Morton <akpm@osdl.org>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 1/2] [PCI] Secure Digital Host Controller id and regs
References: <20060211001523.10315.34499.stgit@poseidon.drzeus.cx> <20060212182847.375d7907.vsu@altlinux.ru>
In-Reply-To: <20060212182847.375d7907.vsu@altlinux.ru>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-25966-1140300426-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Sergey Vlasov wrote:
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

Fixed here. (It will be added in a -fix patch for sdhci)

Rgds
Pierre


--=_hermes.drzeus.cx-25966-1140300426-0001-2
Content-Type: text/x-patch; name="pci-sdhc-fix.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-sdhc-fix.patch"



From: Pierre Ossman <drzeus@drzeus.cx>


---

 include/linux/pci_regs.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
index e6deda5..d27a78b 100644
--- a/include/linux/pci_regs.h
+++ b/include/linux/pci_regs.h
@@ -108,9 +108,6 @@
 #define PCI_INTERRUPT_PIN	0x3d	/* 8 bits */
 #define PCI_MIN_GNT		0x3e	/* 8 bits */
 #define PCI_MAX_LAT		0x3f	/* 8 bits */
-#define PCI_SLOT_INFO		0x40	/* 8 bits */
-#define  PCI_SLOT_INFO_SLOTS(x)		((x >> 4) & 7)
-#define  PCI_SLOT_INFO_FIRST_BAR_MASK	0x07
 
 /* Header type 1 (PCI-to-PCI bridges) */
 #define PCI_PRIMARY_BUS		0x18	/* Primary bus number */

--=_hermes.drzeus.cx-25966-1140300426-0001-2--

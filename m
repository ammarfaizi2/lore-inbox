Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWIAMoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWIAMoG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 08:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWIAMoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 08:44:06 -0400
Received: from netprotector.fi ([81.209.6.194]:39577 "EHLO mail.osp.fi")
	by vger.kernel.org with ESMTP id S1751165AbWIAMoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 08:44:01 -0400
Message-ID: <44F82B0F.4060901@osp.fi>
Date: Fri, 01 Sep 2006 15:43:59 +0300
From: Johnny Strom <johnny.strom@osp.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060803 Debian/1.7.8-1sarge7.2.1
X-Accept-Language: en
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to make VIA sata board bootable again.
References: <44F7EC15.8040800@osp.fi> <1157111352.3491.1.camel@localhost.localdomain>
In-Reply-To: <1157111352.3491.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> Hi, Can you give me the information of interrupts 
> cat /proc/interrupts 
> 
> XT_PIC or IO-APIC-edge/level ?
> 
> 

Here it is.

cat /proc/interrupts
            CPU0
   0:    1692278          XT-PIC  timer
   1:         40          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   7:     414568          XT-PIC  libata, ohci1394, uhci_hcd:usb2, 
uhci_hcd:usb3, radeon@pci:0000:01:00.0
   8:          4          XT-PIC  rtc
   9:          0          XT-PIC  acpi
  10:     534456          XT-PIC  sk98lin, ehci_hcd:usb1, VIA8237, eth0
  11:          0          XT-PIC  uhci_hcd:usb4, uhci_hcd:usb5
  12:        130          XT-PIC  i8042
  14:         53          XT-PIC  ide0
  15:        101          XT-PIC  ide1
NMI:          0
ERR:          0


Johnny


> On Fri, 2006-09-01 at 11:15 +0300, Johnny Strom wrote:
> 
>>Hello
>>
>>The quirks.c update that went into 2.6.16.17 made an VIA machine here 
>>non bootable from an sata drive (via_sata), the error is:
>>
>>"ATA1 qc timout"
>>"Failed to set xfermode".
>>
>>And later kernel panic becouse no sata disk was found.
>>I tracked it down to the quirk update in 2.6.16.17. Below is a patch 
>>against 2.6.17.11 that reverses the uppdate and makse the system 
>>bootable again.
>>
>>Another option is to find out the PCI_DEVICE_ID_VIA for the motherboard 
>>in question but I could not get that info. Dose someone have an idea how 
>>to find that info? then I can provide an patch that adds the right 
>>PCI_DEVICE_ID_VIA for my motherboard.
>>
>>
>>
>>diff -ur linux-2.6.17.11-org/drivers/pci/quirks.c 
>>linux-2.6.17.11/drivers/pci/quirks.c
>>--- linux-2.6.17.11-org/drivers/pci/quirks.c	2006-09-01 
>>10:38:31.135747500 +0300
>>+++ linux-2.6.17.11/drivers/pci/quirks.c	2006-09-01 10:42:28.870605000 +0300
>>@@ -652,13 +652,7 @@
>>  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>>  	}
>>  }
>>-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, 
>>quirk_via_irq);
>>-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, 
>>quirk_via_irq);
>>-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, 
>>quirk_via_irq);
>>-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, 
>>quirk_via_irq);
>>-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, 
>>quirk_via_irq);
>>-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, 
>>quirk_via_irq);
>>-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, 
>>quirk_via_irq);
>>+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
>>
>>  /*
>>   * VIA VT82C598 has its device ID settable and many BIOSes
>>
>>
>>
>>Signed-off-by: johnny.strom@osp.fi
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 


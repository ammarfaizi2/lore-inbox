Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUIVBW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUIVBW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 21:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267514AbUIVBW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 21:22:58 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:4578 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266821AbUIVBWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 21:22:52 -0400
Date: Wed, 22 Sep 2004 10:24:40 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [ACPI] [PATCH] PCI IRQ resource deallocation support [2/3]
In-reply-to: <200409210857.59457.bjorn.helgaas@hp.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: acpi-devel@lists.sourceforge.net,
       Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>, akpm@osdl.org,
       greg@kroah.com, len.brown@intel.com, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Message-id: <4150D458.3050400@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <414FEBDB.2050201@soft.fujitsu.com>
 <200409210857.59457.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thank you for your feedbacks.

Bjorn Helgaas wrote:

> On Tuesday 21 September 2004 2:52 am, Kenji Kaneshige wrote:
>> + * This function undoes the effect of one call to acpi_register_gsi().
>> + * If this matches the last regstration, any IRQ resources for gsi
> 
> s/regstration/registration/ (also other occurrences below).

Oops..
I'll fix these.

> 
>> +void
>> +acpi_pci_irq_disable (
>> + struct pci_dev  *dev)
>> +{
>> + unsigned char irq_disabled, irq;
> 
> pci_dev.irq is unsigned int, not unsigned char, so irq_disabled
> should be unsigned int as well.
> 

I'll fix this, thanks.


>> +  * dev->irq is cleared by BIOS-assigned IRQ set during boot.
>> +  */
>> + pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
>> + if (irq)
>> +  pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>> + dev->irq = irq;
> 
> Why do we need to fiddle with dev->irq?  I think it should
> just be undefined after acpi_pci_irq_disable().

I had been considering what the "undefined dev->irq" was.
In fact, I had other ideas that was clearing it by zero or
-1 (0xffffffff). But I didn't know if we can use these values
as a undefined IRQ number. So I'm clearing it by the value
which was assigned by PCI core code (pci_read_irq()) before
acpi_pci_irq_enable() was called. 

How do you think?

Thanks,
Kenji Kaneshige



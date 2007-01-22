Return-Path: <linux-kernel-owner+w=401wt.eu-S1751958AbXAVQs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbXAVQs2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 11:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbXAVQs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 11:48:27 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:34051 "EHLO
	imf22aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751958AbXAVQs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 11:48:26 -0500
Message-ID: <45B4EAD3.6030404@bellsouth.net>
Date: Mon, 22 Jan 2007 10:48:19 -0600
From: Jay Cliburn <jacliburn@bellsouth.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: jeff@garzik.org, shemminger@osdl.org, csnook@redhat.com, hch@infradead.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       atl1-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
References: <20070121210655.GD2702@osprey.hogchain.net> <1169454156.3055.1256.camel@laptopd505.fenrus.org>
In-Reply-To: <1169454156.3055.1256.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan, thank you very much for reviewing the driver.

Arjan van de Ven wrote:
> On Sun, 2007-01-21 at 15:06 -0600, Jay Cliburn wrote:
[snip]
>> +void atl1_irq_disable(struct atl1_adapter *adapter)
>> +{
>> +	atomic_inc(&adapter->irq_sem);
>> +	iowrite32(0, adapter->hw.hw_addr + REG_IMR);
>> +	synchronize_irq(adapter->pdev->irq);
>> +}
> 
> doesn't this want a PCI posting flush?
> I'm also a bit sceptical about irq_sem ...

PCI posting flush will be added.  Would you mind elaborating on your 
skepticism about irq_sem?

>> +/**
>> + * When ACPI resume on some VIA MotherBoard, the Interrupt Disable bit/0x400
>> + * on PCI Command register is disable.
>> + * The function enable this bit.
>> + * Brackett, 2006/03/15
>> + */
>> +static void atl1_via_workaround(struct atl1_adapter *adapter)
>> +{
>> +	unsigned long value;
>> +
>> +	value = ioread16(adapter->hw.hw_addr + PCI_COMMAND);
>> +	if (value & PCI_COMMAND_INTX_DISABLE)
>> +		value &= ~PCI_COMMAND_INTX_DISABLE;
>> +	iowrite32(value, adapter->hw.hw_addr + PCI_COMMAND);
>> +}
> 
> hmm I wonder if this shouldn't be a more generic PCI level quirk, not so
> much a driver level quirk...

The vendor put this code here, and we're loathe to remove it unless 
absolutely necessary.  Is it okay with you if we leave it?

Thanks,
Jay


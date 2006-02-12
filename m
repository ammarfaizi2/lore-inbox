Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWBLRYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWBLRYx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWBLRYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:24:53 -0500
Received: from [85.8.13.51] ([85.8.13.51]:6535 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750817AbWBLRYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:24:52 -0500
Message-ID: <43EF6F61.6000407@drzeus.cx>
Date: Sun, 12 Feb 2006 18:24:49 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060119)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 2/2] [MMC] Secure Digital Host Controller Interface driver
References: <20060211001523.10315.34499.stgit@poseidon.drzeus.cx>	<20060211001525.10315.30769.stgit@poseidon.drzeus.cx> <20060212201407.70761172.vsu@altlinux.ru>
In-Reply-To: <20060212201407.70761172.vsu@altlinux.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:

> The interrupt handler can be called immediately after request_irq()
> completes (even if you are sure that the device itself cannot generate
> interrupts at this point, the interrupt line can be shared).  And
> host->lock is not yet initialized - oops...
> 

Ah. I'll fix that.

> 
> The same problem as with request_irq(), just from the other side - until
> free_irq() returns, you may still get calls to your interrupt handler,
> and host->ioaddr is already unmapped - oops again.
> 

Ditto.

>> +
>> +	mmc_free_host(mmc);
>> +}
>> +
>> +static int __devinit sdhci_probe(struct pci_dev *pdev,
>> +	const struct pci_device_id *ent)
>> +{
>> +	int ret, i;
>> +	u8 slots;
>> +	struct sdhci_chip *chip;
>> +
>> +	BUG_ON(pdev == NULL);
>> +	BUG_ON(ent == NULL);
> 
> IMHO these BUG_ON() calls are overkill.
> 

I prefer BUG_ON():s since they print a line number. A page fault induced
oops just gives me a byte offset into the compiled function.

> [...]
>> +typedef struct sdhci_host *sdhci_host_p;
> 
> The general policy seems to be "typedefs are evil"...

Fair enough. It didn't get much usage anyway.


Thanks for the code review. :)

Rgds
Pierre

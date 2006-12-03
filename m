Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933061AbWLCNDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061AbWLCNDn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759645AbWLCNDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:03:43 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:17869 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1758606AbWLCNDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:03:42 -0500
Message-ID: <4572CB2B.8050406@garzik.org>
Date: Sun, 03 Dec 2006 08:03:39 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
References: <200612010958.kB19wGbg002454@alkaid.it.uu.se> <4572CA7A.6010103@gmail.com>
In-Reply-To: <4572CA7A.6010103@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Hello, Mikael.
> 
> Thanks for doing this.
> 
> Mikael Pettersson wrote:
> [--snip--]
>> +static void pdc_freeze(struct ata_port *ap)
>> +{
>> +	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
>> +	u32 tmp;
>> +
>> +	tmp = readl(mmio + PDC_CTLSTAT);
>> +	tmp |= PDC_IRQ_DISABLE;
>> +	tmp &= ~PDC_DMA_ENABLE;
>> +	writel(tmp, mmio + PDC_CTLSTAT);
>> +	readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? sata_sil does this */
> 
> Just drop the above line.
> 
>> +}
>> +
>> +static void pdc_thaw(struct ata_port *ap)
>> +{
>> +	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
>> +	u32 tmp;
>> +
>> +	/* clear IRQ */
>> +	readl(mmio + PDC_INT_SEQMASK);
>> +
>> +	/* turn IRQ back on */
>> +	tmp = readl(mmio + PDC_CTLSTAT);
>> +	tmp &= ~PDC_IRQ_DISABLE;
>> +	writel(tmp, mmio + PDC_CTLSTAT);
>> +	readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? */
> 
> Ditto.

Why do you think these flushes are not needed?

	Jeff




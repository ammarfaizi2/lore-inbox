Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWIUGaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWIUGaW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 02:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWIUGaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 02:30:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:18830 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750696AbWIUGaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 02:30:21 -0400
Message-ID: <45123179.8090903@pobox.com>
Date: Thu, 21 Sep 2006 02:30:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
CC: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>	 <1157962200.10526.10.camel@localhost.localdomain>	 <1158051351.14448.97.camel@localhost.localdomain>	 <ada3bax2lzw.fsf@cisco.com>  <4506C789.4050404@pobox.com>	 <1158749825.7973.9.camel@localhost.localdomain>	 <45121486.3070503@pobox.com> <1158817598.11110.7.camel@localhost.localdomain>
In-Reply-To: <1158817598.11110.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zang Roy-r61911 wrote:
> On Thu, 2006-09-21 at 12:26, Jeff Garzik wrote:
>> Zang Roy-r61911 wrote:
>>> +#define TSI108_ETH_WRITE_REG(offset, val) \
>>> +     writel(le32_to_cpu(val),data->regs + (offset))
>>> +
>>> +#define TSI108_ETH_READ_REG(offset) \
>>> +     le32_to_cpu(readl(data->regs + (offset)))
>>> +
>>> +#define TSI108_ETH_WRITE_PHYREG(offset, val) \
>>> +     writel(le32_to_cpu(val), data->phyregs + (offset))
>>> +
>>> +#define TSI108_ETH_READ_PHYREG(offset) \
>>> +     le32_to_cpu(readl(data->phyregs + (offset)))
>>
>> NAK:
>>
>> 1) writel() and readl() are defined to be little endian.
>>
>> If your platform is different, then your platform should have its own 
>> foobus_writel() and foobus_readl().
> 
> Tsi108 bridge is designed for powerpc platform. Originally, I use
> out_be32() and in_be32(). While there is no obvious reason to object
> using this bridge in a little endian system. Maybe some extra hardware
> logic needed for the bus interface. le32_to_cpu() can  be aware the
> endian difference.

To restate, readl() should read a little endian value, and return a 
CPU-endian value.  writel() should receive a CPU-endian value, and write 
a little endian value.

If your platform's readl/writel doesn't do that, it's broken.

That's why normal PCI drivers can use readl() and writel() on either 
big-endian or little-endian machines, without needing to use le32_to_cpu().

	Jeff




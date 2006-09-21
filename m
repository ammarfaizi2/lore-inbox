Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWIUE0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWIUE0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 00:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIUE0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 00:26:54 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:45706 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750787AbWIUE0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 00:26:53 -0400
Message-ID: <45121486.3070503@pobox.com>
Date: Thu, 21 Sep 2006 00:26:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
CC: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>	 <1157962200.10526.10.camel@localhost.localdomain>	 <1158051351.14448.97.camel@localhost.localdomain>	 <ada3bax2lzw.fsf@cisco.com>  <4506C789.4050404@pobox.com> <1158749825.7973.9.camel@localhost.localdomain>
In-Reply-To: <1158749825.7973.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zang Roy-r61911 wrote:
> +#define TSI108_ETH_WRITE_REG(offset, val) \
> +	writel(le32_to_cpu(val),data->regs + (offset))
> +
> +#define TSI108_ETH_READ_REG(offset) \
> +	le32_to_cpu(readl(data->regs + (offset)))
> +
> +#define TSI108_ETH_WRITE_PHYREG(offset, val) \
> +	writel(le32_to_cpu(val), data->phyregs + (offset))
> +
> +#define TSI108_ETH_READ_PHYREG(offset) \
> +	le32_to_cpu(readl(data->phyregs + (offset)))


NAK:

1) writel() and readl() are defined to be little endian.

If your platform is different, then your platform should have its own 
foobus_writel() and foobus_readl().

2) TSI108_ETH_WRITE_REG() is just way too long.  TSI_READ(), 
TSI_WRITE(), TSI_READ_PHY() and TSI_WRITE_PHY() would be far more readable.

More in next email.


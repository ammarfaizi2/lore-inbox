Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWIUFqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWIUFqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 01:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWIUFqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 01:46:52 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:29084 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1750776AbWIUFqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 01:46:51 -0400
Subject: Re: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45121486.3070503@pobox.com>
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>
	 <1157962200.10526.10.camel@localhost.localdomain>
	 <1158051351.14448.97.camel@localhost.localdomain>
	 <ada3bax2lzw.fsf@cisco.com>  <4506C789.4050404@pobox.com>
	 <1158749825.7973.9.camel@localhost.localdomain>
	 <45121486.3070503@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1158817598.11110.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Sep 2006 13:46:39 +0800
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2006 05:46:47.0435 (UTC) FILETIME=[53C01DB0:01C6DD41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 12:26, Jeff Garzik wrote:
> Zang Roy-r61911 wrote:
> > +#define TSI108_ETH_WRITE_REG(offset, val) \
> > +     writel(le32_to_cpu(val),data->regs + (offset))
> > +
> > +#define TSI108_ETH_READ_REG(offset) \
> > +     le32_to_cpu(readl(data->regs + (offset)))
> > +
> > +#define TSI108_ETH_WRITE_PHYREG(offset, val) \
> > +     writel(le32_to_cpu(val), data->phyregs + (offset))
> > +
> > +#define TSI108_ETH_READ_PHYREG(offset) \
> > +     le32_to_cpu(readl(data->phyregs + (offset)))
> 
> 
> NAK:
> 
> 1) writel() and readl() are defined to be little endian.
> 
> If your platform is different, then your platform should have its own 
> foobus_writel() and foobus_readl().

Tsi108 bridge is designed for powerpc platform. Originally, I use
out_be32() and in_be32(). While there is no obvious reason to object
using this bridge in a little endian system. Maybe some extra hardware
logic needed for the bus interface. le32_to_cpu() can  be aware the
endian difference.
Any comment?

> 
> 2) TSI108_ETH_WRITE_REG() is just way too long.  TSI_READ(), 
> TSI_WRITE(), TSI_READ_PHY() and TSI_WRITE_PHY() would be far more
> readable.
> 
> More in next email.
> 
I will modify the name.
Roy



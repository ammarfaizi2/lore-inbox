Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbULNXXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbULNXXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbULNXVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:21:54 -0500
Received: from [213.146.154.40] ([213.146.154.40]:2714 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261745AbULNXT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:19:27 -0500
Date: Tue, 14 Dec 2004 23:19:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk@arm.linux.org.uk>,
       Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: Re: [PATCH 5/6] mv643xx_eth: Add support for platform device interface
Message-ID: <20041214231924.GC11617@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dale Farnsworth <dale@farnsworth.org>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, Ralf Baechle <ralf@linux-mips.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Manish Lachwani <mlachwani@mvista.com>,
	Brian Waite <brian@waitefamily.us>,
	"Steven J. Hill" <sjhill@realitydiluted.com>
References: <20041213220949.GA19609@xyzzy> <20041213221921.GE19951@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213221921.GE19951@xyzzy>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#undef MV_READ
> +#define MV_READ(offset)	\
> +	readl(mv64x60_eth_shared_base - MV64340_ETH_SHARED_REGS + offset)
> +
> +#undef MV_WRITE
> +#define MV_WRITE(offset, data)	\
> +	writel((u32)data,	\
> +		mv64x60_eth_shared_base - MV64340_ETH_SHARED_REGS + offset)
> +

please use different accessors.  Best static inlines without shouting names.

> + */
> +static void eth_port_uc_addr_get(struct net_device *dev, unsigned char *MacAddr)
> +{
> +	struct mv64340_private *mp = netdev_priv(dev);
> +	unsigned int port_num = mp->port_num;
> +        u32 MacLow;
> +        u32 MacHigh;
> +
> +        MacLow = MV_READ(MV64340_ETH_MAC_ADDR_LOW(port_num));
> +        MacHigh = MV_READ(MV64340_ETH_MAC_ADDR_HIGH(port_num));
> +
> +        MacAddr[5] = (MacLow) & 0xff;
> +        MacAddr[4] = (MacLow >> 8) & 0xff;
> +        MacAddr[3] = (MacHigh) & 0xff;
> +        MacAddr[2] = (MacHigh >> 8) & 0xff;
> +        MacAddr[1] = (MacHigh >> 16) & 0xff;
> +        MacAddr[0] = (MacHigh >> 24) & 0xff;

Please avoid mixed UpperLower case variable names.  Also make sure to use
tabs for indentation again.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbULOSdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbULOSdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbULOSdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:33:03 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:20101 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S262438AbULOSco
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:32:44 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 15 Dec 2004 11:32:40 -0700
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mv643xx_eth: Add support for platform device interface
Message-ID: <20041215183240.GC17904@xyzzy>
References: <20041213220949.GA19609@xyzzy> <20041213221921.GE19951@xyzzy> <20041214231924.GC11617@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214231924.GC11617@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 11:19:24PM +0000, Christoph Hellwig wrote:
> > +#undef MV_READ
> > +#define MV_READ(offset)	\
> > +	readl(mv64x60_eth_shared_base - MV64340_ETH_SHARED_REGS + offset)
> > +
> > +#undef MV_WRITE
> > +#define MV_WRITE(offset, data)	\
> > +	writel((u32)data,	\
> > +		mv64x60_eth_shared_base - MV64340_ETH_SHARED_REGS + offset)
> > +
> 
> please use different accessors.  Best static inlines without shouting names.

The existing drivers uses MV_READ/MV_WRITE throughout.  I agree it's
ugly but I kept them to minimize the patch size.  I plan to submit a
patch to rename them and make these static inline functions as soon as
this set of patches is "in the queue".

> > + */
> > +static void eth_port_uc_addr_get(struct net_device *dev, unsigned char *MacAddr)
> > +{
> > +	struct mv64340_private *mp = netdev_priv(dev);
> > +	unsigned int port_num = mp->port_num;
> > +        u32 MacLow;
> > +        u32 MacHigh;
> > +
> > +        MacLow = MV_READ(MV64340_ETH_MAC_ADDR_LOW(port_num));
> > +        MacHigh = MV_READ(MV64340_ETH_MAC_ADDR_HIGH(port_num));
> > +
> > +        MacAddr[5] = (MacLow) & 0xff;
> > +        MacAddr[4] = (MacLow >> 8) & 0xff;
> > +        MacAddr[3] = (MacHigh) & 0xff;
> > +        MacAddr[2] = (MacHigh >> 8) & 0xff;
> > +        MacAddr[1] = (MacHigh >> 16) & 0xff;
> > +        MacAddr[0] = (MacHigh >> 24) & 0xff;
> 
> Please avoid mixed UpperLower case variable names.  Also make sure to use
> tabs for indentation again.

I copied this from an existing driver, but I agree and will change.

Thanks,
-Dale

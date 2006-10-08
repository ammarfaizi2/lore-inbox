Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWJHH1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWJHH1m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 03:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWJHH1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 03:27:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35599 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750758AbWJHH1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 03:27:41 -0400
Date: Sun, 8 Oct 2006 07:27:26 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Misha Tomushev <misha@fabric7.com>
Cc: Jeff Garzik <jeff@garzik.org>, KERNEL Linux <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/10] VIOC: New Network Device Driver
Message-ID: <20061008072726.GA5589@ucw.cz>
References: <200610051105.51259.misha@fabric7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610051105.51259.misha@fabric7.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> +	ecmd->phy_address = 0;	/* !!! Stole from e1000 */
> +	ecmd->speed = 3;	/* !!! Stole from e1000 */

Eh?

> +static void vnic_get_regs(struct net_device *netdev,
> +			  struct ethtool_regs *regs, void *p)
> +{
> +	struct vnic_device *vnicdev = netdev->priv;
> +	struct vioc_device *viocdev = vnicdev->viocdev;
> +	char *regs_buff = p;
> +
> +	memset(regs_buff, 0, VNIC_REGS_CNT * VNIC_REGS_LINE_LEN);
> +
> +	regs->version = 1;
> +
> +	sprintf(regs_buff, "%08Lx = %08x\n",
> +		GETRELADDR(VREG_BMC_GLOBAL, VIOC_BMC, 0),
> +		VIOC_READ_REG(VREG_BMC_GLOBAL, VIOC_BMC, 0, viocdev));
> +	regs_buff += strlen(regs_buff);
> +
> +	sprintf(regs_buff, "%08Lx = %08x\n",
> +		GETRELADDR(VREG_BMC_DEBUG, VIOC_BMC, 0),
> +		VIOC_READ_REG(VREG_BMC_DEBUG, VIOC_BMC, 0, viocdev));
> +	regs_buff += strlen(regs_buff);
> +
> +	sprintf(regs_buff, "%08Lx = %08x\n",
> +		GETRELADDR(VREG_BMC_DEBUGPRIV, VIOC_BMC, 0),
> +		VIOC_READ_REG(VREG_BMC_DEBUGPRIV, VIOC_BMC, 0, viocdev));
> +	regs_buff += strlen(regs_buff);
> +
> +	sprintf(regs_buff, "%08Lx = %08x\n",
> +		GETRELADDR(VREG_BMC_FABRIC, VIOC_BMC, 0),
> +		VIOC_READ_REG(VREG_BMC_FABRIC, VIOC_BMC, 0, viocdev));
> +	regs_buff += strlen(regs_buff);
> +
> +	sprintf(regs_buff, "%08Lx = %08x\n",
> +		GETRELADDR(VREG_BMC_VNIC_EN, VIOC_BMC, 0),
> +		VIOC_READ_REG(VREG_BMC_VNIC_EN, VIOC_BMC, 0, viocdev));
> +	regs_buff += strlen(regs_buff);
> +
> +	sprintf(regs_buff, "%08Lx = %08x\n",
> +		GETRELADDR(VREG_BMC_PORT_EN, VIOC_BMC, 0),
> +		VIOC_READ_REG(VREG_BMC_PORT_EN, VIOC_BMC, 0, viocdev));
> +	regs_buff += strlen(regs_buff);
> +
> +	sprintf(regs_buff, "%08Lx = %08x\n",
> +		GETRELADDR(VREG_BMC_VNIC_CFG, VIOC_BMC, 0),
> +		VIOC_READ_REG(VREG_BMC_VNIC_CFG, VIOC_BMC, 0, viocdev));
> +	regs_buff += strlen(regs_buff);
> +
> +	sprintf(regs_buff, "%08Lx = %08x\n",
> +		GETRELADDR(VREG_IHCU_RXDQEN, VIOC_IHCU, 0),
> +		VIOC_READ_REG(VREG_IHCU_RXDQEN, VIOC_IHCU, 0, viocdev));
> +	regs_buff += strlen(regs_buff);
> +
> +	sprintf(regs_buff, "%08Lx = %08x\n",
> +		GETRELADDR(VREG_VENG_VLANTAG, VIOC_VENG, vnicdev->vnic_id),
> +		VIOC_READ_REG(VREG_VENG_VLANTAG, VIOC_VENG, vnicdev->vnic_id,
> +			      viocdev));
> +	regs_buff += strlen(regs_buff);
> +
> +	sprintf(regs_buff, "%08Lx = %08x\n",
> +		GETRELADDR(VREG_VENG_TXD_CTL, VIOC_VENG, vnicdev->vnic_id),
> +		VIOC_READ_REG(VREG_VENG_TXD_CTL, VIOC_VENG, vnicdev->vnic_id,
> +			      viocdev));
> +	regs_buff += strlen(regs_buff);
> +
> +}

This looks ugly. What interface is that?
							Pavel
-- 
Thanks for all the (sleeping) penguins.

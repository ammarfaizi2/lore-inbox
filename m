Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWJISSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWJISSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 14:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932811AbWJISSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 14:18:22 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:59013 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S932327AbWJISSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 14:18:21 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 6/10] VIOC: New Network Device Driver
Date: Mon, 9 Oct 2006 11:09:39 -0700
User-Agent: KMail/1.5.1
Cc: Jeff Garzik <jeff@garzik.org>, KERNEL Linux <linux-kernel@vger.kernel.org>
References: <200610051105.51259.misha@fabric7.com> <20061008072726.GA5589@ucw.cz>
In-Reply-To: <20061008072726.GA5589@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610091109.39793.misha@fabric7.com>
X-OriginalArrivalTime: 09 Oct 2006 18:18:18.0739 (UTC) FILETIME=[4BB29430:01C6EBCF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 October 2006 12:27 am, Pavel Machek wrote:
> Hi!
>
> > +	ecmd->phy_address = 0;	/* !!! Stole from e1000 */
> > +	ecmd->speed = 3;	/* !!! Stole from e1000 */
>
> Eh?
You are right. Will fix.
>
> > +static void vnic_get_regs(struct net_device *netdev,
> > +			  struct ethtool_regs *regs, void *p)
> > +{
> > +	struct vnic_device *vnicdev = netdev->priv;
> > +	struct vioc_device *viocdev = vnicdev->viocdev;
> > +	char *regs_buff = p;
> > +
> > +	memset(regs_buff, 0, VNIC_REGS_CNT * VNIC_REGS_LINE_LEN);
> > +
> > +	regs->version = 1;
> > +
> > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > +		GETRELADDR(VREG_BMC_GLOBAL, VIOC_BMC, 0),
> > +		VIOC_READ_REG(VREG_BMC_GLOBAL, VIOC_BMC, 0, viocdev));
> > +	regs_buff += strlen(regs_buff);
> > +
> > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > +		GETRELADDR(VREG_BMC_DEBUG, VIOC_BMC, 0),
> > +		VIOC_READ_REG(VREG_BMC_DEBUG, VIOC_BMC, 0, viocdev));
> > +	regs_buff += strlen(regs_buff);
> > +
> > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > +		GETRELADDR(VREG_BMC_DEBUGPRIV, VIOC_BMC, 0),
> > +		VIOC_READ_REG(VREG_BMC_DEBUGPRIV, VIOC_BMC, 0, viocdev));
> > +	regs_buff += strlen(regs_buff);
> > +
> > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > +		GETRELADDR(VREG_BMC_FABRIC, VIOC_BMC, 0),
> > +		VIOC_READ_REG(VREG_BMC_FABRIC, VIOC_BMC, 0, viocdev));
> > +	regs_buff += strlen(regs_buff);
> > +
> > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > +		GETRELADDR(VREG_BMC_VNIC_EN, VIOC_BMC, 0),
> > +		VIOC_READ_REG(VREG_BMC_VNIC_EN, VIOC_BMC, 0, viocdev));
> > +	regs_buff += strlen(regs_buff);
> > +
> > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > +		GETRELADDR(VREG_BMC_PORT_EN, VIOC_BMC, 0),
> > +		VIOC_READ_REG(VREG_BMC_PORT_EN, VIOC_BMC, 0, viocdev));
> > +	regs_buff += strlen(regs_buff);
> > +
> > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > +		GETRELADDR(VREG_BMC_VNIC_CFG, VIOC_BMC, 0),
> > +		VIOC_READ_REG(VREG_BMC_VNIC_CFG, VIOC_BMC, 0, viocdev));
> > +	regs_buff += strlen(regs_buff);
> > +
> > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > +		GETRELADDR(VREG_IHCU_RXDQEN, VIOC_IHCU, 0),
> > +		VIOC_READ_REG(VREG_IHCU_RXDQEN, VIOC_IHCU, 0, viocdev));
> > +	regs_buff += strlen(regs_buff);
> > +
> > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > +		GETRELADDR(VREG_VENG_VLANTAG, VIOC_VENG, vnicdev->vnic_id),
> > +		VIOC_READ_REG(VREG_VENG_VLANTAG, VIOC_VENG, vnicdev->vnic_id,
> > +			      viocdev));
> > +	regs_buff += strlen(regs_buff);
> > +
> > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > +		GETRELADDR(VREG_VENG_TXD_CTL, VIOC_VENG, vnicdev->vnic_id),
> > +		VIOC_READ_REG(VREG_VENG_TXD_CTL, VIOC_VENG, vnicdev->vnic_id,
> > +			      viocdev));
> > +	regs_buff += strlen(regs_buff);
> > +
> > +}
>
> This looks ugly. What interface is that?
This is the interface between  the driver and ethtool.
Using the text buffer is one way to keep changed limited to one side (driver). Ultimately, I think that this ethtool function (dumping hw registers) should become more generic,
as opposed to what it is now - unique for every individual driver.
> 							Pavel

-- 
Misha Tomushev
misha@fabric7.com



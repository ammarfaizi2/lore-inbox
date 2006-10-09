Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932993AbWJITDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932993AbWJITDy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWJITDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:03:54 -0400
Received: from hera.kernel.org ([140.211.167.34]:16818 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932993AbWJITDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:03:53 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 6/10] VIOC: New Network Device Driver
Date: Mon, 9 Oct 2006 12:03:24 -0700
Organization: OSDL
Message-ID: <20061009120324.56bac955@freekitty>
References: <200610051105.51259.misha@fabric7.com>
	<20061008072726.GA5589@ucw.cz>
	<200610091109.39793.misha@fabric7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1160420605 22041 10.8.0.54 (9 Oct 2006 19:03:25 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 9 Oct 2006 19:03:25 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 11:09:39 -0700
Misha Tomushev <misha@fabric7.com> wrote:

> On Sunday 08 October 2006 12:27 am, Pavel Machek wrote:
> > Hi!
> >
> > > +	ecmd->phy_address = 0;	/* !!! Stole from e1000 */
> > > +	ecmd->speed = 3;	/* !!! Stole from e1000 */
> >
> > Eh?
> You are right. Will fix.
> >
> > > +static void vnic_get_regs(struct net_device *netdev,
> > > +			  struct ethtool_regs *regs, void *p)
> > > +{
> > > +	struct vnic_device *vnicdev = netdev->priv;
> > > +	struct vioc_device *viocdev = vnicdev->viocdev;
> > > +	char *regs_buff = p;
> > > +
> > > +	memset(regs_buff, 0, VNIC_REGS_CNT * VNIC_REGS_LINE_LEN);
> > > +
> > > +	regs->version = 1;
> > > +
> > > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > > +		GETRELADDR(VREG_BMC_GLOBAL, VIOC_BMC, 0),
> > > +		VIOC_READ_REG(VREG_BMC_GLOBAL, VIOC_BMC, 0, viocdev));
> > > +	regs_buff += strlen(regs_buff);
> > > +
> > > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > > +		GETRELADDR(VREG_BMC_DEBUG, VIOC_BMC, 0),
> > > +		VIOC_READ_REG(VREG_BMC_DEBUG, VIOC_BMC, 0, viocdev));
> > > +	regs_buff += strlen(regs_buff);
> > > +
> > > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > > +		GETRELADDR(VREG_BMC_DEBUGPRIV, VIOC_BMC, 0),
> > > +		VIOC_READ_REG(VREG_BMC_DEBUGPRIV, VIOC_BMC, 0, viocdev));
> > > +	regs_buff += strlen(regs_buff);
> > > +
> > > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > > +		GETRELADDR(VREG_BMC_FABRIC, VIOC_BMC, 0),
> > > +		VIOC_READ_REG(VREG_BMC_FABRIC, VIOC_BMC, 0, viocdev));
> > > +	regs_buff += strlen(regs_buff);
> > > +
> > > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > > +		GETRELADDR(VREG_BMC_VNIC_EN, VIOC_BMC, 0),
> > > +		VIOC_READ_REG(VREG_BMC_VNIC_EN, VIOC_BMC, 0, viocdev));
> > > +	regs_buff += strlen(regs_buff);
> > > +
> > > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > > +		GETRELADDR(VREG_BMC_PORT_EN, VIOC_BMC, 0),
> > > +		VIOC_READ_REG(VREG_BMC_PORT_EN, VIOC_BMC, 0, viocdev));
> > > +	regs_buff += strlen(regs_buff);
> > > +
> > > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > > +		GETRELADDR(VREG_BMC_VNIC_CFG, VIOC_BMC, 0),
> > > +		VIOC_READ_REG(VREG_BMC_VNIC_CFG, VIOC_BMC, 0, viocdev));
> > > +	regs_buff += strlen(regs_buff);
> > > +
> > > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > > +		GETRELADDR(VREG_IHCU_RXDQEN, VIOC_IHCU, 0),
> > > +		VIOC_READ_REG(VREG_IHCU_RXDQEN, VIOC_IHCU, 0, viocdev));
> > > +	regs_buff += strlen(regs_buff);
> > > +
> > > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > > +		GETRELADDR(VREG_VENG_VLANTAG, VIOC_VENG, vnicdev->vnic_id),
> > > +		VIOC_READ_REG(VREG_VENG_VLANTAG, VIOC_VENG, vnicdev->vnic_id,
> > > +			      viocdev));
> > > +	regs_buff += strlen(regs_buff);
> > > +
> > > +	sprintf(regs_buff, "%08Lx = %08x\n",
> > > +		GETRELADDR(VREG_VENG_TXD_CTL, VIOC_VENG, vnicdev->vnic_id),
> > > +		VIOC_READ_REG(VREG_VENG_TXD_CTL, VIOC_VENG, vnicdev->vnic_id,
> > > +			      viocdev));
> > > +	regs_buff += strlen(regs_buff);
> > > +
> > > +}
> >
> > This looks ugly. What interface is that?
> This is the interface between  the driver and ethtool.
> Using the text buffer is one way to keep changed limited to one side (driver). Ultimately, I think that this ethtool function (dumping hw registers) should become more generic,
> as opposed to what it is now - unique for every individual driver.
> > 							Pavel
> 

Please just dump binary like other drivers.  The code for ethtool allows per device
decode. Move the decode to there.  

Yes, ethtool source does need a more generic register description language.

-- 
Stephen Hemminger <shemminger@osdl.org>

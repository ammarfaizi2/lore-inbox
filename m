Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266067AbRGLGvz>; Thu, 12 Jul 2001 02:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbRGLGvp>; Thu, 12 Jul 2001 02:51:45 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:57608 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S266067AbRGLGvd>; Thu, 12 Jul 2001 02:51:33 -0400
Date: Wed, 11 Jul 2001 23:51:28 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Juri Haberland <juri@koschikode.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire net driver update
In-Reply-To: <20010711151630.7597.qmail@babel.spoiled.org>
Message-ID: <Pine.LNX.4.33.0107112349390.17462-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jul 2001, Juri Haberland wrote:

> > Also, if you feel adventurous, search for these lines in the driver:
> >         /* Configure the PCI bus bursts and FIFO thresholds. */
> >         np->tx_mode = 0x0C04;           /* modified when link is up. */
> > *       writel(0x8000 | np->tx_mode, ioaddr + TxMode);
> > *       writel(np->tx_mode, ioaddr + TxMode);
> > 
> > and comment out those two marked with a *. At that point you should have 
> > essentially the 2.4.6 driver, so see if they behaves similarly.
> 
> I'll try that tomorrow.

Actually, try this patch first. I believe it will fix your problems, but
I'd like to confirm it.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
------------------------------
--- /src/vanilla/linux-2.4/drivers/net/starfire.c	Thu Jul 12 02:47:25 2001
+++ linux/drivers/net/starfire.c	Thu Jul 12 01:35:04 2001
@@ -987,12 +987,12 @@
 	struct netdev_private *np = dev->priv;
 	u16 reg0;
 
+	mdio_write(dev, np->phys[0], MII_ADVERTISE, np->advertising);
 	mdio_write(dev, np->phys[0], MII_BMCR, BMCR_RESET);
 	udelay(500);
 	while (mdio_read(dev, np->phys[0], MII_BMCR) & BMCR_RESET);
 
 	reg0 = mdio_read(dev, np->phys[0], MII_BMCR);
-	mdio_write(dev, np->phys[0], MII_ADVERTISE, np->advertising);
 
 	if (np->autoneg) {
 		reg0 |= BMCR_ANENABLE | BMCR_ANRESTART;


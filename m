Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265725AbUFSOLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265725AbUFSOLS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 10:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUFSOLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 10:11:18 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58247 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265725AbUFSOLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 10:11:15 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Francois Romieu <romieu@fr.zoreil.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Subject: Re: [PATCH] new device support for forcedeth.c second try
Date: Sat, 19 Jun 2004 16:15:48 +0200
User-Agent: KMail/1.5.3
Cc: Brian Lazara <blazara@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew de Quincey <adq@lidskialf.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40D43DC3.9000909@gmx.net> <20040619155551.A1517@electric-eye.fr.zoreil.com>
In-Reply-To: <20040619155551.A1517@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191615.48903.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 of June 2004 15:55, Francois Romieu wrote:
> Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> :
> [...]
>
> > +static int phy_reset(struct net_device *dev)
> > +{
> > +	struct fe_priv *np = get_nvpriv(dev);
> > +	u32 miicontrol;
> > +	u32 microseconds = 0;
> > +	u32 milliseconds = 0;
> > +
> > +	miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
> > +	miicontrol |= BMCR_RESET;
> > +	if (mii_rw(dev, np->phyaddr, MII_BMCR, miicontrol)) {
> > +		return -1;
> > +	}
> > +
> > +	//wait for 500ms
> > +	mdelay(500);
> > +
> > +	//must wait till reset is deasserted
> > +	while (miicontrol & BMCR_RESET) {
> > +		udelay(NV_MIIBUSY_DELAY);
> > +		miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
> > +		microseconds++;
> > +		if (microseconds == 20) {
> > +			microseconds = 0;
> > +			milliseconds++;
> > +		}
> > +		if (milliseconds > 50)
> > +			return -1;
> > +	}
> > +	return 0;
> > +}
>
> Afaiks this function is not called from a spinlocked nor is it
> time-critical. You should make it use schedule_timeout().

msleep()


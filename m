Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263923AbUFSOvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUFSOvn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 10:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUFSOvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 10:51:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56721 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263923AbUFSOvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 10:51:36 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Subject: Re: [PATCH] new device support for forcedeth.c second try
Date: Sat, 19 Jun 2004 16:56:02 +0200
User-Agent: KMail/1.5.3
Cc: Francois Romieu <romieu@fr.zoreil.com>, Brian Lazara <blazara@nvidia.com>,
       Christoph Hellwig <hch@infradead.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew de Quincey <adq@lidskialf.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40D43DC3.9000909@gmx.net> <200406191615.48903.bzolnier@elka.pw.edu.pl> <40D44F1D.6090701@gmx.net>
In-Reply-To: <40D44F1D.6090701@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191656.02066.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 of June 2004 16:35, Carl-Daniel Hailfinger wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 19 of June 2004 15:55, Francois Romieu wrote:
> >>Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> :
> >>[...]
> >>
> >>>+static int phy_reset(struct net_device *dev)
> >>>+{
> >>>+	struct fe_priv *np = get_nvpriv(dev);
> >>>+	u32 miicontrol;
> >>>+	u32 microseconds = 0;
> >>>+	u32 milliseconds = 0;
> >>>+
> >>>+	miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
> >>>+	miicontrol |= BMCR_RESET;
> >>>+	if (mii_rw(dev, np->phyaddr, MII_BMCR, miicontrol)) {
> >>>+		return -1;
> >>>+	}
> >>>+
> >>>+	//wait for 500ms
> >>>+	mdelay(500);
> >>>+
> >>>+	//must wait till reset is deasserted
> >>>+	while (miicontrol & BMCR_RESET) {
> >>>+		udelay(NV_MIIBUSY_DELAY);
> >>>+		miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
> >>>+		microseconds++;
> >>>+		if (microseconds == 20) {
> >>>+			microseconds = 0;
> >>>+			milliseconds++;
> >>>+		}
> >>>+		if (milliseconds > 50)
> >>>+			return -1;
> >>>+	}
> >>>+	return 0;
> >>>+}
> >>
> >>Afaiks this function is not called from a spinlocked nor is it
> >>time-critical. You should make it use schedule_timeout().
>
> Thanks for highlighting the above code. I saw it and wanted to fix it, but
> then I got sidetracked and forgot.
>
> > msleep()
>
> Bartlomiej, could you prepare a patch to move the msleep() function from
> drivers/scsi/libata-core.c to include/linux/delay.h ? This is going to
> benefit users besides libata.

gregkh did this already in 2.6.7

cheers.


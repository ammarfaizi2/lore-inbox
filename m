Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUFSPMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUFSPMv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 11:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUFSPMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 11:12:51 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:46530 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263943AbUFSPMs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 11:12:48 -0400
Date: Sat, 19 Jun 2004 17:08:38 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Brian Lazara <blazara@nvidia.com>,
       Christoph Hellwig <hch@infradead.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew de Quincey <adq@lidskialf.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new device support for forcedeth.c second try
Message-ID: <20040619170838.A2300@electric-eye.fr.zoreil.com>
References: <40D43DC3.9000909@gmx.net> <20040619155551.A1517@electric-eye.fr.zoreil.com> <200406191615.48903.bzolnier@elka.pw.edu.pl> <40D44F1D.6090701@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40D44F1D.6090701@gmx.net>; from c-d.hailfinger.kernel.2004@gmx.net on Sat, Jun 19, 2004 at 04:35:09PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> :
[...]
>         //must wait till reset is deasserted
>         while (miicontrol & BMCR_RESET) {
>                 udelay(NV_MIIBUSY_DELAY);
>                 miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
>                 /* FIXME: 1000 tries seem excessive */
>                 if (tries++ > 1000)
>                         return -1;
>         }
>         return 0;
> }
> 
> 
> Better?

Fine: at least the FIXME clearly says that it must be fixed :o)

NV_MIIBUSY_DELAY is only 50us but it still means a pair of cycles on
nowadays CPU. If memory serves me right, the reset can take quite some
time per 802.3. So I would simply schedule_timeout() if going through
the while() loop is required at all.

--
Ueimor

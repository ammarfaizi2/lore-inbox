Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265112AbUFBIlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbUFBIlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 04:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUFBIlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 04:41:16 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:2268 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S265112AbUFBIlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 04:41:14 -0400
Date: Wed, 2 Jun 2004 10:40:25 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Pavel Machek <pavel@ucw.cz>
Cc: jgarzik@pobox.com,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [trivial] no mili-bits-per-second for via-rhine
Message-ID: <20040602084025.GA9626@k3.hellgate.ch>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, jgarzik@pobox.com,
	Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20040601214345.GA32700@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601214345.GA32700@elf.ucw.cz>
X-Operating-System: Linux 2.6.7-rc1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, I have a patch for 2.6 in my out queue which deletes the
option/full_duplex code (including the part below) entirely. Nobody
complained when it was unusable for the longest time (kind of fixed
recently), and the code is still a mess. People using 2.6 should use
ethtool _if_ they need to force media, because that works.

So as via-rhine maintainer, I recommend applying to 2.4 and leaving
2.6 as is.

FWIW cleaning up all the printed messages in via-rhine is on my todo
list.

Roger

On Tue, 01 Jun 2004 23:43:45 +0200, Pavel Machek wrote:
> Hi!
> 
> via-rhine claims to support 100 mili-bits-per-second mode and one
> place and 100 mega-bit-second mode ("100 mega-bit-seconds of storage
> for only $1?"). This cleans it up.
> 
> 								Pavel
> 
> --- tmp/linux/drivers/net/via-rhine.c	2004-05-20 23:08:19.000000000 +0200
> +++ linux/drivers/net/via-rhine.c	2004-05-20 23:11:26.000000000 +0200
> @@ -863,12 +863,12 @@
>  		if (np->default_port & 0x330) {
>  			/* FIXME: shouldn't someone check this variable? */
>  			/* np->medialock = 1; */
> -			printk(KERN_INFO "  Forcing %dMbs %s-duplex operation.\n",
> +			printk(KERN_INFO "  Forcing %dMbps %s-duplex operation.\n",
>  				   (option & 0x300 ? 100 : 10),
>  				   (option & 0x220 ? "full" : "half"));
>  			if (np->mii_cnt)
>  				mdio_write(dev, np->phys[0], MII_BMCR,
> -						   ((option & 0x300) ? 0x2000 : 0) |  /* 100mbps? */
> +						   ((option & 0x300) ? 0x2000 : 0) |  /* 100Mbps? */
>  						   ((option & 0x220) ? 0x0100 : 0));  /* Full duplex? */
>  		}
>  	}

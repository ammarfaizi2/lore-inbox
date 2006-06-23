Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932969AbWFWJ2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbWFWJ2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932967AbWFWJ2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:28:38 -0400
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:35784 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S932966AbWFWJ2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:28:37 -0400
Date: Fri, 23 Jun 2006 18:28:28 +0900 (JST)
Message-Id: <20060623.182828.92343173.nemoto@toshiba-tops.co.jp>
To: alessandro.zummo@towertech.it
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] RTC: add rtc-ds1553 and rtc-ds1742 driver
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060623001622.65db7c0f@inspiron>
References: <20060623.001927.74750182.anemo@mba.ocn.ne.jp>
	<20060623001622.65db7c0f@inspiron>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 00:16:22 +0200, Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
> > Add RTC drivers for the Dallas DS1553 and DS1742 RTC chip.
> > 
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
>  please split this into two patches.

OK, I'll send two patches soon.

>  on which systems will we likely find those twos? no extra
>  depends?

MIPS, PPC, ARM, etc.  I think no extra depends needed.

> > +static int ds1553_rtc_ioctl(struct device *dev, unsigned int cmd,
> > +			    unsigned long arg)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> > +
> > +	if (pdata->irq < 0)
> > +		return -ENOIOCTLCMD;
> 
>  inappropriate -Exxx . maybe -ENODEV?.

No, it is intentional.  If irq is not available, I want to fall back
into emulation in rtc-dev.c.

Thanks for your comments.
---
Atsushi Nemoto

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWBGVfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWBGVfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 16:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbWBGVfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 16:35:34 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:53449 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S965005AbWBGVfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 16:35:34 -0500
Subject: Re: [PATCH] spi: Fix modular master driver remove and device
	suspend/remove
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, dvrabel@arcom.com,
       David Brownell <david-b@pacbell.net>
In-Reply-To: <20060207080351.GA3588@flint.arm.linux.org.uk>
References: <43e80e2b.EZgObIkBxyg9Mb6O%stephen@streetfiresound.com>
	 <20060207080351.GA3588@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Tue, 07 Feb 2006 13:35:25 -0800
Message-Id: <1139348125.4549.447.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 08:03 +0000, Russell King wrote:
> On Mon, Feb 06, 2006 at 07:04:11PM -0800, stephen@streetfiresound.com wrote:
> > --- linux-2.6.16-rc2/drivers/spi/spi.c	2006-02-06 18:39:31.746537258 -0800
> > +++ linux-spi/drivers/spi/spi.c	2006-02-06 18:39:45.353334421 -0800
> > @@ -90,7 +90,7 @@ static int spi_suspend(struct device *de
> >  	int			value;
> >  	struct spi_driver	*drv = to_spi_driver(dev->driver);
> >  
> > -	if (!drv->suspend)
> > +	if (!drv || !drv->suspend)
> 
> Shouldn't this be dev->driver ?  If dev->driver is NULL, drv may be
> non-NULL due to an offset in the structure.
> 
If I understand your comment correctly, the implementation of to_spi_drv
protects against this by returning NULL if dev->driver is NULL. This is
implementation dependent and I can make the test explicit if you want?

-Stephen




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbWBGV4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWBGV4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 16:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWBGV4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 16:56:34 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:29340 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965165AbWBGV4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 16:56:34 -0500
From: David Brownell <david-b@pacbell.net>
To: stephen@streetfiresound.com
Subject: Re: [PATCH] spi: Fix modular master driver remove and device suspend/remove
Date: Tue, 7 Feb 2006 13:56:29 -0800
User-Agent: KMail/1.7.1
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, greg@kroah.com,
       linux-kernel@vger.kernel.org, dvrabel@arcom.com
References: <43e80e2b.EZgObIkBxyg9Mb6O%stephen@streetfiresound.com> <20060207080351.GA3588@flint.arm.linux.org.uk> <1139348125.4549.447.camel@localhost.localdomain>
In-Reply-To: <1139348125.4549.447.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071356.30045.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 1:35 pm, Stephen Street wrote:
> On Tue, 2006-02-07 at 08:03 +0000, Russell King wrote:

> > > @@ -90,7 +90,7 @@ static int spi_suspend(struct device *de
> > >  	int			value;
> > >  	struct spi_driver	*drv = to_spi_driver(dev->driver);
> > >  
> > > -	if (!drv->suspend)
> > > +	if (!drv || !drv->suspend)
> > 
> > Shouldn't this be dev->driver ?  If dev->driver is NULL, drv may be
> > non-NULL due to an offset in the structure.
> > 
> If I understand your comment correctly, the implementation of to_spi_drv
> protects against this by returning NULL if dev->driver is NULL. This is
> implementation dependent 

I'd say that to_spi_driver() is defined that way, specifically
to avoid that class of nasty bug.

> and I can make the test explicit if you want? 
> 

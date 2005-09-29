Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVI2XSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVI2XSD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVI2XSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:18:03 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:26592 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750778AbVI2XSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:18:01 -0400
Date: Fri, 30 Sep 2005 01:18:14 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: Re: [PATCH] Fix IXP4xx MTD driver no cast warning
Message-ID: <20050929231814.GB30887@wohnheim.fh-wedel.de>
References: <20050929195205.GA30002@plexity.net> <20050929205252.GG7684@flint.arm.linux.org.uk> <20050929212055.GA311@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050929212055.GA311@plexity.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 September 2005 14:20:55 -0700, Deepak Saxena wrote:
> On Sep 29 2005, at 21:52, Russell King was caught saying:
> > On Thu, Sep 29, 2005 at 12:52:05PM -0700, Deepak Saxena wrote:
> > > Fix following warning:
> > > 
> > > drivers/mtd/maps/ixp4xx.c: In function 'ixp4xx_flash_probe':
> > > drivers/mtd/maps/ixp4xx.c:199: warning: assignment makes integer from
> > > pointer without a cast
> > > 
> > > Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
> > > 
> > > diff --git a/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
> > > --- a/drivers/mtd/maps/ixp4xx.c
> > > +++ b/drivers/mtd/maps/ixp4xx.c
> > > @@ -196,7 +196,7 @@ static int ixp4xx_flash_probe(struct dev
> > >  		goto Error;
> > >  	}
> > >  
> > > -	info->map.map_priv_1 = ioremap(dev->resource->start,
> > > +	info->map.map_priv_1 = (unsigned long)ioremap(dev->resource->start,
> > 
> > Shouldn't this be using info->map.virt instead of the old map.map_priv_1 ?
> 
> I think when I wrote this, having a !0 value in map->virt would cause the mtd
> core to assume that the map driver supported point()ing and direct copy
> of data.  Looking at the mtd code it looks like this assumption might
> have gone away...will change code.

A check on this field is still used in cfi_intelext_point(), but you
can disable the point stuff by setting map->phys to NO_XIP - as you
already do.

Jörn

-- 
All art is but imitation of nature.
-- Lucius Annaeus Seneca

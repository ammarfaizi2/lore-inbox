Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUHGIir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUHGIir (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 04:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUHGIir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 04:38:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56795 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266345AbUHGIip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 04:38:45 -0400
Date: Sat, 7 Aug 2004 10:38:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Stefan Meyknecht <sm0407@nurfuerspam.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom: MO-drive open write fix (trivial)
Message-ID: <20040807083835.GA24860@suse.de>
References: <200408061833.30751.sm0407@nurfuerspam.de> <20040806220654.5e857bed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806220654.5e857bed.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2004, Andrew Morton wrote:
> Stefan Meyknecht <sm0407@nurfuerspam.de> wrote:
> >
> > [PATCH] cdrom: MO-drive open write fix
> > 
> > Allow mounting mo-drives readwrite.
> > 
> > Please apply.
> > 
> > Stefan
> > 
> > 
> > --- linux/drivers/cdrom/cdrom.c.orig	2004-08-06 18:04:16.269803330 +0200
> > +++ linux/drivers/cdrom/cdrom.c	2004-08-06 18:04:33.570828588 +0200
> > @@ -899,7 +899,7 @@ int cdrom_open(struct cdrom_device_info 
> >  			ret = -EROFS;
> >  			if (cdrom_open_write(cdi))
> >  				goto err;
> > -			if (!CDROM_CAN(CDC_RAM))
> > +			if (!CDROM_CAN(CDC_RAM) && !CDROM_CAN(CDC_MO_DRIVE))
> >  				goto err;
> >  			ret = 0;
> >  		}
> 
> I forwarded this to Jens last time you sent it and he said "Not really,
> CDC_RAM is an umbrella that should already cover these devices.  I'll reply
> to him."
> 
> So...  could you describe the actual bug which you're seeing - maybe
> there's some different fix which we need.

Sorry, guess I forgot to reply on linux-kernel. What I mean is that MO
drives should just have CDC_RAM set - it doesn't denote a specific
device type, rather just the ability to work like a hard drive. If you
could look into why that isn't set for your mo device and send a patch
for that, it would be much better.

Jens


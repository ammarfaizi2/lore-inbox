Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbTH2UZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbTH2UZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:25:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:52867 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263108AbTH2UYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:24:15 -0400
Date: Fri, 29 Aug 2003 13:24:07 -0700
From: Greg KH <greg@kroah.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] s390 (5/8): common i/o layer.
Message-ID: <20030829202407.GA2482@kroah.com>
References: <20030829171005.GF1242@mschwid3.boeblingen.de.ibm.com> <87vfsggtb2.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vfsggtb2.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 04:25:21AM +0900, OGAWA Hirofumi wrote:
> Martin Schwidefsky <schwidefsky@de.ibm.com> writes:
> 
> > --- linux-2.6/drivers/s390/cio/css.c	Sat Aug 23 01:52:24 2003
> > +++ linux-2.6-s390/drivers/s390/cio/css.c	Fri Aug 29 18:55:10 2003
> 
> [...]
> 
> > @@ -97,8 +85,7 @@
> >  	sch->dev.bus = &css_bus_type;
> >  
> >  	/* Set a name for the subchannel */
> > -	strlcpy (sch->dev.name, subchannel_types[sch->st], DEVICE_NAME_SIZE);
> > -	snprintf (sch->dev.bus_id, DEVICE_ID_SIZE, "0:%04x", sch->irq);
> > +	snprintf (sch->dev.bus_id, DEVICE_ID_SIZE, "0.0.%04x", sch->irq);
> >  
> >  	/* make it known to the system */
> >  	ret = device_register(&sch->dev);
> > diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
> > --- linux-2.6/drivers/s390/cio/device.c	Sat Aug 23 01:58:10 2003
> > +++ linux-2.6-s390/drivers/s390/cio/device.c	Fri Aug 29 18:55:10 2003
> 
> [...]
> 
> > @@ -537,8 +537,7 @@
> >  	init_timer(&cdev->private->timer);
> >  
> >  	/* Set an initial name for the device. */
> > -	snprintf (cdev->dev.name, DEVICE_NAME_SIZE,"ccw device");
> > -	snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0:%04x",
> > +	snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0.0.%04x",
> >  		  sch->schib.pmcw.dev);
> >  
> >  	/* Increase counter of devices currently in recognition. */
> 
> Shouldn't the above use BUS_ID_SIZE instead of DEVICE_ID_SIZE?

Yes, DEVICE_ID_SIZE should be removed from the kernel, as it's not used
for any structures, only some modules that use it improperly (including
the USB core, I'll go fix that up right now...)

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288788AbSA3Hxx>; Wed, 30 Jan 2002 02:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSA3Hxo>; Wed, 30 Jan 2002 02:53:44 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:18604 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288814AbSA3Hxi>; Wed, 30 Jan 2002 02:53:38 -0500
Message-Id: <200201291722.g0THMVZZ001354@tigger.cs.uni-dortmund.de>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: wpeter@us.ibm.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@suse.de>
Subject: Re: Encountered a Null Pointer Problem on the SCSI Layer 
In-Reply-To: Message from Pete Zaitcev <zaitcev@redhat.com> 
   of "Mon, 28 Jan 2002 18:17:54 EST." <200201282317.g0SNHs326065@devserv.devel.redhat.com> 
Date: Tue, 29 Jan 2002 18:22:31 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> said:
> > --- linux/drivers/scsi/sd.c     Fri Jan 25 14:01:07 2002
> > +++ linux-2.4.17-diskio/drivers/scsi/sd.c       Fri Jan 25 13:57:01 2002
> > @@ -279,7 +279,7 @@
> >         target = DEVICE_NR(dev);
> > 
> >         dpnt = &rscsi_disks[target];
> > -       if (!dpnt)
> > +       if (!dpnt->device)
> >                 return NULL;    /* No such device */
> >         return &dpnt->device->request_queue;
> >  }
> 
> > Wai Yee Peter Wong
> 
> There's one more of theese
> 
> --- linux-2.4.18-pre1/drivers/scsi/sd.c	Fri Nov  9 14:05:06 2001
> +++ linux-2.4.18-pre1-p3/drivers/scsi/sd.c	Mon Jan 28 14:46:11 2002
> @@ -302,7 +302,7 @@
>  
>  	dpnt = &rscsi_disks[dev];
>  	if (devm >= (sd_template.dev_max << 4) ||
> -	    !dpnt ||
> +	    !dpnt->device ||
>  	    !dpnt->device->online ||
>   	    block + SCpnt->request.nr_sectors > sd[devm].nr_sects) {
>  		SCSI_LOG_HLQUEUE(2, printk("Finishing %ld sectors\n", SCpnt->re
> quest.nr_sectors));

Is is possible for dpnt to be NULL here? Should perhaps be checked...
-- 
Horst von Brand			     http://counter.li.org # 22616

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVFEOOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVFEOOb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 10:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVFEOO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 10:14:29 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:1294 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261563AbVFEOOX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 10:14:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KJVBczaSWf+VeZjv8ITrslGeELH9kO/kpmss4b3EW04s5Kg4LpOPJrH4lf35HxqaD5Nlmm82jyjd3uTBxkszzOVeV3pjv4eIZJTYbXlPWaQ0Xrjw0Z2IFDJJwFEoJzH+fwhVSouakTY5KwNqz7hsY1LefwW4uJBdB5V08lW751o=
Message-ID: <58cb370e050605071472e95465@mail.gmail.com>
Date: Sun, 5 Jun 2005 16:14:21 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 08/09] blk: update IDE to use the new blk_ordered.
Cc: Tejun Heo <htejun@gmail.com>, axboe@suse.de, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <42A2A00F.9050402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050605055337.6301E65A@htj.dyndns.org>
	 <20050605055337.ADD601D4@htj.dyndns.org> <42A2A00F.9050402@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Tejun Heo wrote:
> > @@ -176,6 +176,18 @@ static ide_startstop_t __ide_do_rw_disk(
> >                       lba48 = 0;
> >       }
> >
> > +     if (blk_fua_rq(rq) &&
> > +         (!rq_data_dir(rq) || !drive->select.b.lba || !lba48)) {
> > +             if (!rq_data_dir(rq))
> > +                     printk(KERN_WARNING "%s: FUA READ unsupported\n",
> > +                            drive->name);
> > +             else
> > +                     printk(KERN_WARNING "%s: FUA request received but "
> > +                            "cannot use LBA48\n", drive->name);
> > +             ide_end_request(drive, 0, 0);
> > +             return ide_stopped;
> > +     }
> > +
> 
> 
> Does this string of tests really need to be added to the main fast path?
> 
> It would be better to simply guarantee that this check need never exist
> in the IDE driver, by guaranteeing that the block layer will never send
> a FUA-READ command to a driver that does not wish it.
> 
>         Jeff

Seconded, plus please use <linux/ata.h> instead of <linux/hdreg.h>
for adding new opcodes.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288810AbSAQO2y>; Thu, 17 Jan 2002 09:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288827AbSAQO2m>; Thu, 17 Jan 2002 09:28:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25618 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288810AbSAQO2c>;
	Thu, 17 Jan 2002 09:28:32 -0500
Date: Thu, 17 Jan 2002 15:28:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "Andre M. Hedrick" <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] 2.5.3-pre1 ide updates
Message-ID: <20020117152824.M20994@suse.de>
In-Reply-To: <20020117144648.L20994@suse.de> <5.1.0.14.2.20020117141843.02615430@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020117141843.02615430@pop.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17 2002, Anton Altaparmakov wrote:
> Hi Jens,
> 
> I think there is a bug here...
> 
> At 13:46 17/01/02, Jens Axboe wrote:
> >diff -urN -X exclude /ata/linux-2.5.3-pre1/drivers/ide/ide-taskfile.c 
> >linux/drivers/ide/ide-taskfile.c
> >--- /ata/linux-2.5.3-pre1/drivers/ide/ide-taskfile.c    Thu Jan 17 
> >06:32:54 2002
> >+++ linux/drivers/ide/ide-taskfile.c    Thu Jan 17 06:29:13 2002
> >@@ -994,10 +1032,11 @@
> >        if (!msect) {
> >                nsect = 1;
> >                while (rq->current_nr_sectors) {
> >-                       pBuf = rq->buffer + ((rq->nr_sectors - 
> >rq->current_nr_sectors) * SECTOR_SIZE);
> >+                       pBuf = ide_unmap_buffer(rq, &flags);
> 
> That should be: pBuf = ide_map_buffer(rq, &flags);
> 
> But I think it actually ought to be:
> 
>                         pBuf = ide_map_rq(rq, &flags)
> 
> and the below unmap should consequently be:
> 
>                         ide_unmap_rq(rq, pBuf, &flags)
> 
> In either case it's wrong at the moment AFAICS...

Yeah you are right, typo... There's another mixup in there too, but only
a very minor race. I'll update the patch asap.

-- 
Jens Axboe


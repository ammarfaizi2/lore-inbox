Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290572AbSARBAp>; Thu, 17 Jan 2002 20:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290574AbSARBAe>; Thu, 17 Jan 2002 20:00:34 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:28927 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S290572AbSARBAV>; Thu, 17 Jan 2002 20:00:21 -0500
Message-Id: <5.1.0.14.2.20020118004455.00b07800@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 18 Jan 2002 01:00:10 +0000
To: Robert Love <rml@tech9.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] 2.5.3-pre1 ata-253p1-2
Cc: Andre Hedrick <andre@linuxdiskcert.org>, Jens Axboe <axboe@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1011309216.2668.205.camel@phantasy>
In-Reply-To: <Pine.LNX.4.10.10201171455360.344-100000@master.linux-ide.org>
 <Pine.LNX.4.10.10201171455360.344-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:13 17/01/02, Robert Love wrote:
>On Thu, 2002-01-17 at 17:59, Andre Hedrick wrote:
> > This kernel is totally ACB-IO or Taskfile Driven, the Config.in Option is
> > to allow user-space access for diagnostics, forensics and OEM feature
> > sets.
>
>Oh, OK -- 2.5.3-pre1 doesn't have Configure.help entries ;)
>But I think Anton sent them, so hopefully we will see them.

Yes I sent them to Linus.

>I guess the configure option just enables the ioctl, then, eh?  Gotcha.

Yup.

> > You have to give Jens the credit for gluing it togather, because there was
> > no way I would have figured out the suttle issues of BIO.  There are
> > serveral additions need to fix all the archs so hope to have something
> > today.
>
>Well, good work to both of you.  It is an excellent driver.  Please
>submit it for pre2.

I second that. 2.5.3-pre1 + 2nd patch from Jens + daft compile fixes is 
running fine on my Athlon/VIA chipset both UDMA100 and PIO4 on my 60GXP 
drive! Brilliant work guys!

There is only one odd thing and that is that PIO transfers are slower in 
2.5.3-pre1 + 2nd patch from Jens + daft compile fixes compared to in 
2.5.2-pre11-vanilla.

PIO mode, hdparm -t /dev/hda:

         on 2.5.3-pre1 + 2nd Jens patch: 4.62MB/s
         on 2.5.2-pre11 vanilla:         7.36MB/s

DMA transfers are the same with both kernels, peaking at 38-39MB/s which is 
I believe the theoretical upper limit for the 60GXP so there was not much 
room for visible improvement (2.5.3-pre1 is slightly faster in that it gave 
in three tests 38.79MB/s while 2.5.2-pre11 gave in three tests 38.32MB/s, 
so if you believe those ACB is .4 MB/s faster).

I don't care that PIO has become slower, all modern devices are happy with 
UDMA, and so am I. (-: But I thought I should mention it.

Note that 2.5.3-pre1 now survives find . -type f -exec md5sum "{}" \; both 
in PIO and UDMA mode so it can really be considered stable on UP system.

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbRF0L4z>; Wed, 27 Jun 2001 07:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265312AbRF0L4q>; Wed, 27 Jun 2001 07:56:46 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:51451 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S264934AbRF0L43>; Wed, 27 Jun 2001 07:56:29 -0400
Message-ID: <3B39C96D.8BCDB2D7@pp.inet.fi>
Date: Wed, 27 Jun 2001 14:54:21 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Andries.Brouwer@cwi.nl, torvalds@transmeta.com, R.E.Wolff@BitWizard.nl,
        axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: loop device broken in 2.4.6-pre5
In-Reply-To: <UTC200106261041.MAA454888.aeb@vlet.cwi.nl> <5.1.0.14.2.20010626200527.03c285c0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> At 18:59 26/06/2001, Jari Ruusu wrote:
> >Andries.Brouwer@cwi.nl wrote:
> > >     From jari.ruusu@pp.inet.fi Tue Jun 26 10:20:51 2001
> > >
> > >     This patch fixes the problem. Please consider applying.
> > >
> > >     --- linux-2.4.6-pre5/drivers/block/loop.c    Sat Jun 23 07:52:39 2001
> > >     +++ linux/drivers/block/loop.c    Tue Jun 26 09:21:47 2001
> > >     @@ -653,7 +653,7 @@
> > >          bs = 0;
> > >          if (blksize_size[MAJOR(lo_device)])
> > >              bs = blksize_size[MAJOR(lo_device)][MINOR(lo_device)];
> > >     -    if (!bs)
> > >     +    if (!bs || S_ISREG(inode->i_mode))
> > >              bs = BLOCK_SIZE;
> > >
> > >          set_blocksize(dev, bs);
> > >
> > > But why 1024? Next week your neighbour comes and has a file-backed
> > > loop device with an odd number of 512-byte sectors.
> > > If you want a guarantee, then I suppose one should pick 512.
> > > (Or make the set blocksize ioctl also work on loop devices.)
> >
> >Because 1024 was the previous default. Keeping the same default that was
> >used before offers least surprises to users and tools.
> 
> But also makes it not work for odd number of sectors which is much worse IMHO.
> 
> Also it is far more surprising to find that the last sector is lost
> silently than to have a difference in behaviour, incorrect behaviour needs
> to be corrected not kept for backwards compatibility till the end of time.
> And the sooner that happens, the better. Both people and utilities will get
> used to it. Due to that 1024, mkntfs has to mark the disk dirty because it
> can never be sure just how many sectors there really are and hence can't be
> sure whether the backup boot sector was written to the correct place or not...
> 
> Also, the loop device is currently not consistent with the rest of the kernel:
> 
> * kernel physical block device: get_nr_sectors_sys_call returns the real
> number of 512 byte sectors
> * file mounted on loop device: sam sys_call returns the number of sectors & ~1.
> 
> This difference in behaviour causes a much bigger surprise than anything
> else if we are talking about surprises!

OK. My original complaint was that the default could be larger than 1024.
I am happy with 512.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265079AbRFZSBg>; Tue, 26 Jun 2001 14:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbRFZSB0>; Tue, 26 Jun 2001 14:01:26 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:61401 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S265071AbRFZSBF>; Tue, 26 Jun 2001 14:01:05 -0400
Message-ID: <3B38CD65.AB3366A@pp.inet.fi>
Date: Tue, 26 Jun 2001 20:59:01 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: torvalds@transmeta.com, R.E.Wolff@BitWizard.nl, axboe@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: loop device broken in 2.4.6-pre5
In-Reply-To: <UTC200106261041.MAA454888.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>     From jari.ruusu@pp.inet.fi Tue Jun 26 10:20:51 2001
> 
>     This patch fixes the problem. Please consider applying.
> 
>     --- linux-2.4.6-pre5/drivers/block/loop.c    Sat Jun 23 07:52:39 2001
>     +++ linux/drivers/block/loop.c    Tue Jun 26 09:21:47 2001
>     @@ -653,7 +653,7 @@
>          bs = 0;
>          if (blksize_size[MAJOR(lo_device)])
>              bs = blksize_size[MAJOR(lo_device)][MINOR(lo_device)];
>     -    if (!bs)
>     +    if (!bs || S_ISREG(inode->i_mode))
>              bs = BLOCK_SIZE;
> 
>          set_blocksize(dev, bs);
> 
> But why 1024? Next week your neighbour comes and has a file-backed
> loop device with an odd number of 512-byte sectors.
> If you want a guarantee, then I suppose one should pick 512.
> (Or make the set blocksize ioctl also work on loop devices.)

Because 1024 was the previous default. Keeping the same default that was
used before offers least surprises to users and tools.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264525AbRFZKwv>; Tue, 26 Jun 2001 06:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264401AbRFZKwl>; Tue, 26 Jun 2001 06:52:41 -0400
Received: from 20dyn20.com21.casema.net ([213.17.90.20]:57869 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S264532AbRFZKwc>; Tue, 26 Jun 2001 06:52:32 -0400
Message-Id: <200106261052.MAA16148@cave.bitwizard.nl>
Subject: Re: loop device broken in 2.4.6-pre5
In-Reply-To: <UTC200106261041.MAA454888.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl"
 at "Jun 26, 2001 12:41:51 pm"
To: Andries.Brouwer@cwi.nl
Date: Tue, 26 Jun 2001 12:52:29 +0200 (MEST)
CC: jari.ruusu@pp.inet.fi, torvalds@transmeta.com, R.E.Wolff@BitWizard.nl,
        axboe@suse.de, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

I thought the change was a "quick hack" that would make stuff work
(page cache?) near the end of the file. That would mean that this kind
of "quick hack" won't work. 

But if it does anyway, then indeed 512 would be a more appropriate
choice.

I thought I had to convince people, so I chose a sitation that I hoped
people would understand to be likely/possible, to prevent reactions:
"No filesystem will use the last odd numbered 512bytes of a
partition".

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276607AbRI2UUr>; Sat, 29 Sep 2001 16:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276608AbRI2UUi>; Sat, 29 Sep 2001 16:20:38 -0400
Received: from test.astound.net ([24.219.123.215]:55049 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S276607AbRI2UU2> convert rfc822-to-8bit; Sat, 29 Sep 2001 16:20:28 -0400
Date: Sat, 29 Sep 2001 13:16:50 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: RFC (patch below) Re: ide drive problem?
In-Reply-To: <E15nLxO-0001yx-00@mrvdom00.schlund.de>
Message-ID: <Pine.LNX.4.10.10109291309050.28810-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an error that I am considering removing form the user's view.
For the very fact/reason you are pointing out; however, it becomse
more painful when performing error sorting.


On Sat, 29 Sep 2001, Christian [iso-8859-1] Bornträger wrote:

> Hi List, Hi Andre,
> 
> as Mark Hahn made a FAQ entry for the  
> 
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> message, I think we should point all users to this FAQ. I saw this message
> and questions about it very often in this list, so we should help the users 
> to find a fast solution. You know, only a few people read a manual, even in 
> error case.
> 
> Now the output looks like:
> 
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> For further Informations please check: http://www.tux.org/lkml/#s13-3
> 
> 
> 
> This patch applies correct for 2.4.9ac14 and 2.4.10
> 
> diff -r -u linux/drivers/ide/ide.c linux-new/drivers/ide/ide.c
> --- linux/drivers/ide/ide.c     Fri Sep 28 17:36:54 2001
> +++ linux-new/drivers/ide/ide.c Sat Sep 29 17:03:36 2001
> @@ -935,6 +935,9 @@
>                                         printk(", sector=%ld", HWGROUP(drive)->rq->sector);
>                         }
>                 }
> +               if ((stat & READY_STAT) && (stat & SEEK_STAT) && (stat & ERR_STAT)
> +                && (err & ABRT_ERR) && (err & ICRC_ERR))
> +                       printk("\nFor further Informations please check: http://www.tux.org/lkml/#s13-3\n");
>  #endif /* FANCY_STATUS_DUMPS */
>                 printk("\n");
>         }
> 
> 
> greetings
> 
> Christian Bornträger

I like that noise maker!

Cheers,

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Tel: (510) 857-0055 x103
38875 Cherry Street                           Fax: (510) 857-0010
Newark, CA 94560                              Web: www.aslab.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281563AbRKPVow>; Fri, 16 Nov 2001 16:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281562AbRKPVom>; Fri, 16 Nov 2001 16:44:42 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:61882 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S281559AbRKPVo2> convert rfc822-to-8bit; Fri, 16 Nov 2001 16:44:28 -0500
Date: Fri, 16 Nov 2001 19:59:02 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] block-highmem-all-18
In-Reply-To: <20011116093927.E27010@suse.de>
Message-ID: <20011116193057.O1825-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Nov 2001, Jens Axboe wrote:

> Hi,
>
> Version #18 of the patch, the prepare-for-inclusion version. Changes:
>
> - Drop IPS and megaraid changes, too problematic. If anyone has the
>   hardware to really test this and do it properly (aimed at IPS), please
>   do so and send it on. (me)
> - Add CONFIG_HIGHIO configure option, has same effect as the nohighio
>   boot parameter (me)
> - Add sym2 can_dma_32 flag (me)
             ^^^^^^^^^^ Pooaaahhh!:) What's this utter oddity ?
Only dma 32 ? :-)

Just to make things clear about how DMA width can be configured on the
driver at the moment and will ever be:

1) The 3 DMA addressing modes (32 bit, 40 bit and 64 bit limited to 16*4Gb
   are compiled options. The handshaking with other kernel parts is based
   on the pci_set_dma_mask() interface.

2) This DMA adressing mode will probably be auto-configurable on some
   further driver version, but I donnot want any useless code to be
   neither compiled nor executed by the driver for the 99,9.. % of
   real machines  that only need legacy 32 bit DMA addressing (i.e.
   Mode 0 in the driver context).
   Other DMA modes will only apply to the few configurations that
   can be probed as needing larger DMA addressing, even if larger DMA
   addressing will not harm on machines that donnot need the feature.
   As a result the DMA addressing mode will stay a compilation option,
   optionnally auto-probed at 'make kernel|module' time.

Now that things are hopefully clearer:), I donnot see any relevance about
having any additionnal flag related to DMA addressing, at least as far as
the sym-2 driver is concerned.


> - aic7xxx_old can_dma_32 flag (me)
>
> Against 2.4.15-pre5, find it here:
>
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.15-pre5/block-highmem-all-18.bz2

Thanks a lot for your work (despite the odd 'may_dma_somewhat' flag I seem
not to like that much.:) )

  Gérard.


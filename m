Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271687AbRH0KeG>; Mon, 27 Aug 2001 06:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271690AbRH0Kd4>; Mon, 27 Aug 2001 06:33:56 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:9477 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S271687AbRH0Kdv>; Mon, 27 Aug 2001 06:33:51 -0400
Date: Mon, 27 Aug 2001 12:37:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>
Subject: [patch] zero-bounce block highmem I/O, #13
Message-ID: <20010827123700.B1092@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've uploaded a new version. Changes since last time includes the
following:

- Merge BIO_CONTIG from 2.5 bio patches to unify testing of contigious
  buffer heads (BH_CONTIG in 2.4 tree) (me)

- cciss, cpqarray, and ide-dma wrongly used 0 for lastdataend in segment
  merging, which is wrong since 0 is a valid physical address. A case of
  s/NULL/0 substition when changing from virtual to physical tests.
  (davem)

- cciss/cpqarray - drop my_sg list, just use the kernel supplied
  scatterlist. my_sg used unsigned short for length, which is too small.
  (pointed out by davem, fixed by me)

- cciss/cpqarray - rewrite loop-until-empty in request queueing. (me)

- BLK_BOUNCE_ANY was b0rken, the ->bounce_page would wrap and thus not
  work. (pointed davem out by davem, fixed by me -- temporarily, will
  change to test for highest page instead in next version)

- Always use 64-bit type for BLK_BOUNCE_ANY (davem)

- IPS must check number of segments mapped by pci_map_sg instead of
  using the SCSI supplied sg count. (pointed out by davem, fixed by me).
  IPS still has some highmem fixes pending.

2.4.9 version is here:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.9/block-highmem-all-13

2.4.8-ac12 version is here:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.8-ac12/block-highmem-all-13-ac12

-- 
Jens Axboe


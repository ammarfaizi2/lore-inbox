Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277231AbRJRMkv>; Thu, 18 Oct 2001 08:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277278AbRJRMkl>; Thu, 18 Oct 2001 08:40:41 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:10259 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S277231AbRJRMkd>; Thu, 18 Oct 2001 08:40:33 -0400
Date: Thu, 18 Oct 2001 14:40:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Arjan Van de Ven <arjanv@redhat.com>
Subject: [patch] block highmem zero-bounce #17
Message-ID: <20011018144047.E4825@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ingo reported a severe 3ware corruption bug today which I've fixed, so
it seemed due time for a new version of the patch.

- Fix scsi_merge not setting sg->address for "legacy" drivers not using
  the PCI DMA interface. Stupid bug, since the entire I/O path is
  supposed to remain untouched (basically) for drivers not enabling
  highmem... I really think this is the last of such bugs. (me)

- Add 'nohighio' boot flag to disable I/O to highmem I/O. x86 only (me)

- Finally remember to reverse size/offset arguments in cciss and
  cpqarray. Fixed a long time ago, forgot to commit to the tree... (me,
  arjan, others)

- aic7xxx uses wrong DMA mask (arjan)

- Remove SCSI host single_sg_ok, it is implied by can_dma_32 anyways
  (arjan)

- Enable can_dma_32 on aic7xxx_old (arjan)

Patch is considered solid. Find it here:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.13-pre4/block-highmem-all-17.bz2

-- 
Jens Axboe


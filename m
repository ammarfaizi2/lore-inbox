Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbRE1P75>; Mon, 28 May 2001 11:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263082AbRE1P7r>; Mon, 28 May 2001 11:59:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30725 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263080AbRE1P7n>;
	Mon, 28 May 2001 11:59:43 -0400
Date: Mon, 28 May 2001 17:59:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] 4GB I/O, 2nd edition
Message-ID: <20010528175940.M9102@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One minor bug found that would possibly oops if the SCSI pool ran out of
memory for the sg table and had to revert to a single segment request.
This should never happen, as the pool is sized after number of devices
and queue depth -- but it needed fixing anyway.

Other changes:

- Support cpqarray and cciss (two separate patches)

- Cleanup IDE DMA on/off wrt highmem

- Move run_task_queue back again in __wait_on_buffer. Need to look at
  why this hurts performance.

- Don't account front merge as sequence decrement in elevator (will not
  incur a seek)

- Dump info when highmem I/O is enabled, mainly for debugging

This version has run the cerberus hell-hound all night (IDE and SCSI),
no bugs discovered. The patches were split up even more, for easier
reading etc. It will not apply cleanly to latest 2.4.5-ac kernels, let
me know if you want a version for that...

The patches (in apply order)

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.5/

- block-highmem-2

  The highmem block infrastructure, and pci dma additions.

- zone-dma32-5

  Adds the 32-bit dma capable memory zone and make highmem kmap both
  source and destination page.

- scsi-high-1

  Adds general highmem support to the SCSI layer and selected low level
  drivers.

- ide-high-1

  Adds general highmem support to the IDE layer and selected low level
  drivers.

- cpqarray-high-1

  Adds highmem support to the Compaq smart array driver

- cciss-high-1

  Adds highmem support to the 64-bit Compaq smart array driver

-- 
Jens Axboe


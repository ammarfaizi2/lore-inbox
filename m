Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUHNX2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUHNX2P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 19:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUHNX2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 19:28:15 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:8863 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266311AbUHNX2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 19:28:13 -0400
Subject: [BK PATCH] dma_declare_coherent_memory
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Aug 2004 19:28:02 -0400
Message-Id: <1092526084.1878.18.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been refined in mm for quite a while and now seems stable
enough for mainline.

I've added one extra bugfix over mm (Ian Molton spotted an error
calculating the index bits for the bitmaps).

The patch is available at:

bk://linux-voyager.bkbits.net/dma-declare-coherent-memory-2.6

The short changelog is:

Andrew Morton:
  o Fix sparc compile error in dma-mapping.h

James Bottomley:
  o lib/bitmap.c: fix incorrect use of BITS_TO_LONGS()
  o dma_alloc_coherent() still needs to support a NULL device
  o Fix region sizing problem in dma_mark_declared_memory_occupied()
  o Fix bug in __get_vm_area() alignment code
  o Fix incorrect prototype in the dma_declare_coherent_memory API
  o Convert NCR_Q720 to use dma_declare_coherent_memory
  o Add x86 implementation of dma_declare_coherent_memory
  o Add vmalloc alignment constraints
  o Add memory region bitmap implementations
  o Add dma_declare_coherent_memory() API

And the diffstat:

 Documentation/DMA-API.txt      |   79 +++++++++++++++++++++++++++++
 arch/i386/kernel/pci-dma.c     |  111 ++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/NCR_Q720.c        |   21 ++++++-
 include/asm-i386/dma-mapping.h |   12 ++++
 include/linux/bitmap.h         |    3 +
 include/linux/device.h         |    3 +
 include/linux/dma-mapping.h    |   29 ++++++++++
 lib/bitmap.c                   |   82 ++++++++++++++++++++++++++++++
 mm/vmalloc.c                   |   25 ++++++++-

James



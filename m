Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUGFXPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUGFXPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUGFXPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:15:14 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:25784 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264697AbUGFXOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:14:55 -0400
Subject: [BK PATCH] on-chip coherent memory API for DMA
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 06 Jul 2004 18:14:35 -0500
Message-Id: <1089155678.2854.796.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rollup of the previous patch I sent to the list for the
on-chip API.  It's available at

bk://linux-voyager.bkbits.net/dma-declare-coherent-memory-2.6

I split the patches I sent up into the five separate areas that they
affect:

ChangeSet@1.1783, 2004-06-30 21:44:24-05:00, jejb@mulgrave.(none)
  Convert NCR_Q720 to use dma_declare_coherent_memory
  
  This board makes an ideal example for using the API
  since it consists of 4 SCSI I/O processors and a 
  0.5-2MB block of memory on a single MCA card.
  
  Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

ChangeSet@1.1782, 2004-06-30 21:38:34-05:00, jejb@mulgrave.(none)
  Add x86 implementation of dma_declare_coherent_memory
  
  This actually implements the API (all except for
  DMA_MEMORY_INCLUDES_CHILDREN).
  
  Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

ChangeSet@1.1781, 2004-06-30 21:11:14-05:00, jejb@mulgrave.(none)
  Add vmalloc alignment constraints
  
  vmalloc is used by ioremap() to get regions for
  remapping I/O space.  To feed these regions back
  into a __get_free_pages() type memory allocator,
  they are expected to have more alignment than 
  get_vm_area() proves.  So add additional alignment
  constraints for VM_IOREMAP.
  
  Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

ChangeSet@1.1780, 2004-06-30 21:08:15-05:00, jejb@mulgrave.(none)
  Add memory region bitmap implementations
  
  These APIs deal with bitmaps representing contiguous
  memory regions.  The idea is to set, free and find
  a contiguous area.
  
  For ease of implementation (as well as to conform
  to the standard requirements), the bitmaps always
  return n aligned n length regions.  The implementation
  is also limited to BITS_PER_LONG contiguous regions.
  
  Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

ChangeSet@1.1779, 2004-06-30 21:02:11-05:00, jejb@mulgrave.(none)
  Add dma_declare_coherent_memory() API
  
  This adds the description and a null prototype.
  
  Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

And the diffstat is:

 Documentation/DMA-API.txt      |   79 +++++++++++++++++++++++++++++
 arch/i386/kernel/pci-dma.c     |  111 ++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/NCR_Q720.c        |   21 ++++++-
 include/asm-i386/dma-mapping.h |   12 ++++
 include/linux/bitmap.h         |    3 +
 include/linux/device.h         |    3 +
 include/linux/dma-mapping.h    |   26 +++++++++
 lib/bitmap.c                   |   76 ++++++++++++++++++++++++++++
 mm/vmalloc.c                   |   20 ++++++-
 9 files changed, 344 insertions(+), 7 deletions(-)

James



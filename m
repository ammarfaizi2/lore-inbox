Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269376AbRGaRhl>; Tue, 31 Jul 2001 13:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269377AbRGaRhb>; Tue, 31 Jul 2001 13:37:31 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:80
	"EHLO jet.il.steeleye.com") by vger.kernel.org with ESMTP
	id <S269376AbRGaRhX>; Tue, 31 Jul 2001 13:37:23 -0400
Message-Id: <200107311737.MAA01378@jet.il.steeleye.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: Question about using the kernel dma_cache_...() defines in asm/io.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2001 12:37:24 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I'm currently writing a SCSI device driver that can be used on multiple 
platforms, some of which don't preserve DMA cache coherency like the x86 does.

I know the basics of how to use the dma_cache_wback(), dma_cache_inv() and 
dma_cache_wback_inv() functions, however the question has come up about what I 
should do in the edge cases where the memory I want the device to write to 
shares a cache line with some other kernel data that I don't control.  Since 
some CPU chip architectures only support cache control bits per cache line 
rather than per byte, if I invalidate my range of data I could potentially 
cause the destruction of cached but unflushed data sharing the cache line.

I suspect that it is the intention of these cache coherency functions to 
operate without regard for neighbouring data, and that this could be enforced 
on architectures like the above by restricting the minimum kernel memory 
allocation alignment to be the cache line width.

Could the designer of these functions step forward and confirm how they are 
supposed to be used?

Thanks,

James Bottomley



Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317785AbSFMRmX>; Thu, 13 Jun 2002 13:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317787AbSFMRmW>; Thu, 13 Jun 2002 13:42:22 -0400
Received: from [209.237.59.50] ([209.237.59.50]:31888 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317785AbSFMRmU>; Thu, 13 Jun 2002 13:42:20 -0400
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4 use __dma_buffer in scsi.h
In-Reply-To: <200206130218.g5D2Hx302994@localhost.localdomain>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 13 Jun 2002 10:42:16 -0700
Message-ID: <52fzzr2hzb.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "James" == James Bottomley <James.Bottomley@steeleye.com> writes:

    James> This is actually unnecessary.  We've already had this
    James> discussion on the parisc mailing lists (over a year ago, I
    James> think).

Fair enough, the only reason I came up with this patch is that I
looked at all unaligned DMA done by USB, and
drivers/usb/storage/transport.c does DMA into sense_buffer.

    James> The SCSI subsystem is designed with this type of cache
    James> incoherency problem in mind.  The Scsi_Cmnd structure has
    James> an ownership model to forestall cache line bouncing.  The
    James> idea is that when you want to dma to/from components of a
    James> Scsi_Cmnd, you can only do it when the ownership is
    James> SCSI_OWNER_LOW_LEVEL, which guarantees that nothing in the
    James> mid layer will touch the command and trigger an incoherency
    James> (at least until it times out).  The low level driver is
    James> supposed to know about the cache incoherency problem, and
    James> so avoids touching the structure between cache line
    James> invalidation/writeback and DMA completion, thus, with a
    James> correctly implemented driver, there should be no
    James> possibility of DMA corruption.

Out of curiousity, how do you deal with someone writing to Scsi_Cmnd
_before_ the DMA and having that data lost when pci_map_single() with
PCI_DMA_FROMDEVICE invalidates the cache before writeback?

Best,
  Roland

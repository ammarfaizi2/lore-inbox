Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317793AbSFMRwq>; Thu, 13 Jun 2002 13:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317790AbSFMRwp>; Thu, 13 Jun 2002 13:52:45 -0400
Received: from host194.steeleye.com ([216.33.1.194]:42000 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317791AbSFMRwn>; Thu, 13 Jun 2002 13:52:43 -0400
Message-Id: <200206131752.g5DHqdm24049@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Roland Dreier <roland@topspin.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4 use __dma_buffer in scsi.h 
In-Reply-To: Message from Roland Dreier <roland@topspin.com> 
   of "13 Jun 2002 10:42:16 PDT." <52fzzr2hzb.fsf@topspin.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Jun 2002 13:52:39 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

roland@topspin.com said:
> Out of curiousity, how do you deal with someone writing to Scsi_Cmnd
> _before_ the DMA and having that data lost when pci_map_single() with
> PCI_DMA_FROMDEVICE invalidates the cache before writeback? 

The the pci_map_single with PCI_DMA_FROMDEVICE is supposed to do a writeback 
invalidate cycle on the cache when pci_sync_single is called (at least this is 
how it is implemented on parisc) so any writes up to the sync point are 
flushed to memory before the cache line is trashed.

James



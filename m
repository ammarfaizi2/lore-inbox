Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279759AbRJYLUQ>; Thu, 25 Oct 2001 07:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279761AbRJYLUH>; Thu, 25 Oct 2001 07:20:07 -0400
Received: from 120.ppp1-5.hob.worldonline.dk ([212.54.87.120]:50048 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S279759AbRJYLTu>; Thu, 25 Oct 2001 07:19:50 -0400
Date: Thu, 25 Oct 2001 13:11:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Christian Hammers <ch@westend.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG() in asm/pci.h:142 with 2.4.13
Message-ID: <20011025131107.C4795@suse.de>
In-Reply-To: <20011025120701.C6557@westend.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20011025120701.C6557@westend.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 25 2001, Christian Hammers wrote:
> Hello
> 
> My system crashed several times now with 2.4.11-pre6 and 2.4.13
> (pre6 because it was the first one I got that fixed some 2GB RAM memory
> allocation bug).
> 
> 2.4.13 was the easiest one to reproduce: when starting the tape backup
> to a HP DDS3/DAT Streamer (C1537A) via a Adaptec SCSI Controller 
> (Adaptec 7892A in /proc/pci) on a Gigabyte GA-6VTXD Dual Motherboard with
> two PIII and 2GB of RAM it crashed immediately with the error attached
> below. The machine was under "stresstest-simulation" load at this time.
> 
> The tape_backup.pl uses the "mt" and "cpio" commands to access /dev/nst0.
> 
> Maybe worth noting is, that the system crashed another time yesterday 
> after replacing the external SCSI RAID Chassis/Controller (not the
> disks in it) and just this moment with another message (see below).

Could you try this patch and see if it fixes the pci.h BUG at least?

-- 
Jens Axboe


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sg-page-1

--- drivers/scsi/scsi_merge.c~	Thu Oct 25 12:15:35 2001
+++ drivers/scsi/scsi_merge.c	Thu Oct 25 12:16:20 2001
@@ -943,6 +943,7 @@
 		}
 		count++;
 		sgpnt[count - 1].address = bh->b_data;
+		sgpnt[count - 1].page = NULL;
 		sgpnt[count - 1].length += bh->b_size;
 		if (!dma_host) {
 			SCpnt->request_bufflen += bh->b_size;

--qlTNgmc+xy1dBmNv--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264894AbUFRArJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUFRArJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbUFRArJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:47:09 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:35014 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264894AbUFRAqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:46:47 -0400
Date: Thu, 17 Jun 2004 20:40:54 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: <ebuddington@wesleyan.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SATA 3112 errors on 2.6.7
In-Reply-To: <20040617210751.GA28519@pool-141-154-165-127.wma.east.verizon.net>
Message-ID: <Pine.GSO.4.33.0406172012220.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Eric Buddington wrote:
>----------------------------
>ata1: DMA timeout, stat 0x1
>ATA: abnormal status 0x58 on port 0xCF819087
>scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 03 ca 47 00 00 00 00
>Current sda: sense key Medium Error
>Additional sense: Unrecovered read error - auto reallocate failed
>end_request: I/O error, dev sda, sector 248391
>ATA: abnormal status 0x58 on port 0xCF819087
>ATA: abnormal status 0x58 on port 0xCF819087
>ATA: abnormal status 0x58 on port 0xCF819087
>----------------------------

I'm seeing the same thing on a 3114. (And even uber flaky behavior on a
3ware 8506-4LP... rebuilds succeed, OS can pattern fill the array without
error, but a media scan/parity check fails within minutes.)  There's
likely nothing wrong with your drives.  Something about that driver and
the hardware aren't playing nice.

I have 4xST3160023AS's in RAID0 (mirroring what the BIOS does to those drives.
See other posts.)  I can zero the array @ 35MB/s via O_DIRECT writes without
any issues.  I can copy gigs of stuff into the array if the fs is mounted
O_SYNC.  Yet, without O_SYNC, bursts of writes eventually result in a DMA
timeout.  I tried setting SIL_QUIRK_MOD15WRITE for that drive model, but it
makes no difference.

--Ricky




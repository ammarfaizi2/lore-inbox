Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbTAWRmf>; Thu, 23 Jan 2003 12:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbTAWRmf>; Thu, 23 Jan 2003 12:42:35 -0500
Received: from ulima.unil.ch ([130.223.144.143]:63707 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S265480AbTAWRmd>;
	Thu, 23 Jan 2003 12:42:33 -0500
Date: Thu, 23 Jan 2003 18:51:39 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Jens Axboe <axboe@suse.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, cdwrite@other.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030123175139.GA9141@ulima.unil.ch>
References: <200301220823.h0M8NG2o022692@burner.fokus.gmd.de> <20030122083530.GA20780@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030122083530.GA20780@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 09:35:30AM +0100, Jens Axboe wrote:

> Sounds plausible. Patch attached. Anyone care to expand on _why_ these
> status bytes are shifted one bit?
> 
> ===== drivers/ide/ide-cd.c 1.35 vs edited =====
> --- 1.35/drivers/ide/ide-cd.c	Thu Nov 21 22:56:59 2002
> +++ edited/drivers/ide/ide-cd.c	Wed Jan 22 09:34:28 2003
> @@ -706,7 +706,7 @@
>  		 * scsi status byte
>  		 */
>  		if ((rq->flags & REQ_BLOCK_PC) && !rq->errors)
> -			rq->errors = CHECK_CONDITION;
> +			rq->errors = CHECK_CONDITION << 1;
>  
>  		/* Check for tray open. */
>  		if (sense_key == NOT_READY) {

Well, it's changed, but not solved the problem:

Cdrecord-ProDVD-Clone 2.0 (i586-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Unlocked features: ProDVD Clone 
Limited  features: speed 
This copy of cdrecord is licensed for: private/research/educational_non-commercial_use
TOC Type: 1 = CD-ROM
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
Driveropts: 'burnfree'
atapi: 1
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : 
Vendor_info    : 'SONY    '
Identifikation : 'DVD RW DRU-500A '
Revision       : '1.0f'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
Driver flags   : DVD SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96R RAW/R96R
Drive buf size : 8126464 = 7936 KB
FIFO size      : 67108864 = 65536 KB
Track 01: data  4001 MB        
Total size:     4001 MB = 2048512 sectors
Current Secsize: 2048
Blocks total: 2298496 Blocks current: 2298496 Blocks remaining: 249984
  0.24% done, estimate finish Thu Jan 23 18:47:41 2003
Starting to write CD/DVD at speed 1 in dummy TAO mode for single session.
Last chance to quit, starting dummy write in 9 seconds.  0.49% done, estimate finish Thu Jan 23 18:51:05 2003
   8 seconds.  0.73% done, estimate finish Thu Jan 23 18:52:13 2003
   7 seconds.  0.98% done, estimate finish Thu Jan 23 18:51:05 2003
   6 seconds.  1.22% done, estimate finish Thu Jan 23 18:51:46 2003
   5 seconds.  1.46% done, estimate finish Thu Jan 23 18:52:14 2003
   0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is ON.
Starting new track at sector: 0
Track 01:    4 of 4001 MB written (fifo  96%)  16.1x.cdrecord-prodvd: Success. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 08 B8 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes:
Sense Key: 0xFFFFFFFF [], Segment 0
Sense Code: 0x00 Qual 0x00 (no additional sense information) Fru 0x0
Sense flags: Blk 0 (not valid) 
resid: 63488
cmd finished after 0.007s timeout 100s

write track data: error after 4571136 bytes
Sense Bytes: 70 00 00 00 00 00 00 12 00 00 00 00 00 00 00 00 00 00
Writing  time:    5.334s
Average write speed 571.3x.
Fixating...
Fixating time:   77.465s
cdrecord-prodvd: fifo had 1095 puts and 73 gets.
cdrecord-prodvd: fifo was 0 times empty and 2 times full, min fill was 96%.

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbTAYOQf>; Sat, 25 Jan 2003 09:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbTAYOQf>; Sat, 25 Jan 2003 09:16:35 -0500
Received: from ulima.unil.ch ([130.223.144.143]:5349 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S266435AbTAYOQd>;
	Sat, 25 Jan 2003 09:16:33 -0500
Date: Sat, 25 Jan 2003 15:25:47 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Jens Axboe <axboe@suse.de>
Cc: "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030125142547.GB18989@ulima.unil.ch>
References: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de> <20030123180124.GB9141@ulima.unil.ch> <20030123180653.GU910@suse.de> <b0qvta$fo6$1@forge.intermeta.de> <20030124092616.GH910@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030124092616.GH910@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 10:26:16AM +0100, Jens Axboe wrote:

> The interesting part is whether failed has a sense attached, and if so
> what length.
> > 
> > >                cdrom_analyze_sense_data(drive, failed, sense);
> 
> To avoid confusion, I made the patch. Would have been easier to do in
> the first place it seems :)
> 
> ===== drivers/ide/ide-cd.c 1.35 vs edited =====
> --- 1.35/drivers/ide/ide-cd.c	Thu Nov 21 22:56:59 2002
> +++ edited/drivers/ide/ide-cd.c	Fri Jan 24 10:25:53 2003
> @@ -649,6 +649,8 @@
>  		struct cdrom_info *info = drive->driver_data;
>  		void *sense = &info->sense_data;
>  		
> +		if (failed && blk_pc_request(failed))
> +			printk("%s: failed, sense %p, len=%d\n", __FUNCTION__, failed->sense, failed->sense_len);
>  		if (failed && failed->sense)
>  			sense = failed->sense;

Hello,

sorry I didn't understood that I was supposed to do this...
I have recompiled with your patch, and here the result of dmesg:

cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0
cdrom_end_request: failed, sense ce68de20, len=0

Maybe I should add that, also under 2.4, it goes till 4 Mb and then stay
at 4 Mb for a long time (something like one minute) and then it
continues perfectly (with ide-scsi under 2.4).

And in case still needed:

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
Starting to write CD/DVD at speed 1 in dummy TAO mode for single session.
Last chance to quit, starting dummy write in 9 seconds.  0.24% done, estimate finish Sat Jan 25 15:26:58 2003
   8 seconds.  0.49% done, estimate finish Sat Jan 25 15:26:59 2003
   7 seconds.  0.73% done, estimate finish Sat Jan 25 15:26:59 2003
   6 seconds.  0.98% done, estimate finish Sat Jan 25 15:26:59 2003
   5 seconds.  1.22% done, estimate finish Sat Jan 25 15:26:59 2003
   4 seconds.  1.46% done, estimate finish Sat Jan 25 15:26:59 2003
   0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is ON.
Starting new track at sector: 0
Track 01:    4 of 4001 MB written (fifo  97%)  16.2x.cdrecord-prodvd: Success. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 08 B8 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes:
Sense Key: 0xFFFFFFFF [], Segment 0
Sense Code: 0x00 Qual 0x00 (no additional sense information) Fru 0x0
Sense flags: Blk 0 (not valid) 
resid: 63488
cmd finished after 0.001s timeout 100s

write track data: error after 4571136 bytes
Sense Bytes: 70 00 00 00 00 00 00 12 00 00 00 00 00 00 00 00 00 00
Writing  time:    5.294s
Average write speed 575.6x.
Fixating...
Fixating time:   77.019s
cdrecord-prodvd: fifo had 1095 puts and 73 gets.
cdrecord-prodvd: fifo was 0 times empty and 2 times full, min fill was 96%.
Exit 254

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277338AbRJJRr5>; Wed, 10 Oct 2001 13:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277339AbRJJRrj>; Wed, 10 Oct 2001 13:47:39 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:6295 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S277338AbRJJRr1>; Wed, 10 Oct 2001 13:47:27 -0400
Date: Wed, 10 Oct 2001 19:47:48 +0200
From: Cliff Albert <cliff@oisec.net>
To: Alexander Feigl <Alexander.Feigl@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: aic7xxx SCSI system hangs
Message-ID: <20011010194748.A7664@oisec.net>
Mail-Followup-To: Alexander Feigl <Alexander.Feigl@gmx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200110101403.f9AE3DY6006854@PowerBox.MysticWorld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110101403.f9AE3DY6006854@PowerBox.MysticWorld.de>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 04:03:12PM +0200, Alexander Feigl wrote:

> Full description : After doing cdrecord -toc with an audio CD (CDDA) on my 
> Plextor drive (PX 32TS), the [scsi_eh_0] proccess remains in uninterruptible 
> state. All proccesses which will use the SCSI subsystem (e.g. cdrecord, 
> mkisofs) will be in uninterruptible state too - which renders the SCSI system 
> unusable until the next reboot. The SCSI system crashes only with my CD-ROM 
> here. My Plextor PXW1210S does not hang. Reading the TOC with cdda2wav works 
> here. Somebody told me  something similar happens with Plextor PX40 and 
> cdda2wav. Others reported hangs and didn't tell me anything about  their SCSI 
> system. (I'm coding a cd recording UI frontend and received some bug 
> reports). The problems remain if I don't use my software but call the 
> commands from the shell. I think it is a kernel problem. Userspace bugs  
> (cdrecord,mkisofs?) should not hang the SCSI subsystem anyway.

This problem also seems to appear on 2.4.10-ac10 using the old AIC7xxx driver cdrecord spits out a bunch of errors, and after that the SCSI bus is just plain dead. The audio-cd itself can be played correctly on the PX-32TS using the front buttons.

> Kernel version : Linux version 2.4.11-pre5-xfs (root@PowerBox.MysticWorld.de) 
> (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release / Mandrake Linux 
> 8.1)) #1 Mon Okt 8 13:38:15 CEST 2001

Kernel version : Linux version 2.4.10-ac10 (root@neve) (gcc version 2.95.4 20011006 (Debian prerelease)) #6 Tue Oct 9 11:59:30 CEST 2001

> I also tried stable and non-XFS kernels and the problem remains
> 
> Shell command : cdrecord -toc dev=x,y,z (with a CDDA in the drive)
> 
> My environment : AMD Athlon 900 Mhz
>                  512 MB RAM
>                  2 IDE hard drives
>                  Plextor PX-32TS (the one which makes problems)  
>                  Plextor PX-W1210S
>                  Adaptec 2940U2W SCSI controller (both CD drives attached)
>                  nVidia Geforce 2 GFX (using XFree86 drivers)
>                  ALSA sound system (0.5.10) with a SB Live!

Enviroment here : Intel Celeron 266 (Overclocked to 400)
		  512 MB RAM
		  Adaptec 7890 (Onboard P2B-S)

--> /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL ST6.4S  Rev: 0F0C
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: VIKING II 9.1WLS Rev: 4110
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: YAMAHA   Model: CRW8424S         Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: J.03
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: YAMAHA   Model: CRW2100S         Rev: 1.0H
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
			

--> The error messages (kernel)
 Oct 10 19:38:48 neve kernel: scsi : aborting command due to timeout : pid 655363, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 00 cd 1f 00 00 18 00  
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) Aborting scb 5, flags 0x4, SEQADDR 0xa3, LASTPHASE 0x80 
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) SG_CACHEPTR 0x6, SG_COUNT 1, SCSISIGI 0x44 
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) SSTAT0 0x0, SSTAT1 0x3, SSTAT2 0x50 
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) SCB disconnected.  Queueing Abort SCB. 
 Oct 10 19:38:48 neve kernel: SCSI host 0 abort (pid 655363) timed out - resetting 
 Oct 10 19:38:48 neve kernel: SCSI bus is being reset for host 0 channel 0. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) Reset called, scb 5, flags 0x1094 
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) Have already attempted to reach device with queued 
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) message, will escalate to bus reset. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:-1:-1) Reset channel called, will initiate reset. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:-1:-1) Resetting currently active channel. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:-1:-1) Channel reset 
 Oct 10 19:38:48 neve kernel: (scsi0:0:-1:-1) Reset device, active_scb 14 
 Oct 10 19:38:48 neve kernel: (scsi0:0:-1:-1) Current scb_tag 16, SEQADDR 0xa3, LASTPHASE 0x80 
 Oct 10 19:38:48 neve kernel: (scsi0:0:-1:-1) SG_CACHEPTR 0x6, SG_COUNT 1, SCSISIGI 0x0 
 Oct 10 19:38:48 neve kernel: (scsi0:0:-1:-1) SSTAT0 0x0, SSTAT1 0x1, SSTAT2 0x40 
 Oct 10 19:38:48 neve kernel: (scsi0:0:0:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:2:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:3:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:4:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:5:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:6:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:8:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:9:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:10:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:11:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:12:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:13:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:14:-1) Cleaning up status information and delayed_scbs. 
 Oct 10 19:38:48 neve kernel: (scsi0:0:15:-1) Cleaning up status information and delayed_scbs.
 Oct 10 19:38:48 neve kernel: (scsi0:0:-1:-1) Cleaning QINFIFO.
 Oct 10 19:38:48 neve kernel: (scsi0:0:-1:-1) Cleaning waiting_scbs.
 Oct 10 19:38:48 neve kernel: (scsi0:0:-1:-1) Cleaning waiting for selection list.
 Oct 10 19:38:48 neve kernel: (scsi0:0:-1:-1) Cleaning disconnected scbs list.
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) Aborting scb 5
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) Aborting scb 8
 Oct 10 19:38:48 neve kernel: (scsi0:0:0:0) Aborting scb 12
 Oct 10 19:38:48 neve kernel: (scsi0:0:0:0) Aborting scb 15
 Oct 10 19:38:48 neve kernel: (scsi0:0:6:0) Aborting scb 16
 Oct 10 19:38:48 neve kernel: (scsi0:-1:-1:-1) 5 commands found and queued for completion.
 Oct 10 19:38:48 neve kernel: (scsi0:0:0:0) Sending SDTR 12/127 message.
 Oct 10 19:38:48 neve kernel: (scsi0:0:0:0) Synchronous at 20.0 Mbyte/sec, offset 15.
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) Sending WDTR message.
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) Using Wide(16bit) transfers
 Oct 10 19:38:48 neve kernel: (scsi0:0:6:0) Sending SDTR 12/127 message.
 Oct 10 19:38:48 neve kernel: (scsi0:0:6:0) Synchronous at 20.0 Mbyte/sec, offset 15.
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) Sending SDTR 10/127 message.
 Oct 10 19:38:48 neve kernel: (scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.

--> The errormessage (kernel) 2nd Attempt
Oct 10 19:39:39 neve kernel: scsi : aborting command due to timeout : pid 655571, scsi0, channel 0, id
 0, lun 0 Write (10) 00 00 1a 60 b2 00 00 18 00  
 Oct 10 19:39:39 neve kernel: (scsi0:0:0:0) Aborting scb 11, flags 0x4, SEQADDR 0xa4, LASTPHASE 0x80 
 Oct 10 19:39:39 neve kernel: (scsi0:0:0:0) SG_CACHEPTR 0x6, SG_COUNT 1, SCSISIGI 0x44 
 Oct 10 19:39:39 neve kernel: (scsi0:0:0:0) SSTAT0 0x0, SSTAT1 0x3, SSTAT2 0x50 
 Oct 10 19:39:39 neve kernel: (scsi0:0:0:0) SCB found in QINFIFO and aborted. 
 Oct 10 19:39:39 neve kernel: (scsi0:0:0:0) Aborting scb 11 
 Oct 10 19:39:39 neve kernel: (scsi0:-1:-1:-1) 1 commands found and queued for completion. 
 Oct 10 19:39:49 neve kernel: scsi : aborting command due to timeout : pid 655570, scsi0, channel 0, id
  6, lun 0 VENDOR SPECIFIC(0xe5) 00 00 00 00 01 00 00 0e 00  
  Oct 10 19:39:49 neve kernel: (scsi0:0:6:0) Aborting scb 4, flags 0x4, SEQADDR 0xa4, LASTPHASE 0x80 
  Oct 10 19:39:49 neve kernel: (scsi0:0:6:0) SG_CACHEPTR 0x6, SG_COUNT 1, SCSISIGI 0x44 
  Oct 10 19:39:49 neve kernel: (scsi0:0:6:0) SSTAT0 0x0, SSTAT1 0x3, SSTAT2 0x50 
  Oct 10 19:39:49 neve kernel: (scsi0:0:6:0) SCB is currently active.  Waiting on completion. 
  Oct 10 19:39:49 neve kernel: (scsi0:0:6:0) SCSISIGI 0x44, SEQADDR 0xa4, SSTAT0 0x0, SSTAT1 0x3 
  Oct 10 19:39:49 neve kernel: (scsi0:0:6:0) SG_CACHEPTR 0x6, SSTAT2 0x50, STCNT 0x8 
  Oct 10 19:39:54 neve kernel: SCSI host 0 abort (pid 655570) timed out - resetting 
  Oct 10 19:39:54 neve kernel: SCSI bus is being reset for host 0 channel 0. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:6:0) Reset called, scb 4, flags 0x84 
  Oct 10 19:39:54 neve kernel: (scsi0:0:6:0) Bus device reset stupid when other action has failed. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:-1:-1) Reset channel called, will initiate reset. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:-1:-1) Resetting currently active channel. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:-1:-1) Channel reset 
  Oct 10 19:39:54 neve kernel: (scsi0:0:-1:-1) Reset device, active_scb 4 
  Oct 10 19:39:54 neve kernel: (scsi0:0:-1:-1) Current scb_tag 4, SEQADDR 0xa4, LASTPHASE 0x80 
  Oct 10 19:39:54 neve kernel: (scsi0:0:-1:-1) SG_CACHEPTR 0x6, SG_COUNT 1, SCSISIGI 0x0 
  Oct 10 19:39:54 neve kernel: (scsi0:0:-1:-1) SSTAT0 0x0, SSTAT1 0x1, SSTAT2 0x40 
  Oct 10 19:39:54 neve kernel: (scsi0:0:0:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:1:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:2:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:3:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:4:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:5:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:6:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:8:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:9:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:10:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:11:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:12:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:13:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:14:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:15:-1) Cleaning up status information and delayed_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:-1:-1) Cleaning QINFIFO. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:-1:-1) Cleaning waiting_scbs. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:-1:-1) Cleaning waiting for selection list. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:-1:-1) Cleaning disconnected scbs list. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:6:0) Aborting scb 4 
  Oct 10 19:39:54 neve kernel: (scsi0:0:0:0) Aborting scb 11 
  Oct 10 19:39:54 neve kernel: (scsi0:-1:-1:-1) 2 commands found and queued for completion. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:0:0) Sending SDTR 12/127 message. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:0:0) Synchronous at 20.0 Mbyte/sec, offset 15. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:6:0) Sending SDTR 12/127 message. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:6:0) Synchronous at 20.0 Mbyte/sec, offset 15. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:1:0) Sending WDTR message. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:1:0) Using Wide(16bit) transfers 
  Oct 10 19:39:54 neve kernel: (scsi0:0:1:0) Sending SDTR 10/127 message. 
  Oct 10 19:39:54 neve kernel: (scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31. 
  

--> The errormessages (cdrecord)
scsidev: '0,6,0'
scsibus: 0 target: 6 lun: 0
Linux sg driver version: 3.1.20
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 02 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 03 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 04 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 05 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 06 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 07 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 08 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 09 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 0A 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 0B 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 0C 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 0D 00 0C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord: Cannot read TOC
cdrecord: Input/output error. read toc: scsi sendcmd: no error
CDB:  43 00 00 00 00 00 0E 00 0C 00
status: 0x2 (CHECK CONDITION)

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740

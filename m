Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbTBPOHr>; Sun, 16 Feb 2003 09:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbTBPOHr>; Sun, 16 Feb 2003 09:07:47 -0500
Received: from node-c-58b2.a2000.nl ([62.194.88.178]:6016 "EHLO
	wsprwl.xs4all.nl") by vger.kernel.org with ESMTP id <S266876AbTBPOHq>;
	Sun, 16 Feb 2003 09:07:46 -0500
Message-ID: <3E4F9D80.2000206@xs4all.nl>
Date: Sun, 16 Feb 2003 15:17:36 +0100
From: Ruud Linders <rkmp@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SCSI Tape hangs when no tape loaded (2.5.6x)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On both 2.5.60 and 2.5.61 when there is no tape loaded in my SCSI DAT
tape drive, access to the drive blocks for exactly 2 minutes
before timing out and giving an I/O error.

# mt stat
....... < 2 minutes later > ...
/dev/tape: Input/output error

< me putting a tape in the unit>

# mt stat
SCSI 2 tape drive:
File number=0, block number=0, partition=0.
Tape block size 0 bytes. Density code 0x25 (DDS-3).
Soft error count since last status=0
General status bits on (45010000):
  BOT WR_PROT ONLINE IM_REP_EN

I don't remember seeing this on earlier 2.5.5[0-3] or so kernels,
looks like a bug in the SCSI layer.

Output from dmesg (2.5.61):

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
         <Adaptec 2940A Ultra SCSI adapter>
         aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

   Vendor: HP        Model: C1537A            Rev: L105
   Type:   Sequential-Access                  ANSI SCSI revision: 02
   Vendor: PLEXTOR   Model: CD-ROM PX-20TS    Rev: 1.02
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R08
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: YAMAHA    Model: CRW8424S          Rev: 1.0j
   Type:   CD-ROM                             ANSI SCSI revision: 02
st: Version 20020805, bufsize 32768, wrt 30720, max init. bufs 4, s/g 
segs 16
Attached scsi tape st0 at scsi0, channel 0, id 2, lun 0
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 6, lun 0
(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
(scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 15)
sr1: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
(scsi0:A:6): 20.000MB/s transfers (20.000MHz, offset 15)
sr2: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray

--
Ruud Linders


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273351AbRINJgb>; Fri, 14 Sep 2001 05:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273352AbRINJgV>; Fri, 14 Sep 2001 05:36:21 -0400
Received: from dwdmx2.dwd.de ([141.38.2.10]:14340 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S273351AbRINJgF>;
	Fri, 14 Sep 2001 05:36:05 -0400
Date: Fri, 14 Sep 2001 11:34:46 +0200 (CEST)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: <linux-kernel@vger.kernel.org>
Subject: AIC7xxx errors in 2.2.19 but not in 2.2.18
Message-Id: <Pine.LNX.4.30.0109141121010.27057-100000@talentix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am getting SCSI errors with an onboard Adaptec AIC-7890/1 Ultra2, but
only under very heavy disk load and only under kernel 2.2.19. These errors
do not appear under 2.2.18.

The system I have is a dual PIII-450 with 6 disks attached to the controller.
All disks are put together in SW-Raid5 array with one configured as hot
spare.

The errors under 2.2.19 look as follows:

 scsi : aborting command due to timeout : pid 52414, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 ba f3 76 00 00 18 00
 scsi : aborting command due to timeout : pid 52416, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 ba f4 0e 00 00 80 00
 (scsi0:0:1:0) SCSISIGI 0x4, SEQADDR 0x77, SSTAT0 0x0, SSTAT1 0x2
 (scsi0:0:1:0) SG_CACHEPTR 0x8, SSTAT2 0x40, STCNT 0x5fc
 scsi : aborting command due to timeout : pid 52417, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 ba f4 8e 00 00 80 00
 scsi : aborting command due to timeout : pid 52419, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 ba f4 0e 00 00 80 00
 scsi : aborting command due to timeout : pid 52420, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 ba f4 8e 00 00 80 00
 scsi : aborting command due to timeout : pid 52422, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 ba f4 0e 00 00 80 00
 scsi : aborting command due to timeout : pid 52423, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 ba f4 8e 00 00 80 00
 scsi : aborting command due to timeout : pid 52425, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 1c ed 06 00 00 08 00
 scsi : aborting command due to timeout : pid 52426, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 ba f3 8e 00 00 80 00
 scsi : aborting command due to timeout : pid 52427, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 ba f3 8e 00 00 80 00
 scsi : aborting command due to timeout : pid 52428, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 ba f5 0e 00 00 80 00
 scsi : aborting command due to timeout : pid 52429, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 ba f5 0e 00 00 80 00
 scsi : aborting command due to timeout : pid 52430, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 ba f5 0e 00 00 80 00
 scsi : aborting command due to timeout : pid 52431, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 ba f4 0e 00 00 80 00
 scsi : aborting command due to timeout : pid 52432, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 ba f4 0e 00 00 80 00
 SCSI host 0 abort (pid 52416) timed out - resetting
 SCSI bus is being reset for host 0 channel 0.

 wait_on_bh, CPU 1:
 irq:  0 [0 0]
 bh:   1 [1 0]
 <[c010aead]> <[c0199ffc]> <[c019ab9b]> <[c01a3860]> <6>(scsi0:0:4:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:2:0) Synchronous at 80.0 Mbyte/sec, offset 63.
 (scsi0:0:3:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 scsi : aborting command due to timeout : pid 53513, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 bb 4c f6 00 00 80 00
 (scsi0:0:1:0) SCSISIGI 0x4, SEQADDR 0x62, SSTAT0 0x0, SSTAT1 0x2
 (scsi0:0:1:0) SG_CACHEPTR 0x3c, SSTAT2 0x40, STCNT 0x3fc
 scsi : aborting command due to timeout : pid 53514, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 bb 4a f6 00 00 80 00
 scsi : aborting command due to timeout : pid 53515, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 bb 4c f6 00 00 80 00
 scsi : aborting command due to timeout : pid 53516, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 bb 4a f6 00 00 80 00
 scsi : aborting command due to timeout : pid 53517, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 bb 4d 76 00 00 40 00
 scsi : aborting command due to timeout : pid 53518, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 bb 4d 76 00 00 40 00
 scsi : aborting command due to timeout : pid 53519, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 bb 4d 76 00 00 40 00
 scsi : aborting command due to timeout : pid 53520, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 ba fb 86 00 00 08 00
 scsi : aborting command due to timeout : pid 53521, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 ba fb 86 00 00 08 00
 scsi : aborting command due to timeout : pid 53522, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 bb 4d be 00 00 30 00
 scsi : aborting command due to timeout : pid 53523, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 bb 4d be 00 00 30 00
 scsi : aborting command due to timeout : pid 53524, scsi0, channel 0, id 3, lun 0 Write (10) 00 00 bb 4d be 00 00 30 00
 scsi : aborting command due to timeout : pid 53525, scsi0, channel 0, id 4, lun 0 Write (10) 00 00 bb 4b 76 00 00 80 00
 scsi : aborting command due to timeout : pid 53526, scsi0, channel 0, id 2, lun 0 Write (10) 00 00 bb 4b 76 00 00 80 00
 scsi : aborting command due to timeout : pid 53527, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 bb 4b f6 00 00 80 00
 SCSI host 0 abort (pid 53513) timed out - resetting
 SCSI bus is being reset for host 0 channel 0.
 (scsi0:0:4:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:3:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:2:0) Synchronous at 80.0 Mbyte/sec, offset 63.
 (scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
 (scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.

>From Alan's changelog I see that there where changes in the AIC7xxx code.
Any idea what is wrong here?

Thanks,
Holger


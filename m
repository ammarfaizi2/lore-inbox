Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272197AbRJBLoL>; Tue, 2 Oct 2001 07:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272158AbRJBLoB>; Tue, 2 Oct 2001 07:44:01 -0400
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:16519 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S272197AbRJBLnp>; Tue, 2 Oct 2001 07:43:45 -0400
Date: Tue, 2 Oct 2001 13:44:06 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: <linux-kernel@vger.kernel.org>
Subject: aic7xxx error
Message-ID: <Pine.LNX.4.31.0110021307130.2265-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

There always have been problems with the SCSI subsystem of my server (dual
PIII 450) since I upgraded to 2.4. Exchanging the disk didn't help. I get
errors from SCSI about once a week, last time the disks were unaccessable
(sysrq-sync/umount printed on the console, but didn't touch the disks).
This time I was lucky enough to capture the error message, but I am not
skilled enough to decode its meaning:

scsi1:A:2: no active SCB for reconnecting target - issuing BUS DEVICE
RESET
SAVED_SCSIID == 0x27, SAVED_LUN == 0x4, ARG_1 == 0x20 ACCUM = 0x0
SEQ_FLAGS == 0x0, SCBPTR == 0x1, BTT == 0xff, SINDEX == 0x31
SCSIID == 0x0, SCB_SCSIID == 0x0, SCB_LUN == 0x0, SCB_TAG == 0xff,
SCB_CONTROL == 0x0
SCSIBUSL == 0x20, SCSISIGI == 0xe6
SXFRCTL0 == 0x88
SEQCTL == 0x10
scsi1: Dumping Card State in Message-in phase, at SEQADDR 0x1a6
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0xe0, SCSISIGI = 0xe6, SXFRCTL0 = 0x88
SSTAT0 = 0x2, SSTAT1 = 0x3
STACK == 0x17b, 0x165, 0x0, 0x13f
SCB count = 20
Kernel NEXTQSCB = 6
Card NEXTQSCB = 6
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries: 9:1 11:15 6:9 4:7 2:19 7:0 13:8 3:14 12:11
15:13
QOUTFIFO entries:
Sequencer Free SCB List: 1 14 10 0 8 5 16 17 18 19 20 21 22 23 24 25 26 27
28 29 30 31
Pending list: 1 15 9 7 19 0 8 14 11 13
Kernel Free SCB list: 2 10 4 3 12 5 18 17 16
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
scsi1: Bus Device Reset on A:2. 8 SCBs aborted
SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
 I/O error: dev 08:61, sector 10181264
SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
 I/O error: dev 08:61, sector 10181016
SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
 I/O error: dev 08:61, sector 10180768
SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
 I/O error: dev 08:61, sector 10180520
SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
 I/O error: dev 08:61, sector 10180272
SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
 I/O error: dev 08:61, sector 10180024
SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
 I/O error: dev 08:61, sector 10179776

The upper layer (scp to a reiserfs partition) apparently didn't see an
error, but this I don't know for sure. Here's the output of
/proc/scsi/aic7xxx/1:

=================================================================
Adaptec AIC7xxx driver version: 6.1.13
aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
Channel A Target 0 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
        Goal: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
        Curr: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 1842691
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
        Goal: 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
        Curr: 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 2184
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 2 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
        Goal: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
        Curr: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
        Channel A Target 2 Lun 0 Settings
                Commands Queued 272085
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
===============================================================

The other IDs are unused.

Now my question? What actually did happen to cause this error? Is it
hardware-related? _May_ it be caused by faulty RAM? Could this go away by
switching to aic7xxx_old or another version of aic7xxx?

Kernel is 2.4.6 vanilla, compiled with gcc3.0.1.

Thanks for your answers,
					Roland

+-----------------------------------------------------+
|    Tel.:    089/32649332        0561/873744         |
|    in       Radeberger Weg 8    Am Fasanenhof 16    |
|             85748 Garching      34125 Kassel        |
+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+
|             May the Source be with you!             |
+-----------------------------------------------------+


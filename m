Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbTALPXF>; Sun, 12 Jan 2003 10:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267138AbTALPXF>; Sun, 12 Jan 2003 10:23:05 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:32395 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267125AbTALPXD>; Sun, 12 Jan 2003 10:23:03 -0500
Message-ID: <3E218A71.5080602@quark.didntduck.org>
Date: Sun, 12 Jan 2003 10:32:01 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
CC: gibbs@scsiguy.com
Subject: 2.5.56 aic7xxx boot failure
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new aic7xxx driver hangs on boot with the following messages.  Once 
the card is hung, only a cold boot will restore it to a sane state 
(causes problems in older kernels too).

Boot log:
---------
PCI: Found IRQ 10 for device 00:0b.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.26
         <Adaptec aic7850 SCSI adapter>
         aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

(scsi0:A:1:0): refuses WIDE negotiation.  Using 8bit transfers
scsi0:0:1:0: Attempting to queue an ABORT message
scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x7b
ACCUM = 0xfc, SINDEX = 0xb8, DINDEX = 0xa8, ARG_2 = 0x0
HCNT = 0x20 SCBPTR = 0x0
ERROR[0x0] SCSIPHASE[0x0] SCSIBUSL[0x20] LASTPHASE[0x40]:(IOI)
SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) SBLKCTL[0x0] SEQCTL[0x10]:(FASTMODE)
SEQ_FLAGS[0x20]:(DPHASE) SSTAT0[0x0] SSTAT1[0x3]:(REQINIT|PHASECHG)
SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] 
SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO)
SXFRCTL0[0x80]:(DFON) DFCNTRL[0x78]:(HDMAEN|SDMAEN|SCSIEN|WIDEODD)
DFSTATUS[0x0]
STACK: 0x0 0x0 0x1b4 0x6e
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 1 2
Sequencer SCB Info:
   0 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x17] SCB_LUN[0x0]
SCB_TAG[0x3]
   1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]
   2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]
Pending list:
   3 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x17] SCB_LUN[0x0]
Kernel Free SCB list: 1 0
Untagged Q(1): 3
DevQ(0:1:0): 0 waiting
scsi0:0:1:0: Device is active, asserting ATN
Recovery code sleeping

Good Boot log:
--------------
PCI: Found IRQ 10 for device 00:0b.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
         <Adaptec aic7850 SCSI adapter>
         aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

(scsi0:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
   Vendor: TOSHIBA   Model: CD-ROM XM-6201TA  Rev: 1030
   Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
   Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0c
   Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4:0): refuses synchronous negotiation. Using asynchronous transfers
   Vendor: IOMEGA    Model: ZIP 100           Rev: E.11
   Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 4, lun 0
sda : MODE SENSE failed.
sda : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Illegal Request
Additional sense: Invalid field in cdb
sda : assuming drive cache: write through
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 3, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray

lscpi output:
-------------
00:0b.0 SCSI storage controller: Adaptec AHA-7850 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 9800 [disabled] [size=256]
	Region 1: Memory at d5800000 (32-bit, non-prefetchable) [size=4K]



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbTDUCML (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 22:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263757AbTDUCML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 22:12:11 -0400
Received: from franka.aracnet.com ([216.99.193.44]:28310 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263756AbTDUCMG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 22:12:06 -0400
Date: Sun, 20 Apr 2003 19:23:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 608] New: smp machine with 2 scsi cdroms gets scsi aborts
Message-ID: <8250000.1050891835@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=608

           Summary: smp machine with 2 scsi cdroms gets scsi aborts
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: wescott_mike@emc.com


Distribution:
Hardware Environment:4-way 200MHz Pentium Pro
Software Environment:RH7.3 w/ linux-2.5.67
Problem Description:problems reading two SCSI cdroms at same time
running SMP. Problem does not occur in UniProcessor mode or if only
one CDROM is read.

Steps to reproduce:
On an SMP system with 2 cdroms try 
   dd if=/dev/cdrom bs=2k of=/dev/null
   dd if=/dev/cdrom1 bs=2k of=/dev/null
simultaneously. After a while one will hang and the console reports
errors. The problem also occurs reading from the filesystems.

System seems to work fine in UP-mode or accessing one at a time.
Problem also exists in 2.4.18 kernels.

Both devices are on the same bus:
scsi1:A:5 Vendor: TOSHIBA   Model: CD-ROM XM-5401TA  Rev: 3605
scsi1:A:6 Vendor: TOSHIBA   Model: CD-ROM XM-4101TA  Rev: 1084

> From the messages file:
18:35:42 ahc_pci:1:11:0: Using left over BIOS settings
18:35:42 ahc_pci:1:12:0: Using left over BIOS settings
18:35:42 scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
18:35:43         <Adaptec aic7880 Ultra SCSI adapter> 
18:35:43         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
[...]
18:35:44 (scsi1:A:3): 4.098MB/s transfers (4.098MHz, offset 14)
18:35:44   Vendor: WANGTEK   Model: 5525ES SCSI       Rev: 73Y1
18:35:44   Type:   Sequential-Access                  ANSI SCSI revision: 02
18:35:44 (scsi1:A:4): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
18:35:44   Vendor: SEAGATE   Model: ST19101W          Rev: 0014
18:35:44   Type:   Direct-Access                      ANSI SCSI revision: 02
18:35:44 scsi1:A:4:0: Tagged Queuing enabled.  Depth 253
18:35:44 (scsi1:A:5): 4.032MB/s transfers (4.032MHz, offset 15)
18:35:44   Vendor: TOSHIBA   Model: CD-ROM XM-5401TA  Rev: 3605
18:35:44   Type:   CD-ROM                             ANSI SCSI revision: 02
18:35:44 (scsi1:A:6): 4.032MB/s transfers (4.032MHz, offset 15)
18:35:44   Vendor: TOSHIBA   Model: CD-ROM XM-4101TA  Rev: 1084
18:35:44   Type:   CD-ROM                             ANSI SCSI revision: 02
[...]
18:35:45 sr0: scsi-1 drive
18:35:45 Uniform CD-ROM driver Revision: 3.12 
18:35:45 sr1: scsi-1 drive
[...]
18:40:44 scsi1:0:6:0: Attempting to queue an ABORT message
18:40:44 >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
18:40:44 scsi1: Dumping Card State in Data-in phase, at SEQADDR 0x7d
18:40:44 Card was paused 
18:40:44 ACCUM = 0x0, SINDEX = 0x8, DINDEX = 0x8f, ARG_2 = 0x0
18:40:44 HCNT = 0x0 SCBPTR = 0x1
18:40:44 SCSISIGI[0x44]:(BSYI|IOI) ERROR[0x0] SCSIBUSL[0xc0]
18:40:44 LASTPHASE[0x40]:(IOI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI)
18:40:44 SBLKCTL[0x2]:(SELWIDE) SCSIRATE[0x6f]:(ENABLE_CRC|SXFR_ULTRA2)
18:40:44 SEQCTL[0x10]:(FASTMODE) SEQ_FLAGS[0x20]:(DPHASE) SSTAT0[0x0]
18:40:44 SSTAT1[0x2]:(PHASECHG) SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0]
18:40:44 SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO)
18:40:44 SXFRCTL0[0x80]:(DFON) DFCNTRL[0x78]:(HDMAEN|SDMAEN|SCSIEN|WIDEODD)
18:40:44 DFSTATUS[0x25]:(FIFOEMP|DFTHRESH|FIFOQWDEMP)
18:40:44 STACK: 0x0 0x16c 0x19c 0x99 
18:40:44 SCB count = 4
18:40:44 Kernel NEXTQSCB = 2
18:40:44 Card NEXTQSCB = 2
18:40:44 QINFIFO entries: 
18:40:44 Waiting Queue entries: 
18:40:44 Disconnected Queue entries: 0:3 
18:40:44 QOUTFIFO entries: 
18:40:44 Sequencer Free SCB List: 2 3 4 5 6 7 8 9 10 11 12 13 14 15
18:40:44 Sequencer SCB Info: 
18:40:44   0 SCB_CONTROL[0x44]:(DISCONNECTED|DISCENB) SCB_SCSIID[0x57] 
18:40:44 SCB_LUN[0x0] SCB_TAG[0x3] 
18:40:44   1 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0]
18:40:44 SCB_TAG[0x1] 
18:40:44   2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:44 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:44   3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:44 SCB_LUN[0xff]:(LID) SCB_TAG[0xff]

18:40:45   4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:45   5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:45   6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:45   7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:45   8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:45   9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:45  10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:45  11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:45  12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:45  13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:45  14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:45  15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:45 SCB_LUN[0xff]:(LID) SCB_TAG[0xff]
18:40:45 Pending list: 
18:40:45   3 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x57] SCB_LUN[0x0]
18:40:45   1 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0]
18:40:45 Kernel Free SCB list: 0
18:40:45 Untagged Q(5): 3
18:40:45 Untagged Q(6): 1 
18:40:45 DevQ(0:3:0): 0 waiting
18:40:45 DevQ(0:4:0): 0 waiting
18:40:45 DevQ(0:5:0): 0 waiting
18:40:45 DevQ(0:6:0): 0 waiting
18:40:45 
18:40:45 <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
18:40:45 scsi1:0:6:0: Device is active, asserting ATN
18:40:45 Recovery code sleeping
18:40:49 Recovery code awake
18:40:49 Timer Expired 
18:40:49 aic7xxx_abort returns 0x2003
18:40:49 scsi1:0:5:0: Attempting to queue an ABORT message
18:40:49 >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
18:40:49 scsi1: Dumping Card State in Data-in phase, at SEQADDR 0x7c
18:40:49 Card was paused
18:40:49 ACCUM = 0x0, SINDEX = 0x8, DINDEX = 0x8f, ARG_2 = 0x0
18:40:49 HCNT = 0x0 SCBPTR = 0x1
18:40:49 SCSISIGI[0x54]:(BSYI|ATNI|IOI) ERROR[0x0] SCSIBUSL[0xc0]
18:40:49 LASTPHASE[0x40]:(IOI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
18:40:49 SBLKCTL[0x2]:(SELWIDE) SCSIRATE[0x6f]:(ENABLE_CRC|SXFR_ULTRA2)
18:40:49 SEQCTL[0x10]:(FASTMODE) SEQ_FLAGS[0x20]:(DPHASE) SSTAT0[0x0]
18:40:49 SSTAT1[0x2]:(PHASECHG) SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0]
18:40:49 SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
18:40:49 SXFRCTL0[0x80]:(DFON) DFCNTRL[0x78]:(HDMAEN|SDMAEN|SCSIEN|WIDEODD)
18:40:49 DFSTATUS[0x25]:(FIFOEMP|DFTHRESH|FIFOQWDEMP)
18:40:49 STACK: 0x0 0x16c 0x19c 0x99
18:40:49 SCB count = 4
18:40:49 Kernel NEXTQSCB = 2
18:40:49 Card NEXTQSCB = 2
18:40:49 QINFIFO entries: 
18:40:49 Waiting Queue entries: 
18:40:49 Disconnected Queue entries: 0:3
18:40:49 QOUTFIFO entries:  
18:40:49 Sequencer Free SCB List: 2 3 4 5 6 7 8 9 10 11 12 13 14 15
18:40:49 Sequencer SCB Info: 
18:40:49   0 SCB_CONTROL[0x44]:(DISCONNECTED|DISCENB) SCB_SCSIID[0x57]
18:40:49 SCB_LUN[0x0] SCB_TAG[0x3] 
18:40:49   1 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0]
18:40:49 SCB_TAG[0x1] 
18:40:50   2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50   3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50   4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50   5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50   6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50   7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50   8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50   9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50  10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50  11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50  12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50  13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50  14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
18:40:50  15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
18:40:50 SCB_LUN[0xff]:(LID) SCB_TAG[0xff]
18:40:50 Pending list: 
18:40:50   3 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x57] SCB_LUN[0x0]
18:40:50   1 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0]
18:40:50 Kernel Free SCB list: 0
18:40:50 Untagged Q(5): 3
18:40:50 Untagged Q(6): 1
18:40:50 DevQ(0:3:0): 0 waiting
18:40:50 DevQ(0:4:0): 0 waiting
18:40:50 DevQ(0:5:0): 0 waiting
18:40:50 DevQ(0:6:0): 0 waiting
18:40:50
18:40:50 <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
18:40:50 (scsi1:A:5:0): Device is disconnected, re-queuing SCB
18:40:50 Recovery code sleeping
18:40:54 Recovery code awake
18:40:54 Timer Expired
18:40:54 aic7xxx_abort returns 0x2003
18:40:54 scsi1:0:5:0: Attempting to queue a TARGET RESET message
18:40:54 aic7xxx_dev_reset returns 0x2003
18:40:54 scsi1:0:6:0: Attempting to queue a TARGET RESET message
18:40:54 aic7xxx_dev_reset returns 0x2003
18:40:54 Recovery SCB completes
18:40:54 Recovery SCB completes
18:41:04 scsi: Device offlined - not ready after error recovery: host 1 channel
0 id 6 lun 0
18:41:04 scsi: Device offlined - not ready after error recovery: host 1 channel
0 id 5 lun 0



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbTEaQqm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 12:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTEaQqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 12:46:42 -0400
Received: from chello062179076241.chello.pl ([62.179.76.241]:24731 "EHLO
	witch.nbox.pl") by vger.kernel.org with ESMTP id S264370AbTEaQqd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 12:46:33 -0400
Date: Sat, 31 May 2003 18:59:45 +0200
From: Daniel Podlejski <underley@underley.eu.org>
To: linux-kernel@vger.kernel.org
Subject: AIC7xxx problem
Message-ID: <20030531165945.GA5561@witch.underley.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG: 1024D/21220D85 1261 0C43 E614 C0D8 D463 EF9B F1EA F4B4 2122 0D85
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Adaptec SCSI controler, which with 2.4.20-ac2 boots ok:

====================================================================
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=15, 32/253 SCBs

(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: IBM       Model: DPSS-318350N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 16
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
====================================================================

but performance is poor - periodically all disk operations
stops for few seconds. I try to use newer drivers, but without
positiver results. Here is log from boot with verbose option:

====================================================================
[...]
SCSI subsystem driver Revision: 1.00
ahc_pci:2:10:0: Reading SEEPROM...done.
ahc_pci:2:10:0: Manual LVD Termination
ahc_pci:2:10:0: BIOS eeprom is present
ahc_pci:2:10:0: Secondary High byte termination Enabled
ahc_pci:2:10:0: Secondary Low byte termination Enabled
ahc_pci:2:10:0: Primary Low Byte termination Enabled
ahc_pci:2:10:0: Primary High Byte termination Enabled
ahc_pci:2:10:0: Downloading Sequencer Program... 423 instructions downloaded
ahc_pci:2:10:0: Features 0x56f6, Bugs 0x6, Flags 0x20485500
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=15, 32/253 SCBs

(scsi0:A:0): 980KB/s transfers (0.980MHz, offset 255)
scsi0: target 0 using 8bit transfers
(scsi0:A:0): 3.300MB/s transfers
scsi0: target 0 using asynchronous transfers
(scsi0:A:1): 980KB/s transfers (0.980MHz, offset 255)
scsi0: target 1 using 8bit transfers
(scsi0:A:1): 3.300MB/s transfers
scsi0: target 1 using asynchronous transfers

[...]

(scsi0:A:14): 980KB/s transfers (0.980MHz, offset 255)
scsi0: target 14 using 8bit transfers
(scsi0:A:14): 3.300MB/s transfers
scsi0: target 14 using asynchronous transfers
scsi0: target 15 using 8bit transfers
scsi0: target 15 using asynchronous transfers
scsi0: target 0 using 8bit transfers
scsi0: target 0 using asynchronous transfers
scsi0: target 1 using 8bit transfers
scsi0: target 1 using asynchronous transfers

[...]

scsi0: target 12 using 8bit transfers
scsi0: target 12 using asynchronous transfers
scsi0: target 13 using 8bit transfers
scsi0: target 13 using asynchronous transfers
scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x12 0x0 0x0 0x0 0xff 0x0
ahc_intr: HOST_MSG_LOOP bad phase 0x0
scsi0: At time of recovery, card was paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State while idle, at SEQADDR 0x45
Card was paused
ACCUM = 0xa0, SINDEX = 0x61, DINDEX = 0xe4, ARG_2 = 0x1
HCNT = 0x0 SCBPTR = 0x0
SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x1]:(P_BUSFREE) 
SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) SBLKCTL[0xa]:(SELWIDE|SELBUSB) 
SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) SEQ_FLAGS[0x40]:(NO_CDB_SENT) 
SSTAT0[0x0] SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8]:(ENSWRAP) 
SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) SXFRCTL0[0x88]:(SPIOEN|DFON) 
DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL) 
STACK: 0x3 0xe3 0x0 0x0
SCB count = 5
Kernel NEXTQSCB = 3
Card NEXTQSCB = 4
QINFIFO entries: 4 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 3 Sequencer SCB Info: 
  0 SCB_CONTROL[0x50]:(MK_MESSAGE|DISCENB) SCB_SCSIID[0xf]:(OID) 
SCB_LUN[0x0] SCB_TAG[0xff] 
  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 16 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 17 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 18 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 19 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 20 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 21 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 22 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 23 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 24 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 25 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 26 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 27 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 28 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 29 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 30 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 31 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Pending list: 
  4 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0xf]:(OID) SCB_LUN[0x0] 
Kernel Free SCB list: 2 1 0 
Untagged Q(0): 4 
DevQ(0:0:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi0: target 14 using 8bit transfers
scsi0: target 14 using asynchronous transfers
====================================================================

Any ideas to fix ?

-- 
Daniel Podlejski <underley@underley.eu.org>
   ... 'Cause yesterday's got nothin' for me
   Old pictures that I'll always see ...

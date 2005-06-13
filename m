Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVFNARr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVFNARr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 20:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVFMVqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:46:17 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:165 "EHLO janus.localdomain")
	by vger.kernel.org with ESMTP id S261435AbVFMVmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:42:14 -0400
Date: Mon, 13 Jun 2005 23:42:09 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Gr?goire Favre <gregoire.favre@gmail.com>, dino@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050613214208.GA7471@janus>
References: <20050530160147.GD14351@gmail.com> <1117477040.4913.12.camel@mulgrave> <20050530190716.GA9239@gmail.com> <1118081857.5045.49.camel@mulgrave> <20050607085710.GB9230@gmail.com> <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com> <1118674783.5079.9.camel@mulgrave> <20050613183719.GA8653@gmail.com> <1118695847.5079.41.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118695847.5079.41.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.12-rc6 seems to hang in the aic7xxx driver here, pausing a few seconds
dumping state, pausing a few seconds dumping state again. I started
to take pictures of the screen but suddenly it got out of the loop and
here's the log. I'll try the patch to see if it fixes anything. First
some output of /proc:

$ cat /proc/scsi/aic7xxx/0 
Adaptec AIC7xxx driver version: 6.2.36
Adaptec aic7890/91 Ultra2 SCSI adapter
aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
Allocated SCBs: 4, SG List Length: 128

Serial EEPROM:
0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3b3 0xc3bb 0xc3bb 0xc3bb 
0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 
0x18a2 0x1c5e 0x2807 0x0010 0xffff 0xffff 0xffff 0xffff 
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x98b4 

Target 0 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 1 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 2 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 3 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
        Goal: 10.000MB/s transfers (10.000MHz, offset 15)
        Curr: 10.000MB/s transfers (10.000MHz, offset 15)
        Channel A Target 3 Lun 0 Settings
                Commands Queued 17
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Target 4 Negotiation Settings
        User: 6.600MB/s transfers (16bit)
        Goal: 3.300MB/s transfers
        Curr: 3.300MB/s transfers
        Channel A Target 4 Lun 0 Settings
                Commands Queued 61
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Target 5 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 6 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 7 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 8 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 9 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 10 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 11 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 12 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 13 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 14 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 15 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
$ cat /proc/scsi/scsi 
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0b
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: WANGTEK  Model: 5525ES SCSI      Rev: 73F 
  Type:   Sequential-Access                ANSI SCSI revision: 02


/var/log/messages:

kernel:  scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
kernel:          <Adaptec aic7890/91 Ultra2 SCSI adapter>
kernel:          aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
kernel:  
kernel:    Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0b
kernel:    Type:   CD-ROM                             ANSI SCSI revision: 02
kernel:   target0:0:3: Beginning Domain Validation
kernel:   target0:0:3: Domain Validation skipping write tests
kernel:  (scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
kernel:   target0:0:3: Ending Domain Validation
kernel:    Vendor: WANGTEK   Model: 5525ES SCSI       Rev: 73F 
kernel:    Type:   Sequential-Access                  ANSI SCSI revision: 02
kernel:   target0:0:4: Beginning Domain Validation
kernel:   target0:0:4: Domain Validation skipping write tests
kernel:  scsi0:0:4:0: Attempting to queue an ABORT message
kernel:  CDB: 0x12 0x0 0x0 0x0 0x2c 0x0
kernel:  scsi0: At time of recovery, card was not paused
kernel:  >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
kernel:  scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x16e
kernel:  Card was paused
kernel:  ACCUM = 0xa0, SINDEX = 0x61, DINDEX = 0xe4, ARG_2 = 0x0
kernel:  HCNT = 0x0 SCBPTR = 0x0
kernel:  SCSISIGI[0xa4]:(BSYI|MSGI|CDI) ERROR[0x0] SCSIBUSL[0x7] 
kernel:  LASTPHASE[0xa0]:(MSGI|CDI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
kernel:  SBLKCTL[0xa]:(SELWIDE|SELBUSB) SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
kernel:  SEQ_FLAGS[0x40]:(NO_CDB_SENT) SSTAT0[0x0] SSTAT1[0x2]:(PHASECHG) 
kernel:  SSTAT2[0x10]:(EXP_ACTIVE) SSTAT3[0x0] SIMODE0[0x8]:(ENSWRAP) 
kernel:  SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
kernel:  SXFRCTL0[0x88]:(SPIOEN|DFON) DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL) 
kernel:  STACK: 0xe4 0x0 0x166 0x17c
kernel:  SCB count = 4
kernel:  Kernel NEXTQSCB = 3
kernel:  Card NEXTQSCB = 3
kernel:  QINFIFO entries: 
kernel:  Waiting Queue entries: 
kernel:  Disconnected Queue entries: 
kernel:  QOUTFIFO entries: 
kernel:  Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
kernel:  Sequencer SCB Info: 
kernel:    0 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x47] SCB_LUN[0x0] 
kernel:  SCB_TAG[0x2] 
kernel:    1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   16 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   17 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   18 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   19 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   20 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   21 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   22 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   23 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   24 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   25 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   26 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   27 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   28 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   29 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   30 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   31 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:  Pending list: 
kernel:    2 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x47] SCB_LUN[0x0] 
kernel:  Kernel Free SCB list: 1 0 
kernel:  Untagged Q(4): 2 
kernel:  
kernel:  <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
kernel:  scsi0:0:4:0: Device is active, asserting ATN
kernel:  Recovery code sleeping
kernel:  Recovery code awake
kernel:  Timer Expired
kernel:  aic7xxx_abort returns 0x2003
kernel:  scsi0:0:4:0: Attempting to queue a TARGET RESET message
kernel:  CDB: 0x12 0x0 0x0 0x0 0x2c 0x0
kernel:  aic7xxx_dev_reset returns 0x2003
kernel:  Recovery SCB completes
kernel:   target0:0:4: Domain Validation detected failure, dropping back
kernel:  scsi0:0:4:0: Attempting to queue an ABORT message
kernel:  CDB: 0x12 0x0 0x0 0x0 0x2c 0x0
kernel:  scsi0: At time of recovery, card was not paused
kernel:  >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
kernel:  scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x16e
kernel:  Card was paused
kernel:  ACCUM = 0xa0, SINDEX = 0x61, DINDEX = 0xe4, ARG_2 = 0x0
kernel:  HCNT = 0x0 SCBPTR = 0x0
kernel:  SCSISIGI[0xa4]:(BSYI|MSGI|CDI) ERROR[0x0] SCSIBUSL[0x7] 
kernel:  LASTPHASE[0xa0]:(MSGI|CDI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
kernel:  SBLKCTL[0xa]:(SELWIDE|SELBUSB) SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
kernel:  SEQ_FLAGS[0x40]:(NO_CDB_SENT) SSTAT0[0x0] SSTAT1[0x2]:(PHASECHG) 
kernel:  SSTAT2[0x10]:(EXP_ACTIVE) SSTAT3[0x0] SIMODE0[0x8]:(ENSWRAP) 
kernel:  SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
kernel:  SXFRCTL0[0x88]:(SPIOEN|DFON) DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL) 
kernel:  STACK: 0xe4 0xe4 0x166 0x17c
kernel:  SCB count = 4
kernel:  Kernel NEXTQSCB = 2
kernel:  Card NEXTQSCB = 2
kernel:  QINFIFO entries: 
kernel:  Waiting Queue entries: 
kernel:  Disconnected Queue entries: 
kernel:  QOUTFIFO entries: 
kernel:  Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
kernel:  Sequencer SCB Info: 
kernel:    0 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x47] SCB_LUN[0x0] 
kernel:  SCB_TAG[0x3] 
kernel:    1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   16 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   17 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   18 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   19 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   20 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   21 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   22 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   23 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   24 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   25 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   26 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   27 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   28 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   29 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   30 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   31 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:  Pending list: 
kernel:    3 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x47] SCB_LUN[0x0] 
kernel:  Kernel Free SCB list: 1 0 
kernel:  Untagged Q(4): 3 
kernel:  
kernel:  <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
kernel:  scsi0:0:4:0: Device is active, asserting ATN
kernel:  Recovery code sleeping
kernel:  Recovery code awake
kernel:  Timer Expired
kernel:  aic7xxx_abort returns 0x2003
kernel:  scsi0:0:4:0: Attempting to queue a TARGET RESET message
kernel:  CDB: 0x12 0x0 0x0 0x0 0x2c 0x0
kernel:  aic7xxx_dev_reset returns 0x2003
kernel:  Recovery SCB completes
kernel:   target0:0:4: Domain Validation detected failure, dropping back
kernel:  scsi0:0:4:0: Attempting to queue an ABORT message
kernel:  CDB: 0x12 0x0 0x0 0x0 0x2c 0x0
kernel:  scsi0: At time of recovery, card was not paused
kernel:  >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
kernel:  scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x16e
kernel:  Card was paused
kernel:  ACCUM = 0xa0, SINDEX = 0x61, DINDEX = 0xe4, ARG_2 = 0x0
kernel:  HCNT = 0x0 SCBPTR = 0x0
kernel:  SCSISIGI[0xa4]:(BSYI|MSGI|CDI) ERROR[0x0] SCSIBUSL[0x7] 
kernel:  LASTPHASE[0xa0]:(MSGI|CDI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
kernel:  SBLKCTL[0xa]:(SELWIDE|SELBUSB) SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
kernel:  SEQ_FLAGS[0x40]:(NO_CDB_SENT) SSTAT0[0x0] SSTAT1[0x2]:(PHASECHG) 
kernel:  SSTAT2[0x10]:(EXP_ACTIVE) SSTAT3[0x0] SIMODE0[0x8]:(ENSWRAP) 
kernel:  SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
kernel:  SXFRCTL0[0x88]:(SPIOEN|DFON) DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL) 
kernel:  STACK: 0xe4 0xe4 0x166 0x17c
kernel:  SCB count = 4
kernel:  Kernel NEXTQSCB = 3
kernel:  Card NEXTQSCB = 3
kernel:  QINFIFO entries: 
kernel:  Waiting Queue entries: 
kernel:  Disconnected Queue entries: 
kernel:  QOUTFIFO entries: 
kernel:  Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
kernel:  Sequencer SCB Info: 
kernel:    0 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x47] SCB_LUN[0x0] 
kernel:  SCB_TAG[0x2] 
kernel:    1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:    9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   16 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   17 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   18 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   19 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   20 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   21 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   22 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   23 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   24 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   25 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   26 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   27 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   28 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   29 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   30 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:   31 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
kernel:  SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
kernel:  Pending list: 
kernel:    2 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x47] SCB_LUN[0x0] 
kernel:  Kernel Free SCB list: 1 0 
kernel:  Untagged Q(4): 2 
kernel:  
kernel:  <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
kernel:  scsi0:0:4:0: Device is active, asserting ATN
kernel:  Recovery code sleeping
kernel:  Recovery code awake
kernel:  Timer Expired
kernel:  aic7xxx_abort returns 0x2003

-- 
Frank

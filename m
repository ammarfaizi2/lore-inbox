Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVFOUwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVFOUwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVFOUvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:51:19 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:65190 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261562AbVFOUtw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:49:52 -0400
Date: Wed, 15 Jun 2005 22:49:48 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Gr?goire Favre <gregoire.favre@gmail.com>, dino@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050615204948.GA23616@janus>
References: <1118674783.5079.9.camel@mulgrave> <20050613183719.GA8653@gmail.com> <1118695847.5079.41.camel@mulgrave> <20050613214208.GA7471@janus> <1118703593.5079.56.camel@mulgrave> <20050614214226.GA15560@janus> <20050615120237.GB19645@janus> <1118844888.5045.18.camel@mulgrave> <20050615200957.GA23096@janus> <1118866546.5045.76.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1118866546.5045.76.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 03:15:46PM -0500, James Bottomley wrote:
> On Wed, 2005-06-15 at 22:09 +0200, Frank van Maarseveen wrote:
> >         User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
> >         Goal: 10.000MB/s transfers (10.000MHz, offset 15)
> >         Curr: 10.000MB/s transfers (10.000MHz, offset 15)
> 
> This would be why ... you need to set you bios to 10MHz narrow (it's
> currently set to 40MHz wide).

No luck doing so. I tried 10MB, 5MB(8 bit), booting UP (I have a dual
PIII 450), it doesn't really seem to make any difference.

I've set the aic BIOS back to über speed (80MB, wide negotiation)
everywhere and booted 2.6.11-rc5 again:

Jun 15 22:43:00 iapetus kernel: Uniform CD-ROM driver Revision: 3.20
Jun 15 22:43:00 iapetus kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Jun 15 22:43:00 iapetus kernel:         <Adaptec aic7890/91 Ultra2 SCSI adapter>
Jun 15 22:43:00 iapetus kernel:         aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
Jun 15 22:43:00 iapetus kernel: 
Jun 15 22:43:00 iapetus kernel: (scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
Jun 15 22:43:00 iapetus kernel:   Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0b
Jun 15 22:43:00 iapetus kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jun 15 22:43:00 iapetus kernel: scsi0:0:4:0: Attempting to queue an ABORT message
Jun 15 22:43:00 iapetus kernel: CDB: 0x12 0x0 0x0 0x0 0x24 0x0
Jun 15 22:43:00 iapetus kernel: scsi0: At time of recovery, card was not paused
Jun 15 22:43:00 iapetus kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Jun 15 22:43:00 iapetus kernel: scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x16e
Jun 15 22:43:00 iapetus kernel: Card was paused
Jun 15 22:43:00 iapetus kernel: ACCUM = 0xa0, SINDEX = 0x61, DINDEX = 0xe4, ARG_2 = 0x0
Jun 15 22:43:00 iapetus kernel: HCNT = 0x0 SCBPTR = 0x0
Jun 15 22:43:00 iapetus kernel: SCSISIGI[0xa4]:(BSYI|MSGI|CDI) ERROR[0x0] SCSIBUSL[0x7] 
Jun 15 22:43:00 iapetus kernel: LASTPHASE[0xa0]:(MSGI|CDI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
Jun 15 22:43:01 iapetus kernel: SBLKCTL[0xa]:(SELWIDE|SELBUSB) SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
Jun 15 22:43:01 iapetus kernel: SEQ_FLAGS[0x40]:(NO_CDB_SENT) SSTAT0[0x0] SSTAT1[0x2]:(PHASECHG) 
Jun 15 22:43:01 iapetus kernel: SSTAT2[0x10]:(EXP_ACTIVE) SSTAT3[0x0] SIMODE0[0x8]:(ENSWRAP) 
Jun 15 22:43:01 iapetus kernel: SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
Jun 15 22:43:01 iapetus kernel: SXFRCTL0[0x88]:(SPIOEN|DFON) DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL) 
Jun 15 22:43:01 iapetus kernel: STACK: 0xe4 0x0 0x166 0x17c
Jun 15 22:43:01 iapetus kernel: SCB count = 4
Jun 15 22:43:01 iapetus kernel: Kernel NEXTQSCB = 2
Jun 15 22:43:01 iapetus kernel: Card NEXTQSCB = 2
Jun 15 22:43:01 iapetus kernel: QINFIFO entries: 
Jun 15 22:43:01 iapetus kernel: Waiting Queue entries: 
Jun 15 22:43:01 iapetus kernel: Disconnected Queue entries: 
Jun 15 22:43:01 iapetus kernel: QOUTFIFO entries: 
Jun 15 22:43:01 iapetus kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Jun 15 22:43:01 iapetus kernel: Sequencer SCB Info: 
Jun 15 22:43:01 iapetus kernel:   0 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x47] SCB_LUN[0x0] 
Jun 15 22:43:01 iapetus kernel: SCB_TAG[0x3] 
Jun 15 22:43:01 iapetus kernel:   1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:   2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:   3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:   4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:   5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:   6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:   7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:   8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:   9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  16 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  17 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  18 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  19 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  20 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  21 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  22 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  23 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  24 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  25 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  26 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  27 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  28 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  29 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  30 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel:  31 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
Jun 15 22:43:01 iapetus kernel: SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Jun 15 22:43:01 iapetus kernel: Pending list: 
Jun 15 22:43:01 iapetus kernel:   3 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x47] SCB_LUN[0x0] 
Jun 15 22:43:02 iapetus kernel: Kernel Free SCB list: 1 0 
Jun 15 22:43:02 iapetus kernel: Untagged Q(4): 3 
Jun 15 22:43:02 iapetus kernel: DevQ(0:3:0): 0 waiting
Jun 15 22:43:02 iapetus kernel: DevQ(0:4:0): 0 waiting
Jun 15 22:43:02 iapetus kernel: 
Jun 15 22:43:02 iapetus kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Jun 15 22:43:02 iapetus kernel: scsi0:0:4:0: Device is active, asserting ATN
Jun 15 22:43:02 iapetus kernel: Recovery code sleeping
Jun 15 22:43:02 iapetus kernel: Recovery code awake
Jun 15 22:43:02 iapetus kernel: Timer Expired
Jun 15 22:43:02 iapetus kernel: aic7xxx_abort returns 0x2003
Jun 15 22:43:02 iapetus kernel: scsi0:0:4:0: Attempting to queue a TARGET RESET message
Jun 15 22:43:02 iapetus kernel: CDB: 0x12 0x0 0x0 0x0 0x24 0x0
Jun 15 22:43:02 iapetus kernel: aic7xxx_dev_reset returns 0x2003
Jun 15 22:43:02 iapetus kernel: Recovery SCB completes
Jun 15 22:43:02 iapetus kernel:   Vendor: WANGTEK   Model: 5525ES SCSI       Rev: 73F 
Jun 15 22:43:02 iapetus kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Jun 15 22:43:02 iapetus kernel: st: Version 20041025, fixed bufsize 32768, s/g segs 256
Jun 15 22:43:02 iapetus kernel: Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Jun 15 22:43:02 iapetus kernel: st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
Jun 15 22:43:02 iapetus kernel: sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
Jun 15 22:43:02 iapetus kernel: Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 5
Jun 15 22:43:02 iapetus kernel: Attached scsi generic sg1 at scsi0, channel 0, id 4, lun 0,  type 1

so no real problem here.

-- 
Frank

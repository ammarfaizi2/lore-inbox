Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVHKCac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVHKCac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 22:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVHKCab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 22:30:31 -0400
Received: from mxsf37.cluster1.charter.net ([209.225.28.162]:21913 "EHLO
	mxsf37.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750876AbVHKCaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 22:30:30 -0400
X-IronPort-AV: i="3.96,98,1122868800"; 
   d="scan'208"; a="612933353:sNHT20062284"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17146.47169.920230.343522@smtp.charter.net>
Date: Wed, 10 Aug 2005 22:30:25 -0400
From: "John Stoffel" <john@stoffel.org>
To: "John Stoffel" <john@stoffel.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
In-Reply-To: <17146.10987.646530.492808@smtp.charter.net>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
	<200508081954.52638.jesper.juhl@gmail.com>
	<17145.1417.329260.524528@smtp.charter.net>
	<1123617516.5170.42.camel@mulgrave>
	<17145.3629.933024.963438@smtp.charter.net>
	<1123635010.5170.75.camel@mulgrave>
	<17146.7454.818003.464185@smtp.charter.net>
	<1123688778.5134.3.camel@mulgrave>
	<17146.10987.646530.492808@smtp.charter.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

Dropped back to 2.6.11.1 and it hung again.  I was able to get the
drive back by power cycling it and then doing the scsiadd to drop and
re-add the drive.  I then used the bacula 'btape' tool to run some
tests.  It seems to be just fine with regular files, but when it hit
EOM, all hell seems to break loose.

There is newer firmware available for the drive, so I'll see about
upgrading the firmware ASAP and see if that happens.  Unfortunately,
it's a SUN branded DLT and I don't have sun hardware at home.  

Here's the latest dmesg error logs:

Attached scsi tape st0 at scsi1, channel 0, id 6, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
Attached scsi generic sg3 at scsi1, channel 0, id 6, lun 0,  type 1
st0: Block limits 2 - 16777214 bytes.
scsi1:0:6:0: Attempting to queue an ABORT message
CDB: 0xa 0x0 0x0 0xfc 0x0 0x0
scsi1: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State in Data-out phase, at SEQADDR 0x83
Card was paused
ACCUM = 0x0, SINDEX = 0xb8, DINDEX = 0xa8, ARG_2 = 0xff
HCNT = 0x0 SCBPTR = 0x0
SCSISIGI[0x4]:(BSYI) ERROR[0x0] SCSIBUSL[0xc0] 
LASTPHASE[0x0] SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
SBLKCTL[0x2]:(SELWIDE) SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
SEQ_FLAGS[0x20]:(DPHASE) SSTAT0[0x7]:(DMADONE|SPIORDY|SDONE) 
SSTAT1[0x2]:(PHASECHG) SSTAT2[0x0] SSTAT3[0x0] 
SIMODE0[0x0] SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
SXFRCTL0[0x88]:(SPIOEN|DFON) DFCNTRL[0x4]:(DIRECTION) 
DFSTATUS[0x6d]:(FIFOEMP|DFTHRESH|HDONE|FIFOQWDEMP|DFCACHETH) 
STACK: 0x37 0x150 0x191 0x5f
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Sequencer SCB Info: 
  0 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0] 
SCB_TAG[0x3] 
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
Pending list: 
  3 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0] 
Kernel Free SCB list: 1 0 
Untagged Q(6): 3 

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi1:0:6:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
scsi1:0:6:0: Attempting to queue a TARGET RESET message
CDB: 0xa 0x0 0x0 0xfc 0x0 0x0
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 6 lun 0
st0: Error 10000 (sugg. bt 0x0, driver bt 0x0, host bt 0x1).

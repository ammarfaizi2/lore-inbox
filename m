Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbUBUKsn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 05:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbUBUKsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 05:48:43 -0500
Received: from [62.38.226.226] ([62.38.226.226]:51840 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S261544AbUBUKsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 05:48:38 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Fabio Coatti <cova@ferrara.linux.it>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-mm1 and aic7xxx
Date: Sat, 21 Feb 2004 12:47:02 +0200
User-Agent: KMail/1.6
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402211247.02085.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just noted some nasty behavior at 2.6.3 ( not -mm1) wrt. aic7xxx.

With 2.6.2 I hadn't noticed any trouble (for the last 6 days I've been running 
it). Now, the box hung twice, while trying to use the scsi cd-recorder (HP 
m820e) I have. The machine is 'blind' (i.e. no console) so I couldn't get any 
trace/logs..
First time was while starting 'cdrecord-2.0'. Just when trying to query the 
device. At the same time the scsi bus was accessing an iomega zip100 drive, 
reading data.
Second time must have been the device scanning done by k3b (I believe it uses 
the same scsi libs as cdrecord). Note also that I have an atapi (not 
ide-scsi) recorder, which had been fixating the disk it had written when the 
box hung.

Does this relate to the problem you mention ? 

 I could only recover the following log: (0 4 0 is the scsi M820e recorder)

SCSI error : <0 0 4 0> return code = 0x70002
Feb 21 12:07:19 pfn1 last message repeated 6 times
scsi0:0:4:0: Attempting to queue an ABORT message
CDB: 0x46 0x0 0x0 0x0 0x24 0x0 0x0 0x0 0x8 0x0
scsi0: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State in Command phase, at SEQADDR 0x166
Card was paused
ACCUM = 0x80, SINDEX = 0xac, DINDEX = 0xc0, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISIGI[0x84]:(BSYI|CDI) ERROR[0x0] SCSIBUSL[0x8] 
LASTPHASE[0x80]:(CDI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
SBLKCTL[0x0] SCSIRATE[0x28] SEQCTL[0x10]:(FASTMODE) 
SEQ_FLAGS[0x0] SSTAT0[0x7]:(DMADONE|SPIORDY|SDONE) 
SSTAT1[0x2]:(PHASECHG) SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] 
SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
SXFRCTL0[0x88]:(SPIOEN|DFON) DFCNTRL[0x4]:(DIRECTION) 
DFSTATUS[0x6d]:(FIFOEMP|DFTHRESH|HDONE|FIFOQWDEMP|DFCACHETH) 
STACK: 0x35 0xd3 0x160 0x1a1
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 2 
Sequencer SCB Info: 
  0 SCB_CONTROL[0x0] SCB_SCSIID[0x47] SCB_LUN[0x0] SCB_TAG[0x3] 
  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Pending list: 
  3 SCB_CONTROL[0x0] SCB_SCSIID[0x47] SCB_LUN[0x0] 
Kernel Free SCB list: 1 0 
Untagged Q(4): 3 
DevQ(0:4:0): 0 waiting
DevQ(0:6:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi0:0:4:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
scsi0:0:4:0: Attempting to queue a TARGET RESET message
CDB: 0x46 0x0 0x0 0x0 0x24 0x0 0x0 0x0 0x8 0x0
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes
... hang, I press the win98 key .. 
Feb 21 12:09:54 pfn1 syslogd 1.4.1: restart.


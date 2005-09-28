Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbVI1QHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVI1QHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVI1QHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:07:49 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:11793 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751091AbVI1QHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:07:48 -0400
Date: Wed, 28 Sep 2005 18:07:44 +0200
From: Olivier Galibert <galibert@pobox.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Infinite interrupt loop, INTSTAT = 0
Message-ID: <20050928160744.GA37975@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20050928134514.GA19734@dspnet.fr.eu.org> <1127919909.4852.7.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127919909.4852.7.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 10:05:08AM -0500, James Bottomley wrote:
> What was it doing before this?  i.e. what were all the messages from the
> card.  The message happens when the aic driver is unable to clear its
> pending workqueue after it suspends ... which is part of error recovery.
> So, what error was it trying to recover from?

Good question.  Here is a complete dmesg starting at the mount
/dev/sdb1 /ritel1 which crashes the system eventually (I did a dmesg -c
just before doing the mount):

ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
scsi1:0:0:0: Attempting to abort cmd ffff8101b1cdf880: 0x28 0x0 0x0 0xbc 0x0 0x3f 0x0 0x0 0x8 0x0
Infinite interrupt loop, INTSTAT = 0scsi1: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State at program address 0x5 Mode 0x33
Card was paused
HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
DFFSTAT[0x33] SCSISIGI[0x24] SCSIPHASE[0x0] SCSIBUS[0x0] 
LASTPHASE[0x1] SCSISEQ0[0x40] SCSISEQ1[0x12] SEQCTL0[0x0] 
SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x10] 
SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0xc0] 
SIMODE1[0xac] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80] 
LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x40] 

SCB Count = 4 CMDS_PENDING = 4 LASTSCB 0x1 CURRSCB 0x1 NEXTSCB 0xff00
qinstart = 146 qinfifonext = 146
QINFIFO:
WAITING_TID_QUEUES:
       0 ( 0x1 )
Pending list:
  1 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
  2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
  3 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
  0 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Total 4
Kernel Free SCB list: 
Sequencer Complete DMA-inprog list: 
Sequencer Complete list: 
Sequencer DMA-Up and Complete list: 

scsi1: FIFO0 Free, LONGJMP == 0x8252, SCB 0x1
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
LQIN: 0x8 0x0 0x0 0x1 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
scsi1: LQISTATE = 0x1, LQOSTATE = 0x1a, OPTIONMODE = 0x52
scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x0
SIMODE0[0xc] 
CCSCBCTL[0x4] 
scsi1: REG0 == 0x1, SINDEX = 0x102, DINDEX = 0x102
scsi1: SCBPTR == 0x1, SCB_NEXT == 0xff00, SCB_NEXT2 == 0xff04
CDB 28 0 0 c8 0 3f
STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
DevQ(0:0:0): 0 waiting
DevQ(0:0:1): 0 waiting
scsi1:0:0:0: Cmd aborted from QINFIFO

Abort on some timeout?

  OG.

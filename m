Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbVI1Np1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbVI1Np1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 09:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVI1Np1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 09:45:27 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:8968 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750975AbVI1NpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 09:45:25 -0400
Date: Wed, 28 Sep 2005 15:45:14 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-scsi@vger.kernel.org, "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Infinite interrupt loop, INTSTAT = 0
Message-ID: <20050928134514.GA19734@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-scsi@vger.kernel.org,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having identical problems with a pair of Fibrenetix VP-1252-U4
plugged on:
- Dual Xeon 32 bits with a mobo-integrated:
    03:02.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
    03:02.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
    and a 2.6.11-1.14_FC3.smp kernel

- Dual Xeon 64 bits with a mobo-integrated:
    02:02.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
    02:02.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
    and a 2.6.13.2 kernel (native 64bits)


It seems not to happen on a Dual Xeon 32 with a pci(x?) card:
    01:02.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)


The error I get is:

Sep 28 15:26:13 m82 kernel: scsi1:0:0:0: Attempting to abort cmd ffff8100bfe3e300: 0x28 0x0 0x0 0x50 0x0 0x3f 0x0 0x0 0x8 0x0
Sep 28 15:26:13 m82 kernel: Infinite interrupt loop, INTSTAT = 0scsi1: At time of recovery, card was not paused
Sep 28 15:26:13 m82 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Sep 28 15:26:13 m82 kernel: scsi1: Dumping Card State at program address 0x26 Mode 0x33
Sep 28 15:26:13 m82 kernel: Card was paused
Sep 28 15:26:13 m82 kernel: HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
Sep 28 15:26:13 m82 kernel: DFFSTAT[0x33] SCSISIGI[0x24] SCSIPHASE[0x0] SCSIBUS[0x0] 
Sep 28 15:26:13 m82 kernel: LASTPHASE[0x1] SCSISEQ0[0x40] SCSISEQ1[0x12] SEQCTL0[0x0] 
Sep 28 15:26:13 m82 kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x10] 
Sep 28 15:26:13 m82 kernel: SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0xc0] 
Sep 28 15:26:13 m82 kernel: SIMODE1[0xac] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80] 
Sep 28 15:26:13 m82 kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x40] 
Sep 28 15:26:13 m82 kernel: 
Sep 28 15:26:13 m82 kernel: SCB Count = 4 CMDS_PENDING = 3 LASTSCB 0x1 CURRSCB 0x1 NEXTSCB 0xff40
Sep 28 15:26:13 m82 kernel: qinstart = 119 qinfifonext = 119
Sep 28 15:26:13 m82 kernel: QINFIFO:
Sep 28 15:26:13 m82 kernel: WAITING_TID_QUEUES:
Sep 28 15:26:13 m82 kernel: Pending list:
Sep 28 15:26:13 m82 kernel:   2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 15:26:13 m82 kernel:   3 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 15:26:13 m82 kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 15:26:13 m82 kernel: Total 3
Sep 28 15:26:13 m82 kernel: Kernel Free SCB list: 1 
Sep 28 15:26:13 m82 kernel: Sequencer Complete DMA-inprog list: 
Sep 28 15:26:14 m82 kernel: Sequencer Complete list: 
Sep 28 15:26:14 m82 kernel: Sequencer DMA-Up and Complete list: 
Sep 28 15:26:14 m82 kernel: 
Sep 28 15:26:14 m82 kernel: scsi1: FIFO0 Free, LONGJMP == 0x8252, SCB 0x1
Sep 28 15:26:14 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 15:26:14 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 15:26:14 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 15:26:14 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 15:26:14 m82 kernel: scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
Sep 28 15:26:14 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 15:26:14 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 15:26:14 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 15:26:14 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 15:26:14 m82 kernel: LQIN: 0x8 0x0 0x0 0x1 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Sep 28 15:26:14 m82 kernel: scsi1: LQISTATE = 0x1, LQOSTATE = 0x1a, OPTIONMODE = 0x52
Sep 28 15:26:14 m82 kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x0
Sep 28 15:26:14 m82 kernel: SIMODE0[0xc] 
Sep 28 15:26:14 m82 kernel: CCSCBCTL[0x4] 
Sep 28 15:26:14 m82 kernel: scsi1: REG0 == 0x1, SINDEX = 0x102, DINDEX = 0x102
Sep 28 15:26:14 m82 kernel: scsi1: SCBPTR == 0x1, SCB_NEXT == 0xff80, SCB_NEXT2 == 0xff01
Sep 28 15:26:14 m82 kernel: CDB 0 0 0 0 0 0
Sep 28 15:26:14 m82 kernel: STACK: 0x12 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Sep 28 15:26:14 m82 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Sep 28 15:26:14 m82 kernel: DevQ(0:0:0): 0 waiting
Sep 28 15:26:14 m82 kernel: DevQ(0:0:1): 0 waiting
Sep 28 15:26:14 m82 kernel: (scsi1:A:0:0): Device is disconnected, re-queuing SCB
Sep 28 15:26:14 m82 kernel: Recovery code sleeping


The Fibrenetix appears as a pair of 2Tb disks at 0/0/0 and 0/0/1.
There is nothing else on the same scsi bus (there are things on scsi0
though).

What should I try ?

  OG.


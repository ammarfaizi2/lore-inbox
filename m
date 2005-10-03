Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVJCNmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVJCNmX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 09:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVJCNmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 09:42:23 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:51973 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932129AbVJCNmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 09:42:22 -0400
Date: Mon, 3 Oct 2005 15:42:10 +0200
From: Olivier Galibert <galibert@pobox.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Infinite interrupt loop, INTSTAT = 0
Message-ID: <20051003134210.GA10641@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20050928134514.GA19734@dspnet.fr.eu.org> <1127919909.4852.7.camel@mulgrave> <20050928160744.GA37975@dspnet.fr.eu.org> <1127924686.4852.11.camel@mulgrave> <20050928171052.GA45082@dspnet.fr.eu.org> <1127929909.4852.34.camel@mulgrave> <20050928183324.GA51793@dspnet.fr.eu.org> <1128175434.4921.9.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128175434.4921.9.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 09:03:54AM -0500, James Bottomley wrote:
> The first thing to try here is to bring the offset down to 63 like all
> the other devices.  You can do this by
> 
> echo 63 > /sys/class/spi_transport/target1\:0\:0/max_offset
> echo 1 > /sys/class/spi_transport/target1\:0\:0/revalidate
> 
> Which should retrigger the above domain validation but this time come
> back with an offset of 63.

Well, retriggering the DV blows:

Oct  3 15:39:03 m82 kernel:  target1:0:0: Beginning Domain Validation
Oct  3 15:39:03 m82 kernel:  target1:0:0: asynchronous.
Oct  3 15:39:03 m82 kernel: scsi1: Returning to Idle Loop
Oct  3 15:39:13 m82 kernel: scsi1:0:0:0: Attempting to queue an ABORT message:CDB: 0x12 0x0 0x0 0x0 0x62 0x0
Oct  3 15:39:13 m82 kernel: scsi1: At time of recovery, card was not paused
Oct  3 15:39:13 m82 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Oct  3 15:39:13 m82 kernel: scsi1: Dumping Card State at program address 0x26 Mode 0x22
Oct  3 15:39:13 m82 kernel: Card was paused
Oct  3 15:39:13 m82 kernel: HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
Oct  3 15:39:13 m82 kernel: DFFSTAT[0x33] SCSISIGI[0x86] SCSIPHASE[0x10] SCSIBUS[0x0] 
Oct  3 15:39:13 m82 kernel: LASTPHASE[0x1] SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0] 
Oct  3 15:39:13 m82 kernel: SEQINTCTL[0x0] SEQ_FLAGS[0xc0] SEQ_FLAGS2[0x0] 
Oct  3 15:39:13 m82 kernel: SSTAT0[0x2] SSTAT1[0x19] SSTAT2[0x0] SSTAT3[0x0] 
Oct  3 15:39:13 m82 kernel: PERRDIAG[0xc0] SIMODE1[0xac] LQISTAT0[0x0] LQISTAT1[0x0] 
Oct  3 15:39:13 m82 kernel: LQISTAT2[0x0] LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x0] 
Oct  3 15:39:13 m82 kernel: 
Oct  3 15:39:13 m82 kernel: SCB Count = 4 CMDS_PENDING = 1 LASTSCB 0xffff CURRSCB 0x2 NEXTSCB 0xff80
Oct  3 15:39:13 m82 kernel: qinstart = 85 qinfifonext = 85
Oct  3 15:39:13 m82 kernel: QINFIFO:
Oct  3 15:39:13 m82 kernel: WAITING_TID_QUEUES:
Oct  3 15:39:13 m82 kernel: Pending list:
Oct  3 15:39:13 m82 kernel:   2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Oct  3 15:39:13 m82 kernel: Total 1
Oct  3 15:39:13 m82 kernel: Kernel Free SCB list: 3 1 0 
Oct  3 15:39:13 m82 kernel: Sequencer Complete DMA-inprog list: 
Oct  3 15:39:13 m82 kernel: Sequencer Complete list: 
Oct  3 15:39:13 m82 kernel: Sequencer DMA-Up and Complete list: 
Oct  3 15:39:13 m82 kernel: 
Oct  3 15:39:13 m82 kernel: scsi1: FIFO0 Free, LONGJMP == 0x8252, SCB 0x2
Oct  3 15:39:13 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Oct  3 15:39:13 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Oct  3 15:39:13 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Oct  3 15:39:13 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Oct  3 15:39:13 m82 kernel: scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
Oct  3 15:39:13 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Oct  3 15:39:13 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Oct  3 15:39:13 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Oct  3 15:39:13 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Oct  3 15:39:13 m82 kernel: LQIN: 0x8 0x0 0x0 0x2 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Oct  3 15:39:13 m82 kernel: scsi1: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52
Oct  3 15:39:13 m82 kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
Oct  3 15:39:13 m82 kernel: SIMODE0[0xc] 
Oct  3 15:39:13 m82 kernel: CCSCBCTL[0x4] 
Oct  3 15:39:13 m82 kernel: scsi1: REG0 == 0x2, SINDEX = 0x107, DINDEX = 0x102
Oct  3 15:39:13 m82 kernel: scsi1: SCBPTR == 0x2, SCB_NEXT == 0xffc0, SCB_NEXT2 == 0xff01
Oct  3 15:39:13 m82 kernel: CDB 12 0 0 0 62 0
Oct  3 15:39:13 m82 kernel: STACK: 0x14 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Oct  3 15:39:13 m82 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Oct  3 15:39:13 m82 kernel: (scsi1:A:0:0): Device is disconnected, re-queuing SCB
Oct  3 15:39:14 m82 kernel: Recovery code sleeping
Oct  3 15:39:18 m82 kernel: Recovery code awake
Oct  3 15:39:18 m82 kernel: Timer Expired
Oct  3 15:39:18 m82 kernel: aic79xx_abort returns 0x2003
Oct  3 15:39:18 m82 kernel: scsi1:0:0:0: Attempting to queue a TARGET RESET message:CDB: 0x12 0x0 0x0 0x0 0x62 0x0
Oct  3 15:39:18 m82 kernel: aic79xx_dev_reset returns 0x2003
Oct  3 15:39:18 m82 kernel: Recovery SCB completes
Oct  3 15:39:28 m82 kernel:  target1:0:0: Domain Validation Initial Inquiry Failed
Oct  3 15:39:28 m82 kernel:  target1:0:0: Ending Domain Validation

The two echo were done after a fresh reboot with no mount done on sdb
or sbc.

  OG.


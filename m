Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVJHMdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVJHMdv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 08:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVJHMdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 08:33:50 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:49584 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S932088AbVJHMdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 08:33:49 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Re: 2.6.13-rt12: irqs hard off for 657 usecs
Date: Sat, 8 Oct 2005 12:33:48 +0000 (UTC)
Organization: Cistron
Message-ID: <di8ebc$b9k$1@news.cistron.nl>
References: <1128724690.17981.57.camel@mindpipe> <20051008115828.GA29042@elte.hu>
X-Trace: ncc1701.cistron.net 1128774828 11572 62.216.30.70 (8 Oct 2005 12:33:48 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar  <mingo@elte.hu> wrote:
>> Something appears to have disabled IRQs for 657 usecs.
>hm ... i fixed one such bug in rt.c recently, but more could be lurking.  
>Could you send me your .config?

Ingo, 
could this be the same bug that's been hitting me since 2.6.13* ?
usenetgateway (heavy used server) with scsi/gig-E ethernet which
crashes within couple of days.

Last kernel i tried was 2.6.14-rc3-git5  and that was the first kernel
which also reported:

------------
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip release_console_sem+0x151/0x210
Falling back to HPET
printk: 4 messages suppressed.

------------
The crash itself:

scsi0:0:0:0: Attempting to queue an ABORT message:CDB: 0x2a 0x0 0x1 0x79 0x80 0x72 0x0 0x0 0x28 0x0
scsi0: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State at program address 0x26 Mode 0x33
Card was paused
HS_MAILBOX[0x0] INTCTL[0xc0]:(SWTMINTEN|SWTMINTMASK)
SEQINTSTAT[0x10]:(SEQ_SWTMRTO) SAVED_MODE[0x11]
DFFSTAT[0x33]:(CURRFIFO_NONE|FIFO0FREE|FIFO1FREE)
SCSISIGI[0x0]:(P_DATAOUT) SCSIPHASE[0x0] SCSIBUS[0x0]
LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE) SCSISEQ0[0x0]
SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI) SEQCTL0[0x0]
SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x0]
SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0]
SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)
LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] LQOSTAT0[0x0]
LQOSTAT1[0x0] LQOSTAT2[0xe1]:(LQOSTOP0|LQOPKT)

SCB Count = 128 CMDS_PENDING = 32 LASTSCB 0x6 CURRSCB 0x1c NEXTSCB 0xff80
qinstart = 44079 qinfifonext = 44079
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
 14 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x7]

[SNIP]

------------
On all previous kernel crashes either scsi or ethernet suddenly quit working.
Since scsi driver is exact same version as 2.6.12-mm1 which for me keeps working 
perfectly, it sounds logic that if the IRQ system gets fedup some driver is likely
to grind the kernel to a painfull halt.

Just my feedback

Danny



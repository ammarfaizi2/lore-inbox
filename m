Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUBDNle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 08:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUBDNle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 08:41:34 -0500
Received: from intra.cyclades.com ([64.186.161.6]:26251 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261735AbUBDNla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 08:41:30 -0500
Date: Wed, 4 Feb 2004 11:26:30 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Lukasz Trabinski <lukasz@trabinski.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, dwmw2@infradead.org,
       riel@redhat.com, linux-kernel@vger.kernel.org,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: Linux 2.4.25-pre6
In-Reply-To: <Pine.LNX.4.58LT.0401221334070.2772@oceanic.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.58L.0402041119311.1700@logos.cnet>
References: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401201940470.29729@logos.cnet> 
 <Pine.LNX.4.58LT.0401210746350.2482@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401210852490.5072@logos.cnet> 
 <Pine.LNX.4.58LT.0401211225560.31684@oceanic.wsisiz.edu.pl>
 <1074686081.16045.141.camel@imladris.demon.co.uk>
 <Pine.LNX.4.58LT.0401211702100.23288@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.58L.0401211809220.5874@logos.cnet> <Pine.LNX.4.58L.0401220929450.18938@logos.cnet>
 <Pine.LNX.4.58LT.0401221248560.11640@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.58L.0401221014510.18938@logos.cnet>
 <Pine.LNX.4.58LT.0401221334070.2772@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lukasz,

I wonder if this SCSI errors might have anything to do with your problem.

I'm reluctant to revert riel's patch because it does not seem to be the
cause for such problems --- it is pretty straighforward and no one can see
why it would corrupt the inode list (as per dwmw2's investigation).

When/how often do this SCSI errors messages happen ? When you saw the
lockup, which driver were you using? (Justin's latest or 2.4.25 vanilla
aic7xxx).

Justin, can you take a look at this log and enlight me, please? Lukasz
says with your newer driver, this does not happen.

On Thu, 22 Jan 2004, Lukasz Trabinski wrote:

> On Thu, 22 Jan 2004, Marcelo Tosatti wrote:
>
> > > oceanic:~$ w |grep users
> > >  12:50:31  up 1 day,  6:09, 39 users,  load average: 0.70, 0.96, 1.15
> > > oceanic:~$ smbstatus -b |wc -l
> > >     138
> >
> > Are you running what kernel now? :)
>
> oceanic:~$ uname -r
> 2.4.25-pre6
>
> with newes driver scsi from http://people.freebsd.org/~gibbs/linux/SRC
> With orginal driver from 2.4.25-pre6 i had messages like this (maybe is
> not driver fault, i don't know):
>
> -------------------------------------------------------
> Jan 16 10:30:07 oceanic kernel: scsi0: FIFO0 Free, LONGJMP == 0x80ff, SCB
> 0x19
> Jan 16 10:30:07 oceanic kernel: scsi0: FIFO1 Free, LONGJMP == 0x8278, SCB
> 0x29
> Jan 16 10:30:07 oceanic kernel: scsi0: LQISTATE = 0x0, LQOSTATE = 0x0,
> OPTIONMODE = 0x42
> Jan 16 10:30:07 oceanic kernel: scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
> Jan 16 10:30:07 oceanic kernel: scsi0: REG0 == 0x29, SINDEX = 0x133,
> DINDEX = 0x106
> Jan 16 10:30:07 oceanic kernel: scsi0: SCBPTR == 0x29, SCB_NEXT == 0xffc0,
> SCB_NEXT2 == 0xff7e
> Jan 16 10:30:07 oceanic kernel: (scsi0:A:0:0): Device is disconnected,
> re-queuing SCB
> Jan 16 10:30:07 oceanic kernel: (scsi0:A:0:0): Task Management Func 0x1
> CompleteJan 16 10:30:07 oceanic kernel: scsi0:0:0:0: Attempting to abort
> cmd f76d0800: 0x0 0x0 0x0 0x0 0x0 0x0
> Jan 16 10:30:07 oceanic kernel: scsi0: At time of recovery, card was not
> paused
> Jan 16 10:30:07 oceanic kernel: scsi0: Dumping Card State at program
> address 0x27 Mode 0x22
> Jan 16 10:30:07 oceanic kernel: scsi0: FIFO0 Free, LONGJMP == 0x80ff, SCB
> 0x19
> Jan 16 10:30:07 oceanic kernel: scsi0: FIFO1 Free, LONGJMP == 0x8278, SCB
> 0x29
> Jan 16 10:30:07 oceanic kernel: scsi0: LQISTATE = 0x0, LQOSTATE = 0x0,
> OPTIONMODE = 0x42
> Jan 16 10:30:07 oceanic kernel: scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
> Jan 16 10:30:07 oceanic kernel: scsi0: REG0 == 0x3b, SINDEX = 0x122,
> DINDEX = 0x102
> Jan 16 10:30:07 oceanic kernel: scsi0: SCBPTR == 0xff3b, SCB_NEXT ==
> 0xff00, SCB_NEXT2 == 0x0
> Jan 16 10:30:07 oceanic kernel: scsi0:0:0:0: Unable to deliver message
> Jan 16 10:30:07 oceanic kernel: scsi0:0:0:0: Attempting to abort cmd
> f76d0a00: 0x2a 0x0 0x7 0xfa 0xa4 0x4e 0x0 0x0 0x88 0x0
> Jan 16 10:30:07 oceanic kernel: scsi0: At time of recovery, card was not
> paused
> Jan 16 10:30:07 oceanic kernel: scsi0: Dumping Card State at program
> address 0x94 Mode 0x33
> Jan 16 10:30:07 oceanic kernel: scsi0: FIFO0 Free, LONGJMP == 0x80ff, SCB
> 0x19
> Jan 16 10:30:07 oceanic kernel: scsi0: FIFO1 Free, LONGJMP == 0x8278, SCB
> 0x29
> Jan 16 10:30:07 oceanic kernel: scsi0: LQISTATE = 0x0, LQOSTATE = 0x0,
> OPTIONMODE = 0x42
> Jan 16 10:30:07 oceanic kernel: scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
> Jan 16 10:30:07 oceanic kernel: scsi0: REG0 == 0x29, SINDEX = 0x100,
> DINDEX = 0x102
> Jan 16 10:30:07 oceanic kernel: scsi0: SCBPTR == 0x3b, SCB_NEXT == 0xff00,
> SCB_NEXT2 == 0xff3c
> Jan 16 10:30:07 oceanic kernel: (scsi0:A:0:0): Device is disconnected,
> re-queuing SCB
> Jan 16 10:30:07 oceanic kernel: (scsi0:A:0:0): Task Management Func 0x1
> CompleteJan 16 10:30:07 oceanic kernel: scsi0:0:0:0: Attempting to abort
> cmd f76d0800: 0x0 0x0 0x0 0x0 0x0 0x0
> Jan 16 10:30:07 oceanic kernel: scsi0: At time of recovery, card was not
> paused
> Jan 16 10:30:07 oceanic kernel: scsi0: Dumping Card State at program
> address 0x27 Mode 0x22
> Jan 16 10:30:07 oceanic kernel: scsi0: FIFO0 Free, LONGJMP == 0x80ff, SCB
> 0x19
> Jan 16 10:30:07 oceanic kernel: scsi0: FIFO1 Free, LONGJMP == 0x8278, SCB
> 0x29
> Jan 16 10:30:07 oceanic kernel: scsi0: LQISTATE = 0x0, LQOSTATE = 0x0,
> OPTIONMODE = 0x42
> Jan 16 10:30:07 oceanic kernel: scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
> Jan 16 10:30:07 oceanic kernel: scsi0: REG0 == 0x3b, SINDEX = 0x122,
> DINDEX = 0x102

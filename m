Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbTFMI2u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbTFMI2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:28:50 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:9221 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265257AbTFMI2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:28:48 -0400
Date: Fri, 13 Jun 2003 10:42:32 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: AIC7xxx 6.2.8: "no active SCB for reconnecting target"
Message-ID: <20030613084232.GA3422@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some new issues on machine with AIC7880 that has been stable for
almost 5 years, and also after the last updates half a year ago. These
troubles have started recently when I removed a Permedia2 video card
(PCI), but the card has been put back, yet the troubles persist (I don't
think it's related, but I mention it anyways), so I think this is a
coincidence.

After some resets, the kernel discards /dev/sdb and /dev/sg1 and returns
EIO for all accesses to the partitions mounted from that drive, but
remains otherwise stable.

I'm pasting the kernel log below. I wonder if this is:

a) a hint to a driver bug that by sheer luck hasn't hit me so far
   (I'd rebuild a more recent kernel in that case -- but this is a
   production machine, so I can't play try this try that games. "Try
   this, it should have been fixed" games are fine though.)

b) hardware deterioration (but sformat -verify hasn't found any issues
   on any of the drives attached) -- the SCSI bus configuration has not
   changed in years. "smartctl -a" 5.1 reports S.M.A.R.T. "GOOD" condition.

c) firmware bug in hard disk drives (unchanged for years).

Any insights appreciated. (I'm stripping date and host and kernel: tag, all
messages were logged in the same second.)

scsi0:A:2: no active SCB for reconnecting target - issuing BUS DEVICE RESET
SAVED_SCSIID == 0x27, SAVED_LUN == 0x0, ARG_1 == 0x3e ACCUM = 0x0
SEQ_FLAGS == 0x0, SCBPTR == 0xf, BTT == 0xff, SINDEX == 0x31
SCSIID == 0x27, SCB_SCSIID == 0x27, SCB_LUN == 0x0, SCB_TAG == 0xff, SCB_CONTROL == 0x68
SCSIBUSL == 0x3e, SCSISIGI == 0xe6
SXFRCTL0 == 0x88
SEQCTL == 0x10
scsi0: Dumping Card State in Message-in phase, at SEQADDR 0x1b6
ACCUM = 0x0, SINDEX = 0x31, DINDEX = 0xc0, ARG_2 = 0xf
HCNT = 0x0 SCBPTR = 0xf
SCSISEQ = 0x12, SBLKCTL = 0x2
 DFCNTRL = 0x4, DFSTATUS = 0x6d
LASTPHASE = 0xe0, SCSISIGI = 0xe6, SXFRCTL0 = 0x88
SSTAT0 = 0x7, SSTAT1 = 0x3
STACK == 0x190, 0x160, 0xe4, 0x13b
SCB count = 68
Kernel NEXTQSCB = 62
Card NEXTQSCB = 62
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 12:1 
QOUTFIFO entries: 
Sequencer Free SCB List: 15 0 8 5 10 3 6 2 13 9 11 7 1 14 4 
Sequencer SCB Info: 0(c 0x68, s 0x27, l 0, t 0xff) 1(c 0x68, s 0x7, l 0, t 0xff) 2(c 0x68, s 0x7, l 0, t 0xff) 3(c 0x68, s 0x7, l 0, t
 0xff) 4(c 0x68, s 0x7, l 0, t 0xff) 5(c 0x68, s 0x27, l 0, t 0xff) 6(c 0x68, s 0x7, l 0, t 0xff) 7(c 0x68, s 0x7, l 0, t 0xff) 8(c 0x68, s 0x27, l 0, t 0xff) 9(c 0x
68, s 0x7, l 0, t 0xff) 10(c 0x68, s 0x7, l 0, t 0xff) 11(c 0x68, s 0x7, l 0, t 0xff) 12(c 0x6c, s 0x27, l 0, t 0x1) 13(c 0x68, s 0x7, l 0, t 0xff) 14(c 0x68, s 0x7,
 l 0, t 0xff) 15(c 0x68, s 0x27, l 0, t 0xff) 
Pending list: 1(c 0x68, s 0x27, l 0)
Kernel Free SCB list: 48 30 57 31 13 15 24 11 58 26 49 22 60 59 43 23 38 51 36 19 41 46 61 21 63 3 17 14 34 0 20 55 53 42 2 10 12 8 28
 6 9 56 5 54 44 47 27 16 32 52 50 45 67 35 18 7 39 25 4 40 29 37 33 66 65 64 
DevQ(0:0:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:4:0): 0 waiting
scsi0: Bus Device Reset on A:2. 1 SCBs aborted

-- 
Matthias Andree

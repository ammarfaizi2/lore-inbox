Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263074AbSJBMev>; Wed, 2 Oct 2002 08:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263075AbSJBMev>; Wed, 2 Oct 2002 08:34:51 -0400
Received: from mailsrv1.sweco.se ([194.16.71.76]:48009 "EHLO
	es-sth-002.sweco.se") by vger.kernel.org with ESMTP
	id <S263074AbSJBMeu>; Wed, 2 Oct 2002 08:34:50 -0400
Message-ID: <E50A0EFD91DBD211B9E40008C75B6CCA01497EDD@ES-STH-012>
From: Eriksson Stig <stig.eriksson@sweco.se>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: aic7xxx problems?
Date: Wed, 2 Oct 2002 14:40:05 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Maybe You can help me out with this one...
I have hp DLT connected to an adaptec SCSI board.

This is a part of dmesg output:
   scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
           <Adaptec (Compaq OEM) 3960D Ultra160 SCSI adapter>
           aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

   scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
           <Adaptec (Compaq OEM) 3960D Ultra160 SCSI adapter>
           aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

     Vendor: BNCHMARK  Model: DLT1              Rev: 5032
     Type:   Sequential-Access                  ANSI SCSI revision: 02

The "BNCHMARK DLT1" is actually a hp DLT.
When rewinding this tape, using "mt -f /dev/nst0 rewind" with a reasonable
amount of data on the tape (~2 Gigs), i get the following in
/var/log/messages:

Sep  9 14:01:21 lack kernel: scsi1:0:5:0: Attempting to queue an ABORT
message
Sep  9 14:01:21 lack kernel: scsi1: Dumping Card State in Command phase, at
SEQADDR 0x168
Sep  9 14:01:21 lack kernel: ACCUM = 0x80, SINDEX = 0xa0, DINDEX = 0xe4,
ARG_2 = 0x0
Sep  9 14:01:21 lack kernel: HCNT = 0x0 SCBPTR = 0x0
Sep  9 14:01:21 lack kernel: SCSISEQ = 0x12, SBLKCTL = 0x6
Sep  9 14:01:21 lack kernel:  DFCNTRL = 0x4, DFSTATUS = 0x89
Sep  9 14:01:21 lack kernel: LASTPHASE = 0x80, SCSISIGI = 0x84, SXFRCTL0 =
0x88
Sep  9 14:01:21 lack kernel: SSTAT0 = 0x7, SSTAT1 = 0x0
Sep  9 14:01:21 lack kernel: SCSIPHASE = 0x0
Sep  9 14:01:21 lack kernel: STACK == 0x175, 0x160, 0xe7, 0x34
Sep  9 14:01:21 lack kernel: SCB count = 4
Sep  9 14:01:21 lack kernel: Kernel NEXTQSCB = 3
Sep  9 14:01:21 lack kernel: Card NEXTQSCB = 3
Sep  9 14:01:21 lack kernel: QINFIFO entries:
Sep  9 14:01:21 lack kernel: Waiting Queue entries:
Sep  9 14:01:21 lack kernel: Disconnected Queue entries:
Sep  9 14:01:21 lack kernel: QOUTFIFO entries:
Sep  9 14:01:21 lack kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10
11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Sep  9 14:01:22 lack kernel: Sequencer SCB Info: 0(c 0x40, s 0x57, l 0, t
0x2) 1(c 0x0, s 0x7f, l 223, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c
0x0, s 0x7f, l 239, t 0xff) 4(c 0x0, s 0x0, l 0, t 0xff) 5(c 0x0, s 0x77, l
255, t 0xff) 6(c 0x0, s 0xfd, l 253, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff)
8(c 0x0, s 0x5f, l 190, t 0xff) 9(c 0x0, s 0xff, l 111, t 0xff) 10(c 0x0, s
0xb6, l 59, t 0xff) 11(c 0x0, s 0xdf, l 223, t 0xff) 12(c 0x0, s 0xff, l
254, t 0xff) 13(c 0x0, s 0xff, l 222, t 0xff) 14(c 0x0, s 0xfd, l 109, t
0xff) 15(c 0x0, s 0xe7, l 239, t 0xff) 16(c 0x0, s 0xd6, l 253, t 0xff) 17(c
0x0, s 0xfe, l 238, t 0xff) 18(c 0x0, s 0xe7, l 253, t 0xff) 19(c 0x0, s
0xff, l 127, t 0xff) 20(c 0x0, s 0x75, l 227, t 0xff) 21(c 0x0, s 0x5f, l
239, t 0xff) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0x3f, l 255, t
0xff) 24(c 0x0, s 0xf6, l 127, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c
0x0, s 0x3f, l 247, t 0xff) 27(c 0x0, s 0xf3, l 255, t 0xff) 28(c 0x0, s
0xef, l 255, t 0xff) 29(c 0x0, s 0xff, l 254, t 0xff) 3
Sep  9 14:01:22 lack kernel: (c 0x0, s 0xf6, l 221, t 0xff) 31(c 0x0, s
0xff, l 255, t 0xff)
Sep  9 14:01:22 lack kernel: Pending list: 2(c 0x40, s 0x57, l 0)
Sep  9 14:01:22 lack kernel: Kernel Free SCB list: 1 0
Sep  9 14:01:22 lack kernel: Untagged Q(5): 2
Sep  9 14:01:22 lack kernel: DevQ(0:5:0): 0 waiting
Sep  9 14:01:22 lack kernel: scsi1:0:5:0: Device is active, asserting ATN
Sep  9 14:01:22 lack kernel: Recovery code sleeping
Sep  9 14:01:22 lack kernel: (scsi1:A:5:0): Abort Message Sent
Sep  9 14:01:22 lack kernel: (scsi1:A:5:0): SCB 2 - Abort Completed.
Sep  9 14:01:22 lack kernel: Recovery SCB completes
Sep  9 14:01:22 lack kernel: Recovery code awake
Sep  9 14:01:22 lack kernel: aic7xxx_abort returns 0x2002

This does not happen with small amount of data on the tape, only when
rewind takes a *long* time

Best Regards
--
Stig Eriksson                    email: se@cactus.se
Cactus Automation AB             phone: +46 31 86 97 10
Krokslätts Fabriker 30           fax:   +46 31 86 97 24
431 37  Mölndal                  http:  www.cactus.se
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTJIUdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbTJIUdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:33:24 -0400
Received: from [137.246.113.151] ([137.246.113.151]:25357 "HELO
	usufexch.ad.jfcom.mil") by vger.kernel.org with SMTP
	id S262529AbTJIUdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:33:11 -0400
Message-ID: <4BA1F7C9E2433F428CB0C9C1FA6DCB19018BCFE4@usufexch.ad.jfcom.mil>
From: "Hughes, Tim M CONT" <hughes@jwfc.jfcom.mil>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Red Hat 7.3 - kernel and st driver
Date: Thu, 9 Oct 2003 16:33:10 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got a Compaq (HP) DL380G2 running RH7.3 with an Adaptec2940 card in it,
with an HP LTO tape drive.  It was running the default kernel (2.4.18-3smp)
on it until recently.  I've always had problems with the attached tape
drive.  After a reboot I would have to run "/sbin/modprobe
scsi_hostadapter1" to get it to find the tape drive and add it as a device.
It would stop working at random, where I couldnt issue any mt or dump
commands.  The logs would indicate:

Sep 29 11:24:51 diesel kernel: st: Version 20020205, bufsize 32768, wrt
30720, max init. bufs 4, s/g segs 16
Sep 29 11:24:51 diesel kernel: Attached scsi tape st0 at scsi0, channel 0,
id 4, lun 0
Sep 29 11:24:51 diesel kernel: (scsi0:A:4): 20.000MB/s transfers (10.000MHz,
offset 8, 16bit)
Sep 29 11:24:51 diesel kernel: st0: Block limits 1 - 16777215 bytes.
Sep 29 11:25:16 diesel root: root logged on
Sep 29 11:39:51 diesel kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Sep 29 11:39:51 diesel kernel: scsi0: Dumping Card State while idle, at
SEQADDR0x7
Sep 29 11:39:51 diesel kernel: ACCUM = 0x14, SINDEX = 0x47, DINDEX = 0x25,
ARG_2 = 0x0
Sep 29 11:39:51 diesel kernel: HCNT = 0x0 SCBPTR = 0x0
Sep 29 11:39:51 diesel kernel: SCSISEQ = 0x12, SBLKCTL = 0x2
Sep 29 11:39:51 diesel kernel:  DFCNTRL = 0x0, DFSTATUS = 0x2d
Sep 29 11:39:51 diesel kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 =
0x80
Sep 29 11:39:51 diesel kernel: SSTAT0 = 0x5, SSTAT1 = 0xa
Sep 29 11:39:51 diesel kernel: STACK == 0x3, 0x190, 0x160, 0x0
Sep 29 11:39:51 diesel kernel: SCB count = 4
Sep 29 11:39:51 diesel kernel: Kernel NEXTQSCB = 2
Sep 29 11:39:51 diesel kernel: Card NEXTQSCB = 2
Sep 29 11:39:51 diesel kernel: QINFIFO entries:
Sep 29 11:39:51 diesel kernel: Waiting Queue entries:
Sep 29 11:39:51 diesel kernel: Disconnected Queue entries: 0:3
Sep 29 11:39:51 diesel kernel: QOUTFIFO entries:
Sep 29 11:39:51 diesel kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10
1112 13 14 15
Sep 29 11:39:51 diesel kernel: Sequencer SCB Info: 0(c 0x44, s 0x47, l 0, t
0x3)
 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0x0, l 0, t 0xff) 3(c 0x0, s
0xff, l
 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t
0xff) 6(
c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s
0xff, l
 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t
0xff) 1
1(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s
0xf
f, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255,
t 0xff)
Sep 29 11:39:51 diesel kernel: Pending list: 3(c 0x40, s 0x47, l 0)
Sep 29 11:39:51 diesel kernel: Kernel Free SCB list: 1 0
Sep 29 11:39:51 diesel kernel: Untagged Q(4): 3
Sep 29 11:39:51 diesel kernel: DevQ(0:4:0): 0 waiting
Sep 29 11:39:51 diesel kernel: (scsi0:A:4:0): Queuing a recovery SCB
Sep 29 11:39:51 diesel kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Sep 29 11:39:51 diesel kernel: Recovery code sleeping
Sep 29 11:39:51 diesel kernel: (scsi0:A:4:0): Abort Message Sent
Sep 29 11:39:51 diesel kernel: (scsi0:A:4:0): SCB 3 - Abort Completed.
Sep 29 11:39:51 diesel kernel: Recovery SCB completes
Sep 29 11:39:51 diesel kernel: Recovery code awake
Sep 29 11:39:51 diesel kernel: aic7xxx_abort returns 0x2002
Sep 29 11:54:51 diesel kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Sep 29 11:54:51 diesel kernel: scsi0: Dumping Card State while idle, at
SEQADDR0x8
Sep 29 11:54:51 diesel kernel: ACCUM = 0x17, SINDEX = 0x47, DINDEX = 0x25,
ARG_2 = 0x0
Sep 29 11:54:51 diesel kernel: HCNT = 0x0 SCBPTR = 0x0
Sep 29 11:54:51 diesel kernel: SCSISEQ = 0x12, SBLKCTL = 0x2
Sep 29 11:54:51 diesel kernel:  DFCNTRL = 0x0, DFSTATUS = 0x2d
Sep 29 11:54:51 diesel kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 =
0x80
Sep 29 11:54:51 diesel kernel: SSTAT0 = 0x5, SSTAT1 = 0xa
Sep 29 11:54:51 diesel kernel: STACK == 0x3, 0x190, 0x160, 0xe4
Sep 29 11:54:51 diesel kernel: SCB count = 4
Sep 29 11:54:51 diesel kernel: Kernel NEXTQSCB = 2
Sep 29 11:54:51 diesel kernel: Card NEXTQSCB = 2

It would repeat this indefinitely until reboot.  I found a bug posting under
Red Hat 8 (79027) that talked about problems with the older kernels so I
went and pulled the latest 7.3 kernel (2.4.20-20.7smp) and installed.
Initially, things seem to be going well.  For the first time, the OS picked
up the drive(r) and installed it.

Oct  6 16:12:41 diesel kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.2.8
Oct  6 16:12:41 diesel kernel:         <Adaptec 2940 Ultra SCSI adapter>
Oct  6 16:12:41 diesel kernel:         aic7880: Ultra Wide Channel A, SCSI
Id=7, 16/253 SCBs
Oct  6 16:12:41 diesel kernel:
Oct  6 16:12:41 diesel kernel: blk: queue c4840618, I/O limit 4095Mb (mask
0xffffffff)
Oct  6 16:12:41 diesel kernel:   Vendor: HP        Model: Ultrium 1-SCSI
Rev: E22D
Oct  6 16:12:41 diesel kernel:   Type:   Sequential-Access
ANSI SCSI revision: 03

I used mt to eject the tape a few times and considered the matter resolved.
Now I appear to be back to where I started... here is another snip from the
logs:

Oct  6 23:16:10 diesel kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Oct  6 23:16:10 diesel kernel: scsi0: Dumping Card State in Command phase,
at SEQADDR 0x166
Oct  6 23:16:10 diesel kernel: ACCUM = 0x80, SINDEX = 0xac, DINDEX = 0xc0,
ARG_2 = 0x0
Oct  6 23:16:10 diesel kernel: HCNT = 0x0 SCBPTR = 0x0
Oct  6 23:16:10 diesel kernel: SCSISEQ = 0x12, SBLKCTL = 0x2
Oct  6 23:16:10 diesel kernel:  DFCNTRL = 0x4, DFSTATUS = 0x6d
Oct  6 23:16:10 diesel kernel: LASTPHASE = 0x80, SCSISIGI = 0x84, SXFRCTL0 =
0x88
Oct  6 23:16:10 diesel kernel: SSTAT0 = 0x7, SSTAT1 = 0x2
Oct  6 23:16:10 diesel kernel: STACK == 0x190, 0x160, 0x0, 0x37
Oct  6 23:16:10 diesel kernel: SCB count = 4
Oct  6 23:16:10 diesel kernel: Kernel NEXTQSCB = 3
Oct  6 23:16:10 diesel kernel: Card NEXTQSCB = 3
Oct  6 23:16:10 diesel kernel: QINFIFO entries:
Oct  6 23:16:10 diesel kernel: Waiting Queue entries:
Oct  6 23:16:10 diesel kernel: Disconnected Queue entries:
Oct  6 23:16:10 diesel kernel: QOUTFIFO entries:
Oct  6 23:16:10 diesel kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10
1112 13 14 15
Oct  6 23:16:10 diesel kernel: Sequencer SCB Info: 0(c 0x0, s 0x47, l 0, t
0x2)
1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s
0xff,
 l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t
0xff)
6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s
0xff,
 l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t
0xff)
 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0,
s 0
xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l
255, t0xff)
Oct  6 23:16:10 diesel kernel: Pending list: 2(c 0x0, s 0x47, l 0)
Oct  6 23:16:10 diesel kernel: Kernel Free SCB list: 1 0
Oct  6 23:16:10 diesel kernel: Untagged Q(4): 2
Oct  6 23:16:10 diesel kernel: DevQ(0:4:0): 0 waiting
Oct  6 23:16:10 diesel kernel: scsi0:0:4:0: Device is active, asserting ATN
Oct  6 23:16:10 diesel kernel: Recovery code sleeping
Oct  6 23:16:15 diesel kernel: Recovery code awake
Oct  6 23:16:15 diesel kernel: Timer Expired
Oct  6 23:16:15 diesel kernel: aic7xxx_abort returns 0x2003
Oct  6 23:16:15 diesel kernel: scsi0:0:4:0: Attempting to queue a TARGET
RESET message
Oct  6 23:16:15 diesel kernel: aic7xxx_dev_reset returns 0x2003
Oct  6 23:16:15 diesel kernel: Recovery SCB completes
Oct  6 23:31:20 diesel kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Oct  6 23:31:20 diesel kernel: scsi0: Dumping Card State in Message-in
phase, at SEQADDR 0x166
Oct  6 23:31:20 diesel kernel: ACCUM = 0x0, SINDEX = 0x47, DINDEX = 0x25,
ARG_2= 0xff
Oct  6 23:31:20 diesel kernel: HCNT = 0x0 SCBPTR = 0x0
Oct  6 23:31:20 diesel kernel: SCSISEQ = 0x12, SBLKCTL = 0x2
Oct  6 23:31:20 diesel kernel:  DFCNTRL = 0x0, DFSTATUS = 0x2d
Oct  6 23:31:20 diesel kernel: LASTPHASE = 0xe0, SCSISIGI = 0xe4, SXFRCTL0 =
0x88
Oct  6 23:31:20 diesel kernel: SSTAT0 = 0x5, SSTAT1 = 0x2
Oct  6 23:31:20 diesel kernel: STACK == 0x190, 0x160, 0x37, 0x37
Oct  6 23:31:20 diesel kernel: SCB count = 4
Oct  6 23:31:20 diesel kernel: Kernel NEXTQSCB = 2
Oct  6 23:31:20 diesel kernel: Card NEXTQSCB = 2
Oct  6 23:31:20 diesel kernel: QINFIFO entries:
Oct  6 23:31:20 diesel kernel: Waiting Queue entries:
Oct  6 23:31:20 diesel kernel: Disconnected Queue entries:
Oct  6 23:31:20 diesel kernel: QOUTFIFO entries:
Oct  6 23:31:20 diesel kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10
11 12 13 14 15
Oct  6 23:31:20 diesel kernel: Sequencer SCB Info: 0(c 0x40, s 0x47, l 0, t
0x3)
 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s
0xff
, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t
0xff)
 6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s
0xff
, l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t
0xff
) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c
0x0, s
0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l
255, t 0xff)
Oct  6 23:31:20 diesel kernel: Pending list: 3(c 0x40, s 0x47, l 0)
Oct  6 23:31:20 diesel kernel: Kernel Free SCB list: 1 0
Oct  6 23:31:20 diesel kernel: Untagged Q(4): 3
Oct  6 23:31:20 diesel kernel: DevQ(0:4:0): 0 waiting
Oct  6 23:31:20 diesel kernel: scsi0:0:4:0: Device is active, asserting ATN
Oct  6 23:31:20 diesel kernel: Recovery code sleeping
Oct  6 23:31:20 diesel kernel: Recovery code awake
Oct  6 23:31:20 diesel kernel: aic7xxx_abort returns 0x2002
Oct  6 23:31:20 diesel kernel: scsi: device set offline - not ready or
command retry failed after bus reset: host 0 channel 0 id 4 lun 0
Oct  6 23:31:20 diesel kernel: st0: Error 3f0000 (sugg. bt 0x0, driver bt
0x0, host bt 0x3f).
Oct  6 23:46:20 diesel kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Oct  6 23:46:20 diesel kernel: scsi0:0:4:0: Command found on device queue
Oct  6 23:46:20 diesel kernel: aic7xxx_abort returns 0x2002
Oct  6 23:46:30 diesel kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Oct  6 23:46:30 diesel kernel: scsi0:0:4:0: Command found on device queue
Oct  6 23:46:30 diesel kernel: aic7xxx_abort returns 0x2002
Oct  6 23:46:30 diesel kernel: scsi0:0:4:0: Attempting to queue a TARGET
RESET message
Oct  6 23:46:30 diesel kernel: aic7xxx_dev_reset returns 0x2003
Oct  6 23:46:30 diesel kernel: Recovery SCB completes
Oct  7 00:01:35 diesel kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Oct  7 00:01:35 diesel kernel: scsi0: Dumping Card State while idle, at
SEQADDR0x7

Any help or suggestions is appreciated.  Thanks

 Tim



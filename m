Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSHFThe>; Tue, 6 Aug 2002 15:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSHFThe>; Tue, 6 Aug 2002 15:37:34 -0400
Received: from valaran.com ([66.153.38.244]:23023 "HELO mail.valaran.com")
	by vger.kernel.org with SMTP id <S315414AbSHFThd>;
	Tue, 6 Aug 2002 15:37:33 -0400
From: "Keith Warno" <keith.warno@valaran.com>
To: "lkml \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: 2.4.19 SCSI whoas.
Date: Tue, 6 Aug 2002 15:41:39 -0400
Message-ID: <001b01c23d81$497b2d40$8806a8c0@kwvaio>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.  I've poked around in the lkml archives with little luck re:
these issues so bear with me.

On an x86 system with:
abit kt7a mobo
(256*5)MB RAM
Adaptec 29160 controller
  - Seagate ST336704LVC 34GB disk (LVD & running at 160MB/s)
  - Yamaha CDW8424S (attached via 68pin Wide internal cable, running 20MB/s)
2 IDE disks (one UDMA33, another UDMA66, on the same ide channel, both with
dma enabled)
1 IDE DVDROM/CDRW as secondary master, using the kernel's ide-scsi driver.

I've started seeing the following kernel message over and over:
Warning - running *really* short on DMA buffers

which is emitted by drivers/scsu/scsi_merge.c:882

Why?  This is my question.  :)  It seems to happen when there's a lot of
activity on the SCSI disk, ie, when generating ISO images via mkisofs.  The
call to scsi_malloc() on drivers/scsu/scsi_merge.c:872 appears to fail but I
haven't a clue why.

In addition to this DMA message, I often see the following:
scsi0: PCI error Interrupt at seqaddr = 0x9
scsi0: Data Parity Error Detected during address or write data phase

The 'seqaddr' varies; it's most frequently 0x8 or 0x9.  This message pops
up, it appears, when there is a lot of IDE disk activity.  This has been
showing up since 2.4.16 or so.

Yes, SCSI termination is as it should be.  I've also tried 3 different 29160
cards (various BIOS versions), 3 different LVD cables, 2 different 68pin
wide cables, all whilst bouncing the card around to different PCI slots.
The 29160 is the only device on irq 11.

ANy and all useful feedback will be much appreciated.

Regards,
kw.


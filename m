Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289367AbSAJKDs>; Thu, 10 Jan 2002 05:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289368AbSAJKDj>; Thu, 10 Jan 2002 05:03:39 -0500
Received: from linux2.viasys.com ([194.100.28.129]:33293 "HELO mail.viasys.com")
	by vger.kernel.org with SMTP id <S289367AbSAJKDa>;
	Thu, 10 Jan 2002 05:03:30 -0500
Message-ID: <003001c199be$0a4981b0$b71c64c2@viasys.com>
From: "Jani Forssell" <jani.forssell@viasys.com>
To: <alan@lxorguk.ukuu.org.uk>
Cc: "Ville Herva" <ville.herva@viasys.com>, <linux-kernel@vger.kernel.org>
Subject: 2.2.21pre2 VIA IDE lockup during boot
Date: Thu, 10 Jan 2002 12:03:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a Abit KT7 raid with all the drives attached to the onboard VIA IDE
controller. It gets stuck during boot with 2.2.21pre2, but works with
2.4.18pre2. Here's a bit of the boot sequence:
[snip]
hda: Samsung SV8004H, ATA DISK drive
hdb: CDROM 52X/AKH, ATAPI CDROM drive
hdc:  Samsung SV8004H, ATA DISK drive
ide0: ...
ide1: ...
[stops here]

And it doesn't get past this point. SysRq->ShowPc shows this:

EIP 0010:[<c0109b1c>] EFLAGS: 00000202
EAX: 000001C0 EBX: 0000000e ECX: 0000000e EDX: c024c000
ESI: 0000000e EDI: c026f2e0 EBP: c026f2a0 DS: 0018 ES: 0018
CR0: 8005003b CR2: 00000000 CR3: 00101000

According to System.map, c0109b1c would be in disable_irq().

c0109ab8 T disable_irq_nosync
c0109af8 T disable_irq
c0109b24 T enable_irq

Some combinations do work, however:

-Both HDDs on channel 0 (hda, hdb) (works)
-Both HDDs on channel 0 (hda, hdb) and CDROM on channel 1 (hdc) (works)
-Both HDDs on different channels (hda, hdc) (works)

lspci:

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 03)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev
03)

---
Jani Forssell
jani.forssell@viasys.com


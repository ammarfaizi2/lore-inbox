Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136807AbRA1HgU>; Sun, 28 Jan 2001 02:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136527AbRA1HgL>; Sun, 28 Jan 2001 02:36:11 -0500
Received: from smtp-server.maine.rr.com ([204.210.65.66]:60298 "HELO
	smtp-server.maine.rr.com") by vger.kernel.org with SMTP
	id <S136544AbRA1Hfz>; Sun, 28 Jan 2001 02:35:55 -0500
Message-ID: <003f01c088fb$a35c06e0$b001a8c0@caesar>
From: "paradox3" <paradox3@maine.rr.com>
To: <linux-kernel@vger.kernel.org>, <linux-smp@vger.kernel.org>
Subject: Poor SCSI drive performance on SMP machine, 2.2.16
Date: Sun, 28 Jan 2001 02:26:32 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003C_01C088D1.BA4BDC10"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_003C_01C088D1.BA4BDC10
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I have an SMP machine (dual PII 400s) running 2.2.16 with one 10,000 RPM IBM
10 GB SCSI drive
(AIC 7890 on motherboard, using aic7xxx.o), and four various IDE drives. The
SCSI drive
performs the worst. In tests of writing 100 MB and sync'ing, one of my IDE
drives takes 31 seconds. The SCSI drive (while doing nothing else) took
2 minutes, 10 seconds. This is extremely noticable in file transfers that
completely
monopolize the SCSI drive, and are much slower than when involving the IDE
drives.
After a large data operation on the SCSI drive, the system will hang for
several minutes.
Anyone know what could be causing this? Thanks.

Attached are some data to help.


Thanks,
    Para-dox (paradox3@maine.rr.com)


------=_NextPart_000_003C_01C088D1.BA4BDC10
Content-Type: text/plain;
	name="interrupts.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="interrupts.txt"

           CPU0       CPU1       =0A=
  0:   43661720   59171710    IO-APIC-edge  timer=0A=
  1:     233992     282694    IO-APIC-edge  keyboard=0A=
  2:          0          0          XT-PIC  cascade=0A=
  8:          1          0    IO-APIC-edge  rtc=0A=
 13:          1          0          XT-PIC  fpu=0A=
 14:         20         10    IO-APIC-edge  ide0=0A=
 15:   46455293   50354306    IO-APIC-edge  ide1=0A=
 16:   14508949   14462778   IO-APIC-level  eth0=0A=
 17:    3939554    4293901   IO-APIC-level  eth1=0A=
 18:     750747     761816   IO-APIC-level  aic7xxx=0A=
NMI:          0=0A=
ERR:          0=0A=

------=_NextPart_000_003C_01C088D1.BA4BDC10
Content-Type: text/plain;
	name="pci.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pci.txt"

PCI devices found:=0A=
  Bus  0, device   0, function  0:=0A=
    Host bridge: Intel 440BX - 82443BX Host (rev 2).=0A=
      Medium devsel.  Master Capable.  Latency=3D64.  =0A=
      Prefetchable 32 bit memory at 0xe8000000 [0xe8000008].=0A=
  Bus  0, device   1, function  0:=0A=
    PCI bridge: Intel 440BX - 82443BX AGP (rev 2).=0A=
      Medium devsel.  Master Capable.  Latency=3D64.  Min Gnt=3D136.=0A=
  Bus  0, device   7, function  0:=0A=
    ISA bridge: Intel 82371AB PIIX4 ISA (rev 2).=0A=
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No =
bursts.  =0A=
  Bus  0, device   7, function  1:=0A=
    IDE interface: Intel 82371AB PIIX4 IDE (rev 1).=0A=
      Medium devsel.  Fast back-to-back capable.  Master Capable.  =
Latency=3D64.  =0A=
      I/O at 0xf000 [0xf001].=0A=
  Bus  0, device   7, function  2:=0A=
    USB Controller: Intel 82371AB PIIX4 USB (rev 1).=0A=
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master =
Capable.  Latency=3D64.  =0A=
      I/O at 0xe000 [0xe001].=0A=
  Bus  0, device   7, function  3:=0A=
    Bridge: Intel 82371AB PIIX4 ACPI (rev 2).=0A=
      Medium devsel.  Fast back-to-back capable.  =0A=
  Bus  0, device   8, function  0:=0A=
    Ethernet controller: Intel 82557 (rev 5).=0A=
      Medium devsel.  Fast back-to-back capable.  IRQ 16.  Master =
Capable.  Latency=3D64.  Min Gnt=3D8.Max Lat=3D56.=0A=
      Prefetchable 32 bit memory at 0xef101000 [0xef101008].=0A=
      I/O at 0xe400 [0xe401].=0A=
      Non-prefetchable 32 bit memory at 0xef000000 [0xef000000].=0A=
  Bus  0, device   9, function  0:=0A=
    Ethernet controller: Winbond NE2000-PCI (rev 0).=0A=
      Medium devsel.  Fast back-to-back capable.  IRQ 17.  =0A=
      I/O at 0xe800 [0xe801].=0A=
  Bus  0, device  12, function  0:=0A=
    SCSI storage controller: Adaptec AIC-7890/1 (rev 0).=0A=
      Medium devsel.  Fast back-to-back capable.  BIST capable.  IRQ 18. =
 Master Capable.  Latency=3D64.  Min Gnt=3D39.Max Lat=3D25.=0A=
      I/O at 0xec00 [0xec01].=0A=
      Non-prefetchable 64 bit memory at 0xef100000 [0xef100004].=0A=
  Bus  1, device   0, function  0:=0A=
    VGA compatible controller: S3 Inc. ViRGE/GX2 (rev 6).=0A=
      Medium devsel.  IRQ 16.  Master Capable.  Latency=3D64.  Min =
Gnt=3D4.Max Lat=3D255.=0A=
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe0000000].=0A=

------=_NextPart_000_003C_01C088D1.BA4BDC10--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

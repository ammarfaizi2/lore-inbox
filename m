Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUBPGoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 01:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbUBPGoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 01:44:00 -0500
Received: from imap.gmx.net ([213.165.64.20]:53184 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265373AbUBPGnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 01:43:53 -0500
Date: Mon, 16 Feb 2004 07:43:52 +0100 (MET)
From: "M. Grabert" <deadbeef@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: siimage (big-endian?) problems using 2.6.3-rc1
X-Priority: 3 (Normal)
X-Authenticated: #5689615
Message-ID: <3232.1076913832@www45.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for posting this to the lkml; I already posted this
to the linux-ide mailing list and to the maintainer of the
Silicon-Image driver, but I haven't gotten any response yet.


I'm having troubles getting a (rather new) SiliconImage PCI IDE
controller working on Linux/PA-RISC. It seems to be big-endian related.

The original/full error report can be found
here:
http://lists.parisc-linux.org/pipermail/parisc-linux/2003-December/021839.html

Alan Cox suggested that the bug(s) may be hidden in the siimage driver,
rather than in the PA-RISC specific bits and I should contact the
siimage/linux-IDE people.


A short summary:
================
This is on a HP9000/785 C3000 running Debian/testing, using a
no-name Silicon-Image PCI IDE controller and a Segate ST3120022A hard disk.

- 2.4.23 (with and without ide=nodma passed as kernel options) produces
  'hda lost interrupt' messages; /dev/hda is not accessible (read errors)

- 2.6.0-test11 creates a kernel ooops ('Your system ate a SPARC'),
  passing ide=nodma doesn't change anything

- 2.6.2-rc1 seems to be a bit better, but stops booting with the following
  message:


=== SNIP ===

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI680: IDE controller at PCI slot 0000:01:06.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 128
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hda: TS130220A2, ATA DISK drive
     ^^^^^^^^^^

Using anticipatory io scheduler
ide0 at 0xf4800080-0xf4800087,0xf480008a on irq 128
hda: max request size: 64KiB
hda: 0 sectors (0 MB) w/8KiB Cache, CHS=65343/0/0
hda: INVALID GEOMETRY: 0 PHYSICAL HEADS?
ide-default: hda: Failed to register the driver with ide.c
Kernel panic: ide: default attach failed

=== SNAP ===


A 2.4.23 kernel using the (crappy but working) onboard NS87415 IDE
controller of the PA-RISC workstation identifies the Seagate hard disk
correctly as:

 hda: ST3120022A, ATA DISK drive
      ^^^^^^^^^^
 hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=14593/255/63,
(U)DMA
 Partition check:
   hda: hda1



The full bootlogs/.config/System.maps can be found here:
http://www.cs.ucc.ie/~xam/siimage/

Please CC answers/comments to me personally, since I'm not subscribed to
the lkml!


Thanks alot in advance for any help,
  Max

-- 
GMX ProMail (250 MB Mailbox, 50 FreeSMS, Virenschutz, 2,99 EUR/Monat...)
jetzt 3 Monate GRATIS + 3x DER SPIEGEL +++ http://www.gmx.net/derspiegel +++


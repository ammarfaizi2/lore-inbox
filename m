Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbTJET6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTJET6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:58:23 -0400
Received: from play.smurf.noris.de ([192.109.102.42]:45486 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S263837AbTJET6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:58:14 -0400
From: Matthias Urlichs <smurf@smurf.noris.de>
Organization: {M:U} IT Consulting
Subject: PROBLEM (2.6.0-test6): loading cmd64x as module messes up primary IDE
Date: Sun, 05 Oct 2003 16:29:20 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Message-Id: <pan.2003.10.05.14.29.20.212009@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
X-Pan-Internal-Post-Server: smurf
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: recipient list not shown:;
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an SMP mainboard with two "standard" IDE controllers and a cmd649
as secondary interface. After booting, the kernel only sees the mainboard
interfaces, but that's what modules are for.

However, it is impossible to load the cmd64x module to access the second
interface because it apparently tries to re-acquire the primary IDE, which
is already claimed by the standard IDE driver. After this, access to
hda..hdd is impossible.

lspci:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:08.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
00:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 26)
00:0a.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
00:0c.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 64)
01:00.0 VGA compatible controller: nVidia Corporation NV4 [RIVA TNT] (rev 04)

(Note: No nVidia module was loaded.)

Kernel messages after inserting cmd64x (note that ide0+1 and hda..hdd are
already in use; I would expect to see ide2+ide3 and hde..hdh here; it also
sees the devices off ide0+ide1, not those actually connected to the cmd649):

<7>bus pci: add driver CMD64x IDE
<6>CMD649: IDE controller at PCI slot 0000:00:08.0
<6>CMD649: chipset revision 2
<6>CMD649: ROM enabled at 0xdf000000
<6>CMD649: 100% native mode on irq 16
<6>    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:pio, hdb:pio
<6>    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:pio, hdd:pio
<4>hda: ST380020A, ATA DISK drive
<6>hdb: ATAPI cdrom (?)
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>register_blkdev: cannot get major 3 for ide0
<4>hdc: WDC WD1000BB-00CHE0, ATA DISK drive
<4>hdd: IC35L100AVVA07-0, ATA DISK drive
<4>register_blkdev: cannot get major 22 for ide1
<4>Module cmd64x cannot be unloaded due to unsafe usage in include/linux/module.h:483
<7>bound device '0000:00:08.0' to driver 'CMD64x IDE'

Hints where to dig / patches are appreciated; I don't know my way round
the 2.6 device layer sufficiently well yet.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
He keeps differentiating, flying off on a tangent.

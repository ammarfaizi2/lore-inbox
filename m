Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318329AbSHEH3q>; Mon, 5 Aug 2002 03:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318330AbSHEH3q>; Mon, 5 Aug 2002 03:29:46 -0400
Received: from abel.math.tsukuba.ac.jp ([130.158.120.16]:19166 "EHLO
	abel.math.tsukuba.ac.jp") by vger.kernel.org with ESMTP
	id <S318329AbSHEH3o>; Mon, 5 Aug 2002 03:29:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Michael Dreher <dreher@math.tsukuba.ac.jp>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Linux 2.4.19-ac3 
Date: Mon, 5 Aug 2002 09:33:33 +0200
X-Mailer: KMail [version 1.3.2]
References: <200208050103.g7513SV20035@devserv.devel.redhat.com>
In-Reply-To: <200208050103.g7513SV20035@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020805073317.5C36113B21@abel.math.tsukuba.ac.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> This patch contains IDE changes. These should hopefully fix some of the ALi
> problem reports and the problems with newer intel BIOSes. If you still have
> IDE hangs please mail me an lspci -v and a list of the attached drives.


It still hangs, right here:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 80
PCI: No IRQ known for interrupt pin A of device 00:10.0. Please try using 
pci=biosirq.
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later

It should continue like this:

    ide0: BM-DMA at 0x2800-0x2807, BIOS settings: hda:DMA, hdb:pio
ALI15X3: simplex device:  DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
hda: IC25N030ATDA04-0, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 58605120 sectors (30006 MB) w/1806KiB Cache, CHS=3648/255/63, UDMA(100)

This is a Vaio Picturebook, PCG-C1MRX.

karpfen:/home/dreher # lspci -v
00:00.0 Host bridge: Transmeta Corporation: Unknown device 0395 (rev 01)
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: bus master, medium devsel, latency 0
        Memory at e8100000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation: Unknown device 0396
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: fast devsel

00:00.2 RAM memory: Transmeta Corporation: Unknown device 0397
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: fast devsel

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]: Unknown 
device 5451 (rev 02)
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at 1400 [size=256]
        Memory at e8014000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV]
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: bus master, medium devsel, latency 0
        Capabilities: [a0] Power Management version 1

00:08.0 Modem: Acer Laboratories Inc. [ALi]: Unknown device 5457 (prog-if 00 
[Generic])
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: medium devsel, IRQ 9
        Memory at e8015000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 1800 [size=256]
        Capabilities: [40] Power Management version 2

00:09.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8021 (rev 02) 
(prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: medium devsel, IRQ 9
        Memory at e8018000 (32-bit, non-prefetchable) [size=2K]
        Memory at e8010000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

00:0a.0 Multimedia controller: Citicorp TTI: Unknown device 2011
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: medium devsel, IRQ 9
        I/O ports at 1c00 [size=256]
        Memory at e8200000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at 2000 [size=256]
        Memory at e8018800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:0c.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c59 
(prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: stepping, medium devsel, IRQ 9
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 2400 [size=256]
        Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] Power Management version 2

00:0f.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) 
(prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at e8016000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) 
(prog-if a0)
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: bus master, medium devsel, latency 64
        I/O ports at 01f0
        I/O ports at 03f4
        I/O ports at 0170
        I/O ports at 0374
        I/O ports at 2800 [size=16]
        Capabilities: [60] Power Management version 2

00:11.0 Non-VGA unclassified device: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: medium devsel

00:12.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: bus master, medium devsel, latency 0, IRQ 9
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) 
(prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 80ec
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at 000e0000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2

karpfen:/home/dreher #


karpfen:/home/dreher # hdparm -i /dev/hda

/dev/hda:

 Model=IC25N030ATDA04-0, FwRev=DA4OA76A, SerialNo=64L64NE7622
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1806kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=58605120
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
 Drive Supports : Reserved : ATA-2 ATA-3 ATA-4 ATA-5
 Kernel Drive Geometry LogicalCHS=3648/255/63 PhysicalCHS=58140/16/63


karpfen:/home/dreher #


If I apply the following patch (by Go Taniguchi and Bruce Howard) on
top of 2.4.19-rc5-ac1, then it works. I also need this patch to get sound
working. Without it, I hear heavy distortions.

If you need more info, just ask.

Regards and Thanks a lot,
Michael






--- linux/drivers/ide/alim15x3.c~       2002-08-03 03:06:10.000000000 +0900
+++ linux/drivers/ide/alim15x3.c        2002-08-03 03:07:15.000000000 +0900
@@ -37,6 +37,7 @@
 static int ali_get_info(char *buffer, char **addr, off_t offset, int count);
 extern int (*ali_display_info)(char *, char **, off_t, int);  /* ide-proc.c 
*/
 static struct pci_dev *bmide_dev;
+static int enable_south = 0;

 char *fifo[4] = {
        "FIFO Off",
@@ -605,6 +606,7 @@
                pci_read_config_byte(dev, 0x4b, &tmpbyte);
                pci_write_config_byte(dev, 0x4b, tmpbyte | 0x08);

+               if( enable_south ){
                /*
                 * set south-bridge's enable bit, m1533, 0x79
                 */
@@ -620,6 +622,7 @@
                         */
                        pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
                }
+               }
        } else {
                /*
                 * revision 0x20 (1543-E, 1543-F)
@@ -671,6 +674,7 @@
                pci_read_config_byte(dev, 0x4b, &tmpbyte);
                pci_write_config_byte(dev, 0x4b, tmpbyte | 0x08);

+               if( enable_south ){
                /*
                 * set south-bridge's enable bit, m1533, 0x79
                 */
@@ -686,6 +690,7 @@
                         */
                        pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
                }
+               }
 #endif /* ALI_INIT_CODE_TEST */
                /*
                 * Ultra66 cable detection (from Host View)
@@ -821,3 +826,13 @@
        ide_setup_pci_device(dev, d);
 }

+static int __init enable_south_setup(char *str)
+{
+/*     printk("ALI15X3: enable_south_setup %d\n", str);        */
+       if(strcmp(str, "enable_south") == 0)
+               enable_south = 1;
+       return 1;
+}
+
+__setup("alim15x3=", enable_south_setup);
+



karpfen:/home/dreher #




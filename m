Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129127AbQKEQsJ>; Sun, 5 Nov 2000 11:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129422AbQKEQsA>; Sun, 5 Nov 2000 11:48:00 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:28676 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129127AbQKEQrq>; Sun, 5 Nov 2000 11:47:46 -0500
Date: Sun, 5 Nov 2000 18:47:36 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: 440FX and DMA on 2.2.18pre18
Message-ID: <20001105184736.J1248@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual Ppro200 with 440FX chipset and an IBM 30GB ide disk. The
kernel is 2.2.18pre18 with no additional patches. DMA appears not to work
with this combination.

lspci:

00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:07.2 USB Controller: Intel Corporation 82371SB PIIX3 USB [Natoma/Triton II] (rev 01)
00:0c.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 02)
00:0d.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II]
00:0e.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871

hdparm -i /dev/hda:

/dev/hda:

 Model=IBM-DTLA-305030, FwRev=TW3OA60A, SerialNo=YG0YG017000
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=380kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=60036480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 

hdparm /dev/hda:

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3737/255/63, sectors = 60036480, start = 0

If I do hdparm -d1; hdparm -tT /dev/hda

hda: timeout waiting for DMA
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
VFS: Disk change detected on device ide0(3,64)
hda: timeout waiting for DMA
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: DMA disabled
ide0: reset: success

On another box with a single PPro200 and 440FX chipset, DMA works just
fine. That box also has IBM disk (30GB) but runs 2.0.37.

Should I try the IDE-patch or suspect the cable? Can anybody confirm that
DMA works with 440FX and a recent 2.2.x?


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

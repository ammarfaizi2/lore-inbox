Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbQKTTh7>; Mon, 20 Nov 2000 14:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbQKTThu>; Mon, 20 Nov 2000 14:37:50 -0500
Received: from cx838204-a.alsv1.occa.home.com ([24.16.83.66]:28145 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129534AbQKTThh>; Mon, 20 Nov 2000 14:37:37 -0500
To: linux-kernel@vger.kernel.org
Subject: ide_dma_timeout w/2.2.16 (redhat) and PIIX3
From: Rupa Schomaker <rupa-list+linux-kernel@rupa.com>
Mail-Copies-To: never
Date: 20 Nov 2000 11:07:55 -0800
Message-ID: <m3bsvatqb8.fsf@localhost.localdomain>
User-Agent: Gnus/5.0805 (Gnus v5.8.5) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got an older HP E40 that I'm having problems getting to work with
DMA turned on.

Specifically, I get the following errors when I do a
"hdparm -d 1 /dev/hda" and the same for hdc.  If I boot into single
user mode I can't seem to generate the problem, but after booting into
multi user mode I can cause all kinds of errors just by doing a bunch
of disk activity.  (Start oracle, copy filesystems, compile kernel,
etc)


I get this with the "standard" Redhat 2.2.16 kernel (that is with
their patches applied).  I also tried applying Andre's IDE patches for
2.2.16 and didn't get any success.

The drives are Maxtor 45G 7200 RPM IDE drives.  I'm using 80pin IDE
cables -- though the PIIX3 only supports DMA, not UDMA.

I was going to get a UDMA controller, but the only one I could find
that seemed to have linux support (Promise) would break when I enabled
DMA.  Figured I'd not bother working on that until I got the base
stuff working.

====

Question about hdparm.  If I enable dma (-d1) and then experience
errors.  I can't seem to just turn off dma support (-d0) and get on
with life.  I continue to get the DMA errors and must reboot to get
into non-dma mode.  Is this correct?

====

Log entries example:

Nov 17 17:57:01 gw kernel: hdc: timeout waiting for DMA 
Nov 17 17:57:01 gw kernel: hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest } 
Nov 17 18:25:28 gw kernel: hda: timeout waiting for DMA 
Nov 17 18:25:28 gw kernel: hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest } 
Nov 17 18:25:38 gw kernel: hda: timeout waiting for DMA 
Nov 17 18:25:38 gw kernel: hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest } 
Nov 17 18:25:48 gw kernel: hda: timeout waiting for DMA 
Nov 17 18:25:48 gw kernel: hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest } 
Nov 17 18:25:58 gw kernel: hda: timeout waiting for DMA 
Nov 17 18:25:58 gw kernel: hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest } 
Nov 17 18:25:58 gw kernel: ide0: reset: success 
Nov 17 18:26:12 gw kernel: hda: timeout waiting for DMA 
Nov 17 18:26:12 gw kernel: hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest } 

====

# hdparm -iI /dev/hda

/dev/hda:

 Model=Maxtor 54610H6, FwRev=JAC61HU0, SerialNo=F605M4KC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes
 LBA CHS=1023/256/63 Remapping, LBA=yes, LBAsects=90045648
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2


 Model=aMtxro5 64016H                          , FwRev=AJ6CH10U, SerialNo=6F504MCK            
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes
 LBA CHS=1023/256/63 Remapping, LBA=yes, LBAsects=90045648
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2

====

>From /proc/pci:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel 82441FX Natoma (rev 2).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.  
  Bus  0, device   4, function  0:
    ISA bridge: Intel 82371SB PIIX3 ISA (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No bursts.  
  Bus  0, device   4, function  1:
    IDE interface: Intel 82371SB PIIX3 IDE (rev 0).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.  
      I/O at 0x500 [0x501].
  Bus  0, device   6, function  0:
    Ethernet controller: Intel 82557 (rev 1).
      Medium devsel.  Fast back-to-back capable.  IRQ 9.  Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Prefetchable 32 bit memory at 0xfecfe000 [0xfecfe008].
      I/O at 0xf8e0 [0xf8e1].
      Non-prefetchable 32 bit memory at 0xfed00000 [0xfed00000].
  Bus  0, device  10, function  0:
    Ethernet controller: Intel 82557 (rev 5).
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Prefetchable 32 bit memory at 0xfecfd000 [0xfecfd008].
      I/O at 0xf8c0 [0xf8c1].
      Non-prefetchable 32 bit memory at 0xfeb00000 [0xfeb00000].
  Bus  0, device   7, function  0:
    SCSI storage controller: Adaptec AIC-7850 (rev 1).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  Latency=64.  Min Gnt=4.Max Lat=4.
      I/O at 0xfc00 [0xfc01].
      Non-prefetchable 32 bit memory at 0xfecff000 [0xfecff000].
  Bus  0, device  13, function  0:
    VGA compatible controller: Cirrus Logic GD 5446 (rev 0).
      Medium devsel.  
      Prefetchable 32 bit memory at 0xfd000000 [0xfd000008].

-- 
-rupa
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLAS6L>; Fri, 1 Dec 2000 13:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129437AbQLAS6B>; Fri, 1 Dec 2000 13:58:01 -0500
Received: from corinto.argo.es ([195.53.30.2]:49379 "EHLO corinto.argo.es")
	by vger.kernel.org with ESMTP id <S129340AbQLAS5v>;
	Fri, 1 Dec 2000 13:57:51 -0500
Message-ID: <3A27EE7A.549543D5@argo.es>
Date: Fri, 01 Dec 2000 19:31:22 +0100
From: Jesus Cea Avion <jcea@argo.es>
Organization: Argo Redes y Servicios Telematicos, S.A. - http://www.argo.es/
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: es,en,gl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, l-linux@calvo.teleco.ulpgc.es
Subject: AX64 too (was: Re: Dma problems - Aopen Ax34pro VIA chipset seagate 
 drive)
X-Priority: 1 (Highest)
In-Reply-To: <3A1A354D.3927.5A09E7EB@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please, if you respond, send me a copy to my mailbox, too.



> Status: kernel 2.4.0-test10 (no patches added)
> Problem: getting dma problems - having to run system with no dma
> for disc access - seems to be a bus mastering problem.
> Hardware: Aopen AX34Pro mother board, Via chipset with via686a,
> Seagate Baracuda ATA66 20GB disc - Latest Bios for motherboard
> Sony CDU4811 cdrom

I have a comparable problem with an Aopen AX64 motherboard. Chipset
via686a.

[root@colquide /root]# hdparm -i /dev/hda

/dev/hda:

 Model=ST320420A, FwRev=3.21, SerialNo=3CL0LN4H
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=39851760
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 


Kernel 2.2.17+ReiserFS (no additional patches).

>From time to time, the HD light goes on permanently and the Hard Disk
doesn't respond anymore. Processes run smoothly until they try to access
Hard Disk, since they block waiting the HD response.

I can see the following messages in the console (no hard disk log, since
the HD is not available):

(I'm copying the console using paper and pencil :-)

hda: status timeout: status = 0x80 {Busy}
hda: drive not ready for command
ide0: reset timed-out, status = 0x80
... the same thing ...
end_reques: I/O error, dev 03:01 (hda), sector 3145760
hda: status timeout: status = 0x80 {Busy}
hda: drive not ready for command
ide0: reset timed-out, status = 0x80
... and so on ...


The HD light is ON permanently.

If I reset the machine, the BIOS doesn't recognize the HD. I have to
switch the machine OFF in order to recover.

I can reproduce the problem with DMA and without it, with the
experimental 586 driver and without it too.

It's not a hardware defect since I can reproduce the error in two
different "twin" machines.

The machines runs FINE for hours/days, until this problem occurs. Not a
good deal for a production system (or for debug patches :-( ).

The power management is disabled.

The onboard sound system is disabled.

[root@colquide irc]# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 733.104
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 psn mmx fxsr xmm
bogomips        : 1461.45


PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies Unknown device (rev 196).
      Vendor id=1106. Device id=691.
      Medium devsel.  Master Capable.  No bursts.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe0000008].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies VT 82C598 Apollo MVP3 AGP (rev 0).
      Medium devsel.  Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies Unknown device (rev 27).
      Vendor id=1106. Device id=686.
      Medium devsel.  Master Capable.  No bursts.  
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies VT 82C586 Apollo IDE (rev 6).
      Medium devsel.  Fast back-to-back capable.  Master Capable. 
Latency=32.  
      I/O at 0x6400 [0x6401].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies VT 82C586 Apollo USB (rev 14).
      Medium devsel.  IRQ 10.  Master Capable.  Latency=32.  
      I/O at 0x6800 [0x6801].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies VT 82C586 Apollo USB (rev 14).
      Medium devsel.  IRQ 10.  Master Capable.  Latency=32.  
      I/O at 0x6c00 [0x6c01].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies Unknown device (rev 32).
      Vendor id=1106. Device id=3057.
      Medium devsel.  Fast back-to-back capable.  
  Bus  0, device  11, function  0:
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
      Medium devsel.  IRQ 5.  Master Capable.  Latency=32.  Min
Gnt=10.Max Lat=10.
      I/O at 0x7000 [0x7001].
      Non-prefetchable 32 bit memory at 0xea001000 [0xea001000].
  Bus  0, device  12, function  0:
    Ethernet controller: 3Com Unknown device (rev 116).
      Vendor id=10b7. Device id=9200.
      Medium devsel.  IRQ 11.  Master Capable.  Latency=32.  Min
Gnt=10.Max Lat=10.
      I/O at 0x7400 [0x7401].
      Non-prefetchable 32 bit memory at 0xea000000 [0xea000000].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Mach64 GB (rev 92).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master
Capable.  Latency=32.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe4000000].
      I/O at 0xe000 [0xe001].
      Non-prefetchable 32 bit memory at 0xe6000000 [0xe6000000].


> I am willing to test patches.

I could, but the problem is ocurring only over long time periods
(hours/days without any problem).

> Performance
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.69 seconds =185.51
> MB/sec
>  Timing buffered disk reads:  64 MB in 12.01 seconds =  5.33
> MB/sec

I get 3.5MB/s using 16 bits and 4.7MB/s using 32 bits. (hdparm -c
/dev/hda)

Current config:

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_VIA82C586=y
# CONFIG_BLK_DEV_CMD646 is not set
# CONFIG_BLK_DEV_CS5530 is not set
CONFIG_IDE_CHIPSETS=y
# CONFIG_BLK_DEV_4DRIVES is not set
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_QD6580 is not set
# CONFIG_BLK_DEV_UMC8672 is not set
# CONFIG_BLK_DEV_PDC4030 is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_STRIPED=m
CONFIG_MD_MIRRORING=m
CONFIG_MD_RAID5=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_XD=m
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_PARIDE_PARPORT=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_DEV_HD is not set

-- 
Jesus Cea Avion                         _/_/      _/_/_/        _/_/_/
jcea@argo.es http://www.argo.es/~jcea/ _/_/    _/_/  _/_/    _/_/  _/_/
                                      _/_/    _/_/          _/_/_/_/_/
PGP Key Available at KeyServ   _/_/  _/_/    _/_/          _/_/  _/_/
"Things are not so easy"      _/_/  _/_/    _/_/  _/_/    _/_/  _/_/
"My name is Dump, Core Dump"   _/_/_/        _/_/_/      _/_/  _/_/
"El amor es poner tu felicidad en la felicidad de otro" - Leibniz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310321AbSCALGa>; Fri, 1 Mar 2002 06:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310422AbSCALEE>; Fri, 1 Mar 2002 06:04:04 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:3332 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310321AbSCAK7k>; Fri, 1 Mar 2002 05:59:40 -0500
Date: Fri, 1 Mar 2002 02:59:34 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: lonely wolf <wolfy@pcnet.ro>
cc: linux-kernel@vger.kernel.org
Subject: Re: disk transfer speed problem
In-Reply-To: <3C7EE6A3.FF431772@pcnet.ro>
Message-ID: <Pine.LNX.4.10.10203010255530.514-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, lonely wolf wrote:

> From: Tim Moore
> >Please post dmesg, /proc/pci and chipset info from /proc/ide. Also,
> >what is result from 'hdparm -tT /dev/hda'?
> 
> From: Andre Hedrick
> >What is more useful is the cat /proc/ide/ide0/config !!!
> 

Well it is clear now, after obtaining the unpublished errata that a minor
bug may be showing it face.  It has to do with the programable timing
index and which registers can be set.  It also states that multiple bit
sets shall default to the highest supported clock.

So I will need to look at the docs public, unpublished, and call my friend
again to verify.

IIRC, he stated there is no problem but I am always paranoid about timing
issues.

Cheers,


> [root@bugmaster /root]# cat /proc/ide/ide0/config
> pci bus 00 device f9 vid 8086 did 244b channel 0
> 86 80 4b 24 05 00 80 02 11 80 01 01 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a1 ff 00 00 00 00 00 00 00 00 00 00 86 80 4d 42
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 07 a3 77 e3 38 00 00 00 0d 00 02 33 00 00 00 00
> 00 00 00 00 5d 04 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 4d 04 00 00 00 00 00 00
> 
> [root@bugmaster /root]# cat /proc/ide/ide1/config
> pci bus 00 device f9 vid 8086 did 244b channel 1
> 86 80 4b 24 05 00 80 02 11 80 01 01 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a1 ff 00 00 00 00 00 00 00 00 00 00 86 80 4d 42
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 07 a3 77 e3 38 00 00 00 0d 00 02 33 00 00 00 00
> 00 00 00 00 5d 04 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 4d 04 00 00 00 00 00 00
> 
> [root@bugmaster /root]# cat /proc/pci
> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: PCI device 8086:1130 (Intel Corporation) (rev 4).
>   Bus  0, device   2, function  0:
>     VGA compatible controller: PCI device 8086:1132 (Intel Corporation) (rev 4).
> 
>       IRQ 11.
>       Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
>       Non-prefetchable 32 bit memory at 0xffa80000 [0xffafffff].
>   Bus  0, device  30, function  0:
>     PCI bridge: Intel Corporation 82801BAM PCI (rev 17).
>       Master Capable.  No bursts.  Min Gnt=6.
>   Bus  0, device  31, function  0:
>     ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 17).
>   Bus  0, device  31, function  1:
>     IDE interface: Intel Corporation 82801BA IDE U100 (rev 17).
>       I/O at 0xffa0 [0xffaf].
>   Bus  0, device  31, function  2:
>     USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 17).
>       IRQ 10.
>       I/O at 0xef40 [0xef5f].
>   Bus  0, device  31, function  3:
>     SMBus: Intel Corporation 82801BA(M) SMBus (rev 17).
>       IRQ 9.
>       I/O at 0xefa0 [0xefaf].
>   Bus  0, device  31, function  4:
>     USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 17).
>       IRQ 6.
>       I/O at 0xef80 [0xef9f].
>   Bus  1, device   8, function  0:
>     Ethernet controller: Intel Corporation 82801BA(M) Ethernet (rev 3).
>       IRQ 3.
>       Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
>       Non-prefetchable 32 bit memory at 0xff8ff000 [0xff8fffff].
>       I/O at 0xdf00 [0xdf3f].
> 
> [root@bugmaster /root]# cat /proc/ide/drivers
> ide-floppy version 0.98
> ide-disk version 1.11
> 
> [root@bugmaster /root]# cat /proc/ide/piix
> 
>                                 Intel PIIX4 Ultra 100 Chipset.
> --------------- Primary Channel ---------------- Secondary Channel -------------
>                  enabled                          enabled
> --------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
> DMA enabled:    yes              no              yes               yes
> UDMA enabled:   yes              no              yes               yes
> UDMA enabled:   4                X               4                 4
> UDMA
> DMA
> PIO
> 
> [root@bugmaster /root]# /sbin/hdparm -tT /dev/hda
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  1.10 seconds =116.36 MB/sec
>  Timing buffered disk reads:  64 MB in  3.73 seconds = 17.16 MB/sec
> [root@bugmaster /root]# /sbin/hdparm -tT /dev/hda;/sbin/hdparm -i /dev/hda
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  1.11 seconds =115.32 MB/sec
>  Timing buffered disk reads:  64 MB in  3.48 seconds = 18.39 MB/sec
> 
> /dev/hda:
> 
>  Model=QUANTUM FIREBALLlct15 07, FwRev=A01.0F00, SerialNo=611025994167
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=15522/15/63, TrkSize=32256, SectSize=21298, ECCbytes=4
>  BuffType=DualPortCache, BuffSize=418kB, MaxMultSect=16, MultSect=16
>  CurCHS=15522/15/63, CurSects=-771620641, LBA=yes, LBAsects=14668290
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


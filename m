Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSKRJej>; Mon, 18 Nov 2002 04:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSKRJej>; Mon, 18 Nov 2002 04:34:39 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:23948 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S261829AbSKRJeh>;
	Mon, 18 Nov 2002 04:34:37 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: rubisko.ascs.muni.cz!xkaminsk
From: Zdenek SUTR Kaminski <xkaminsk@rubisko.ascs.muni.cz>
Subject: Re: Anyone use HPT366 + UDMA in Linux?
Message-ID: <Pine.LNX.4.44.0211152333530.29364-100000@rubisko.ascs.muni.cz>
In-Reply-To: <3DD571F1.3010502@wfmh.org.pl>
Date: Sat, 16 Nov 2002 11:18:16 GMT
X-Nntp-Posting-Host: rubisko.ascs.muni.cz
Reply-To: xkaminsk@fi.muni.cz
Content-Type: TEXT/PLAIN; charset=US-ASCII
References: <3DD571F1.3010502@wfmh.org.pl>
Mime-Version: 1.0
Organization: unknown
X-Muni-Virus-Test: Clean
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> My setup is (all info gathered on 2.4.17 which is the last kernel version I 
> can successfully boot with and which btw has been working flawlessly for a 
> long time):
> 
>  From dmesg:
> 
> HPT370A: chipset revision 4
> HPT370A: not 100% native mode: will probe irqs later
>      ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:pio, hdf:DMA
>      ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:pio, hdh:DMA
> hdf: IC35L040AVER07-0, ATA DISK drive
> hdh: IC35L040AVER07-0, ATA DISK drive
> hdf: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(44)
> hdh: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(44)
> 
> 
> fantomas:/home/thorgal# hdparm -i /dev/hdf
> 
> /dev/hdf:
> 
>   Model=IC35L040AVER07-0, FwRev=ER4OA44A, SerialNo=SX0SXM07352
>   Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>   RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
>   BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
>   CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80418240
>   IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>   PIO modes:  pio0 pio1 pio2 pio3 pio4
>   DMA modes:  mdma0 mdma1 mdma2
>   UDMA modes: udma0 udma1 udma2 *udma3 udma4 udma5
>   AdvancedPM=yes: disabled (255) WriteCache=enabled
>   Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5
> 
> Drive /dev/hdh is identical sans SerialNo.

 I have the same problem with my Seagate on Abit BE6-II. This is last 
succesfull boot (dmesg from 2.4.18):

...
Kernel command line: ... idebus=66 
...
ide: Assuming 66MHz system bus speed for PIO modes
..
HPT370: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 11 for device 00:13.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
hda: WDC AC24300L, ATA DISK drive
hde: ST34310A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xd800-0xd807,0xdc02 on irq 11
hda: 8421840 sectors (4312 MB) w/256KiB Cache, CHS=524/255/63, UDMA(33)
hde: 8420832 sectors (4311 MB) w/512KiB Cache, CHS=8354/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4
 hde: hde1
.....

/dev/hde:

 Model=ST34310A, FwRev=3.07, SerialNo=6AX03Y1Y
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=8354/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=16
 CurCHS=8354/16/63, CurSects=2111832192, LBA=yes, LBAsects=8420832
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 

With 2.4.19 I must change hde to hdc....
I know my dist is only ATA33, but befor 2.4.19 I have only one 40-pin and 
one 80-pin cable...

---------------------------------------------------------------------------
Bc. Zdenek Kaminski <xkaminsk at fi.muni.cz>

homepage: http://rubisko.ascs.muni.cz/~xkaminsk/
IPv6 router homepage: http://merlot.ics.muni.cz/




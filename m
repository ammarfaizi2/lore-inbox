Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129803AbQKXLjp>; Fri, 24 Nov 2000 06:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131928AbQKXLjf>; Fri, 24 Nov 2000 06:39:35 -0500
Received: from cassis.axialys.net ([195.115.102.11]:61193 "EHLO
        cassis.axialys.net") by vger.kernel.org with ESMTP
        id <S129803AbQKXLjT>; Fri, 24 Nov 2000 06:39:19 -0500
Date: Fri, 24 Nov 2000 12:13:37 +0100
From: Simon Huggins <huggie@earth.li>
To: linux-kernel@vger.kernel.org
Cc: Andre Hedrick <andre@linux-ide.org>
Subject: Re: ATA/IDE: dmaproc error 14 testers wanted!
Message-ID: <20001124121337.A1101@paranoidfreak.freeserve.co.uk>
Mail-Followup-To: Simon Huggins <huggie@earth.li>,
        linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <01CBB9212067C547A572CA1AE8757EB50C00@EMAIL.debugs.org> <Pine.LNX.4.10.10011191537290.20388-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011191537290.20388-100000@master.linux-ide.org>; from andre@linux-ide.org on Sun, Nov 19, 2000 at 03:37:56PM -0800
Organization: Black Cat Networks, http://www.blackcatnetworks.co.uk/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 03:37:56PM -0800, Andre Hedrick wrote:
> /pub/linux/kernel/people/hedrick/ide-2.2.17/README
> /pub/linux/kernel/people/hedrick/ide-2.2.17/ide.2.2.17.all.20001118.patch.bz2
> There you go Sean, hope that helps.

It didn't help me :)

Axialys have a squid/socks/NFS server which therefore has a fair bit of
disk activity.

It died randomly a while ago, so I put a serial console on it and this
morning a coworker had to reboot it.

The last message was apparently the very same you are trying to prevent:
"hdg: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14"
(usual caveat about hand copied)

This was 2.2.17+ide (20000904)+RAID(2.2.17-A0).

This morning I updated to this patch and I tried to kill it just now.
It died :(
(That is with the 20001118 ide patch instead of the 20000904 one)

This time only with a "hdg: timeout waiting for DMA" with nothing
following it on the serial console.

It seems that
hdparm -t /dev/hde & hdparm -t /dev/hde & hdparm -t /dev/hde & hdparm -t
/dev/hde & hdparm -t /dev/hdg & hdparm -t /dev/hdg & hdparm -t /dev/hdg
& hdparm -t /dev/hdg
kills it in this way.  (That might be excessive but I'll get odd looks
is the proxy is down again because I'm testing exactly how many hdparms
it takes).

Let me know if there is anything I can test (in the evening/this weekend).

Here's some information:
Nov 24 11:50:15 orange kernel: Uniform Multi-Platform E-IDE driver Revision: 6.30
Nov 24 11:50:15 orange kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 24 11:50:15 orange kernel: PIIX4: IDE controller on PCI bus 00 dev 39
Nov 24 11:50:15 orange kernel: PIIX4: chipset revision 1
Nov 24 11:50:15 orange kernel: PIIX4: not 100%% native mode: will probe irqs later
Nov 24 11:50:15 orange kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:DMA
Nov 24 11:50:15 orange kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Nov 24 11:50:15 orange kernel: HPT366: onboard version of chipset, pin1=1 pin2=2
Nov 24 11:50:15 orange kernel: PCI: HPT366: Fixing interrupt 11 pin 2 to ZERO
Nov 24 11:50:15 orange kernel: HPT366: IDE controller on PCI bus 00 dev 98
Nov 24 11:50:15 orange kernel: HPT366: chipset revision 1
Nov 24 11:50:15 orange kernel: HPT366: not 100%% native mode: will probe irqs later
Nov 24 11:50:15 orange kernel:     ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:DMA, hdf:pio
Nov 24 11:50:15 orange kernel: HPT366: IDE controller on PCI bus 00 dev 99
Nov 24 11:50:15 orange kernel: HPT366: chipset revision 1
Nov 24 11:50:15 orange kernel: HPT366: not 100%% native mode: will probe irqs later
Nov 24 11:50:15 orange kernel:     ide3: BM-DMA at 0xec00-0xec07, BIOS settings: hdg:DMA, hdh:pio
Nov 24 11:50:15 orange kernel: hdb: FX4824T, ATAPI CDROM drive
Nov 24 11:50:15 orange kernel: hde: Maxtor 54098H8, ATA DISK drive
Nov 24 11:50:15 orange kernel: hdg: Maxtor 54098H8, ATA DISK drive
Nov 24 11:50:15 orange kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 24 11:50:15 orange kernel: ide2 at 0xd800-0xd807,0xdc02 on irq 11
Nov 24 11:50:15 orange kernel: ide3 at 0xe400-0xe407,0xe802 on irq 11
Nov 24 11:50:15 orange kernel: hde: Maxtor 54098H8, 39082MB w/2048kB Cache, CHS=79406/16/63, UDMA(66)
Nov 24 11:50:15 orange kernel: hdg: Maxtor 54098H8, 39082MB w/2048kB Cache, CHS=79406/16/63, UDMA(66)
Nov 24 11:50:15 orange kernel: hdb: ATAPI 48X CD-ROM drive, 128kB Cache,
UDMA(33)
Nov 24 11:50:15 orange kernel: Uniform CD-ROM driver Revision: 3.11

orange:/home/huggie# hdparm -i /dev/hde

/dev/hde:

 Model=Maxtor 54098H8, FwRev=DAC10SC0, SerialNo=K80B8WCC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=80041248
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2 mode3 *mode4 mode5

orange:/home/huggie# hdparm -i /dev/hdg

/dev/hdg:

 Model=Maxtor 54098H8, FwRev=DAC10SC0, SerialNo=K80AHT0C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=80041248
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2 mode3 *mode4 mode5

Simon.

-- 
[ "Peace and understanding through brute force." -- David Parsons      ]
        Black Cat Networks.  http://www.blackcatnetworks.co.uk/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

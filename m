Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316290AbSEKXu5>; Sat, 11 May 2002 19:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSEKXu4>; Sat, 11 May 2002 19:50:56 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:65041
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316287AbSEKXuy>; Sat, 11 May 2002 19:50:54 -0400
Date: Sat, 11 May 2002 16:48:19 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 60
In-Reply-To: <3CDD7671.6010203@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10205111637510.3133-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am sorry I can not do much for 2.5 at the moment.
Please revert to 2.4.19-pre7 plus my mondo patch.

bp6:~ # uname -a
Linux bp6 2.4.19-pre7 #1 SMP Tue May 7 12:57:46 PDT 2002 i686 unknown

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
        Flags: bus master, medium devsel, latency 120, IRQ 18
        I/O ports at d800 [size=8]
        I/O ports at dc00 [size=4]
        I/O ports at e000 [size=256]
        Expansion ROM at ea000000 [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
        Flags: bus master, medium devsel, latency 120, IRQ 18
        I/O ports at e400 [size=8]
        I/O ports at e800 [size=4]
        I/O ports at ec00 [size=256]

HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
PCI: Enabling device 00:13.0 (0005 -> 0007)
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
HPT366: IDE controller on PCI bus 00 dev 99
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0xec00-0xec07, BIOS settings: hdc:DMA, hdd:pio
hda: DupliDisk IDE RAID-1 Adapter( 1.19), ATA DISK drive
hdc: QUANTUM FIREBALLP KA13.6, ATA DISK drive
ide2: ports already in use, skipping probe
ide0 at 0xd800-0xd807,0xdc02 on irq 18
ide1 at 0xe400-0xe407,0xe802 on irq 18
hda: host protected area => 1
hda: setmax LBA 18041184, native  18039168
hda: 18039168 sectors (9236 MB) w/371KiB Cache, CHS=17896/16/63, UDMA(66)
hdc: host protected area => 1
hdc: 27068420 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63, UDMA(66)
ide-floppy driver 0.99.newide
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 >
 /dev/ide/host1/bus0/target0/lun0: unknown partition table
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)

If it still fails it is a driver-chipset problem.
If it works in 2.4 but fails in 2.5 gawd only knows what is the issue.

On Sat, 11 May 2002, Pierre Rousselet wrote:

> Andre Hedrick wrote:
> > You have to specify which of the 6 revisions of the chipset you have.
> > Also in some cases which of the 13 sub-revisions, and the latter is
> > determined by the sub-vender-device.
> 
> hde is ST310212A UDMA(66), hdg is SAMSUNG SV0322A UDMA(33) (motherboard 
> BE6).
> 
> # lspci -v gives (2.5.14 PCI_NAMES not set) :
> 
> 00:13.0 Unknown mass storage controller: Triones Technologies, Inc. 
> HPT366 (rev 01)
> 	Flags: bus master, medium devsel, latency 120, IRQ 11
> 	I/O ports at cc00 [size=8]
> 	I/O ports at d000 [size=4]
> 	I/O ports at d400 [size=256]
> 	Expansion ROM at <unassigned> [disabled] [size=128K]
> 
> 00:13.1 Unknown mass storage controller: Triones Technologies, Inc. 
> HPT366 (rev 01)
> 	Flags: bus master, medium devsel, latency 120, IRQ 11
> 	I/O ports at d800 [size=8]
> 	I/O ports at dc00 [size=4]
> 	I/O ports at e000 [size=256]
> 
> # scanpci -v:
> 
> pci bus 0x0000 cardnum 0x13 function 0x00: vendor 0x1103 device 0x0004
>   Device unknown
>    STATUS    0x0200  COMMAND 0x0005
>    CLASS     0x01 0x80 0x00  REVISION 0x01
>    BIST      0x00  HEADER 0x80  LATENCY 0x78  CACHE 0x08
>    BASE0     0x0000cc01  addr 0x0000cc00  I/O
>    BASE1     0x0000d001  addr 0x0000d000  I/O
>    BASE4     0x0000d401  addr 0x0000d400  I/O
>    MAX_LAT   0x08  MIN_GNT 0x08  INT_PIN 0x01  INT_LINE 0x0b
>    BYTE_0    0x10c9a731  BYTE_1  0x00  BYTE_2  0x80736b0  BYTE_3  0xffffffff
> 
> pci bus 0x0000 cardnum 0x13 function 0x01: vendor 0x1103 device 0x0004
>   Device unknown
>    STATUS    0x0200  COMMAND 0x0007
>    CLASS     0x01 0x80 0x00  REVISION 0x01
>    BIST      0x00  HEADER 0x80  LATENCY 0x78  CACHE 0x08
>    BASE0     0x0000d801  addr 0x0000d800  I/O
>    BASE1     0x0000dc01  addr 0x0000dc00  I/O
>    BASE4     0x0000e001  addr 0x0000e000  I/O
>    MAX_LAT   0x08  MIN_GNT 0x08  INT_PIN 0x02  INT_LINE 0x0b
>    BYTE_0    0x10caa731  BYTE_1  0x00  BYTE_2  0x8073a28  BYTE_3  0xffffffff
> 
> # cat /proc/ide/hpt366 :
>                               HighPoint HPT366/368/370
> 
> Controller: 0
> Chipset: HPT366
> --------------- Primary Channel --------------- Secondary Channel 
> --------------
> Enabled:        yes                             yes
> --------------- drive0 --------- drive1 ------- drive0 ---------- drive1 
> -------
> DMA capable:    yes              no             no                no
> Mode:           UDMA             off            off               off
> 
> Controller: 1
> Chipset: HPT366
> --------------- Primary Channel --------------- Secondary Channel 
> --------------
> Enabled:        yes                             yes
> --------------- drive0 --------- drive1 ------- drive0 ---------- drive1 
> -------
> DMA capable:    yes              no             no                no
> Mode:           UDMA             off            off               off
> 
> -- 
> Pierre
> ------------------------------------------------
>   Pierre Rousselet <pierre.rousselet@wanadoo.fr>
> ------------------------------------------------
> 

Andre Hedrick
LAD Storage Consulting Group


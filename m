Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbQJ1XTO>; Sat, 28 Oct 2000 19:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbQJ1XTE>; Sat, 28 Oct 2000 19:19:04 -0400
Received: from janus.hosting4u.net ([209.15.2.37]:18444 "HELO
	janus.hosting4u.net") by vger.kernel.org with SMTP
	id <S130685AbQJ1XSz>; Sat, 28 Oct 2000 19:18:55 -0400
Message-ID: <39FB5DB1.A92C8360@a2zis.com>
Date: Sun, 29 Oct 2000 01:13:53 +0200
From: Remi Turk <remi@a2zis.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test10-pre6-test1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: No IRQ known for interrupt pin A of device 00:0f.0]
In-Reply-To: <39FB2BCF.64A80D88@mandrakesoft.com> <39FB52CD.5BBC4017@a2zis.com>
Content-Type: multipart/mixed;
 boundary="------------1ED8D4BF6FD05FFB7CC48DCB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1ED8D4BF6FD05FFB7CC48DCB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Remi Turk wrote:
> > Ok, the problem is that you have an interrupt router table for your Ali
> > 1533, but no interrupt router entry for your IDE device.  That's why
> > pci_enable_device is failing.
> >
> > Would you mind testing two kernel patches for me?  Both of these changes
> > should be attempted separately in 2.4.0-test10-pre6, and -without-
> > Andre's change.
> >
> > The first change attempts to build an interrupt router entry for you, if
> > none is available.  I am most interested if this works.
> >
> > The second change simply ignores any pci_enable_device error returns,
> > and assumes that the IDE subsystem will pick up the pieces.
> >
> > Remember, do not apply both of these changes at the same time...
> >
> > Thanks,
> >
> >         Jeff
> 
> The second patch (the one ignoring errors) doesn't seem to change
> anything (except not giving the warning IIRC)
> Also, dump_pirq and lspci -vv output didn't change.
> 
> The first says the following at boot:
> 
> PCI: PCI BIOS revision 2.10 entry at 0xf0560, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Unknown bridge resource 0: assuming transparent
> PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
> PCI: Found IRQ 14 for device 00:0f.0
> 
> dump_pirq output remains the same.
> The lspci -vv output does change with the second patch:
> 
>  00:0f.0 IDE interface: Acer Laboratories Inc. M5229 (rev c1) (prog-if
> fa)
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 2 min, 4 max, 32 set
> -       Interrupt: pin A routed to IRQ 0
> +       Interrupt: pin A routed to IRQ 14
>         Region 4: I/O ports at d000
> 
> More info on request.
> 

Hm, while running with the first patch (the one trying to build
an interrupt router table for my chipset) my system locked solid
for a few seconds while I was copying the kernel-source to another
place and moved from one virtual screen to another in X.
It happened just once, but I don't remember the last time I had
this kind of latency. At the same time I noticed this in my
kernel logs:

localhost kernel: cdrom: open failed. 
   I haven't done anything with my cdrom since the last reboot.

localhost modprobe: modprobe: Can't locate module block-major-33
localhost modprobe: modprobe: Can't locate module block-major-33
localhost modprobe: modprobe: Can't locate module block-major-34
localhost modprobe: modprobe: Can't locate module block-major-34
localhost modprobe: modprobe: Can't locate module block-major-8
localhost last message repeated 15 times
   I only have hd[a-c]

(timestamps removed to prevent irritating wrapping,
they were all in the same minute)

My dmesg is attached, just in case.

-- 
Linux 2.4.0-test10-pre6-test1 #1 Sat Oct 28 23:04:32 CEST 2000
--------------1ED8D4BF6FD05FFB7CC48DCB
Content-Type: text/plain; charset=us-ascii;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.4.0-test10-pre6-test1 (src@localhost.localdomain) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Sat Oct 28 23:04:32 CEST 2000
BIOS-provided physical RAM map:
 BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000000fefc000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000003000 @ 000000000fffc000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 000000000ffff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 65532
zone(0): 4096 pages.
zone(1): 61436 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01444000)
Kernel command line: 
Initializing CPU#0
Detected 350.802 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 699.60 BogoMIPS
Memory: 255780k/262128k available (1099k kernel code, 5964k reserved, 85k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: L1 I Cache: 32K  L1 D Cache: 32K (32 bytes/line)
CPU: AMD-K6(tm) 3D processor stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf0560, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
PCI: Found IRQ 14 for device 00:0f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALL EL5.1A, ATA DISK drive
hdb: CD-ROM 36X/AKW, ATAPI CDROM drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: QUANTUM FIREBALLP KA13.6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 10018890 sectors (5130 MB) w/418KiB Cache, CHS=10602/15/63, UDMA(33)
hdc: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63, UDMA(33)
hdb: ATAPI 36X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.11
Partition check:
 hda: hda1
 hdc: hdc1 hdc2 hdc3 hdc4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
LVM version 0.8final  by Heinz Mauelshagen  (15/02/2000)
lvm -- Driver successfully initialized
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 133552k swap-space (priority -1)
ip_conntrack (2047 buckets, 16376 max)
Creative EMU10K1 PCI Audio Driver, version 0.11, 23:58:36 Oct 28 2000
emu10k1: EMU10K1 rev 4 model 0x20 found, IO at 0xd800-0xd81f, IRQ 10
ac97_codec: AC97  codec, vendor id1: 0x5452, id2: 0x4103 (TriTech TR?????)
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1
PPP BSD Compression module registered
PPP Deflate Compression module registered
VFS: Disk change detected on device fd(2,0)
cdrom: open failed.
VFS: Disk change detected on device ide0(3,64)




--------------1ED8D4BF6FD05FFB7CC48DCB--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

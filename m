Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbTI1KD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 06:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTI1KD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 06:03:59 -0400
Received: from law11-f66.law11.hotmail.com ([64.4.17.66]:8718 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261503AbTI1KDv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 06:03:51 -0400
X-Originating-IP: [210.28.141.130]
X-Originating-Email: [jzhang001@hotmail.com]
From: "Zhang Jian" <jzhang001@hotmail.com>
To: andre@linuxdiskcert.org
Cc: linux-kernel@vger.kernel.org
Subject: urgent! help, ide driver bug?
Date: Sun, 28 Sep 2003 18:03:50 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW11-F66x33E1ioWwr00014013@hotmail.com>
X-OriginalArrivalTime: 28 Sep 2003 10:03:50.0633 (UTC) FILETIME=[D0D79D90:01C385A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I am a system manager in institute of biophysics, Nanjing University, I 
encounter a big problem, seems related to IDE driver, now I am writing for 
your warmly help!

we buy a 32 nodes cluster, each with AMD 2600+, 512M Kingstone ECC 
Registered MEM, MSI K7D master-L motherbord, ST Barracude 7200.7 80G 
harddisk. We installed Redhat Linux 8.0 in it,
and run two programs each cost about 400M mem, thus force kernel use swap 
disk.
then, after several minutes, some nodes crash down,  whereas some nodes can 
run
several hours to two days, varying from computer to computer. we also tried 
readhat
9.0(kernel 2.4.20-9) and debian(kernel 2.4.22), the problem remains the 
same.

here is the typical error message in debian, (in redhat, the error is 
similar)

Attempt to access beyond end of device
03:02: rw=0, want=75368548, limit=7815622
ext2-fs error(device ide0(3:2)): ext2_check_page: bad entry
in directory #2: rec_len is smaller than minimal - offset=0,
inode=1097631760, rec_len=0, name_len=0
remounting filesystem read_only

below is the partition table:
---------------------------------------------------------------------------
Disk /dev/hda: 255 heads, 63 sectors, 9729 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1        12     96358+  83  Linux         /boot
/dev/hda2            13       985   7815622+  83  Linux         /
/dev/hda3           986      1109    996030   82  Linux swap    swap
/dev/hda4          1110      9729  69240150   83  Linux         nouse
---------------------------------------------------------------------------

all our 32 nodes encounter similar problems, so I suspect whether
it is caused by some bugs in kernel or elsewhere.
I am looking forward to your warmly help!
Thank you very much!

--------------------------------------------------------------------------------------

this is the fortran program we used to test the computer:
        program test

        real*8          A(1000,1000,50)

        do while(.true.)

        do i=1,1000
        do j=1,1000
        do k=1,50
                A(i,j,k)=i*j*k
        enddo
        enddo
        enddo

        enddo

        end
----------------------------------------------------
below is copied from /var/log/messages

Sep 29 17:51:27 boss syslogd 1.4.1#10: restart.
Sep 29 17:51:27 boss kernel: klogd 1.4.1#10, log source = /proc/kmsg 
started.
Sep 29 17:51:27 boss kernel: Inspecting /boot/System.map-2.4.22dualmp
Sep 29 17:51:27 boss kernel: Loaded 16905 symbols from 
/boot/System.map-2.4.22dualmp.
Sep 29 17:51:27 boss kernel: Symbols match kernel version 2.4.22.
Sep 29 17:51:27 boss kernel: No module symbols loaded.
Sep 29 17:51:27 boss kernel: Linux version 2.4.22dualmp (root@boss) (gcc 
version 2.95.4 20011002 (Debian prerelease)) #1 SMP Sun Sep 28 12:12:04 CST 
2003
Sep 29 17:51:27 boss kernel: BIOS-provided physical RAM map:
Sep 29 17:51:27 boss kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 
(usable)
Sep 29 17:51:27 boss kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Sep 29 17:51:27 boss kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 
(usable)
Sep 29 17:51:27 boss kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 
(ACPI NVS)
Sep 29 17:51:27 boss kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 
(ACPI data)
Sep 29 17:51:27 boss kernel:  BIOS-e820: 00000000fec00000 - 0000000100000000 
(reserved)
Sep 29 17:51:27 boss kernel: 511MB LOWMEM available.
Sep 29 17:51:27 boss kernel: found SMP MP-table at 000f4b00
Sep 29 17:51:27 boss kernel: hm, page 000f4000 reserved twice.
Sep 29 17:51:27 boss kernel: hm, page 000f5000 reserved twice.
Sep 29 17:51:27 boss kernel: hm, page 000f1000 reserved twice.
Sep 29 17:51:27 boss kernel: hm, page 000f2000 reserved twice.
Sep 29 17:51:27 boss kernel: On node 0 totalpages: 131056
Sep 29 17:51:27 boss kernel: zone(0): 4096 pages.
Sep 29 17:51:27 boss kernel: zone(1): 126960 pages.
Sep 29 17:51:27 boss kernel: zone(2): 0 pages.
Sep 29 17:51:27 boss kernel: Intel MultiProcessor Specification v1.4
Sep 29 17:51:27 boss kernel:     Virtual Wire compatibility mode.
Sep 29 17:51:27 boss kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC 
at: 0xFEE00000
Sep 29 17:51:27 boss kernel: Processor #0 Pentium(tm) Pro APIC version 17
Sep 29 17:51:27 boss kernel: Processor #1 Pentium(tm) Pro APIC version 17
Sep 29 17:51:27 boss kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Sep 29 17:51:27 boss kernel: Enabling APIC mode: Flat.^IUsing 1 I/O APICs
Sep 29 17:51:27 boss kernel: Processors: 2
Sep 29 17:51:27 boss kernel: Kernel command line: BOOT_IMAGE=Linux ro 
root=302
Sep 29 17:51:27 boss kernel: Initializing CPU#0
Sep 29 17:51:27 boss kernel: Detected 2133.424 MHz processor.
Sep 29 17:51:27 boss kernel: Console: colour VGA+ 80x25
Sep 29 17:51:27 boss kernel: Calibrating delay loop... 4259.84 BogoMIPS
Sep 29 17:51:27 boss kernel: Memory: 515952k/524224k available (1159k kernel 
code, 7888k reserved, 335k data, 264k init, 0k highmem)
Sep 29 17:51:27 boss kernel: Dentry cache hash table entries: 65536 (order: 
7, 524288 bytes)
Sep 29 17:51:27 boss kernel: Inode cache hash table entries: 32768 (order: 
6, 262144 bytes)
Sep 29 17:51:27 boss kernel: Mount cache hash table entries: 512 (order: 0, 
4096 bytes)
Sep 29 17:51:27 boss kernel: Buffer cache hash table entries: 32768 (order: 
5, 131072 bytes)
Sep 29 17:51:27 boss kernel: Page-cache hash table entries: 131072 (order: 
7, 524288 bytes)
Sep 29 17:51:27 boss kernel: CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 
2003d22f
Sep 29 17:51:27 boss kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 
64K (64 bytes/line)
Sep 29 17:51:27 boss kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep 29 17:51:27 boss kernel: Enabling fast FPU save and restore... done.
Sep 29 17:51:27 boss kernel: Enabling unmasked SIMD FPU exception support... 
done.
Sep 29 17:51:27 boss kernel: Checking 'hlt' instruction... OK.
Sep 29 17:51:27 boss kernel: POSIX conformance testing by UNIFIX
Sep 29 17:51:27 boss kernel: mtrr: v1.40 (20010327) Richard Gooch 
(rgooch@atnf.csiro.au)
Sep 29 17:51:27 boss kernel: mtrr: detected mtrr type: Intel
Sep 29 17:51:27 boss kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 
64K (64 bytes/line)
Sep 29 17:51:27 boss kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep 29 17:51:27 boss kernel: CPU0: AMD Athlon(tm) MP 2600+ stepping 01
Sep 29 17:51:27 boss kernel: per-CPU timeslice cutoff: 731.42 usecs.
Sep 29 17:51:27 boss kernel: enabled ExtINT on CPU#0
Sep 29 17:51:27 boss kernel: ESR value before enabling vector: 00000000
Sep 29 17:51:27 boss kernel: ESR value after enabling vector: 00000000
Sep 29 17:51:27 boss kernel: Booting processor 1/1 eip 2000
Sep 29 17:51:27 boss kernel: Initializing CPU#1
Sep 29 17:51:27 boss kernel: masked ExtINT on CPU#1
Sep 29 17:51:27 boss kernel: ESR value before enabling vector: 00000000
Sep 29 17:51:27 boss kernel: ESR value after enabling vector: 00000000
Sep 29 17:51:27 boss kernel: Calibrating delay loop... 4259.84 BogoMIPS
Sep 29 17:51:27 boss kernel: CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 
2003d22f
Sep 29 17:51:27 boss kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 
64K (64 bytes/line)
Sep 29 17:51:27 boss kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep 29 17:51:27 boss kernel: CPU1: AMD Athlon(tm) MP stepping 01
Sep 29 17:51:27 boss kernel: Total of 2 processors activated (8519.68 
BogoMIPS).
Sep 29 17:51:27 boss kernel: ENABLING IO-APIC IRQs
Sep 29 17:51:27 boss kernel: Setting 2 in the phys_id_present_map
Sep 29 17:51:27 boss kernel: ...changing IO-APIC physical APIC ID to 2 ... 
ok.
Sep 29 17:51:27 boss kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Sep 29 17:51:27 boss kernel: testing the IO APIC.......................
Sep 29 17:51:27 boss kernel:
Sep 29 17:51:27 boss kernel: .................................... done.
Sep 29 17:51:27 boss kernel: Using local APIC timer interrupts.
Sep 29 17:51:27 boss kernel: calibrating APIC timer ...
Sep 29 17:51:27 boss kernel: ..... CPU clock speed is 2133.4152 MHz.
Sep 29 17:51:27 boss kernel: ..... host bus clock speed is 266.6766 MHz.
Sep 29 17:51:27 boss kernel: cpu: 0, clocks: 2666766, slice: 888922
Sep 29 17:51:27 boss kernel: 
CPU0<T0:2666752,T1:1777824,D:6,S:888922,C:2666766>
Sep 29 17:51:27 boss kernel: cpu: 1, clocks: 2666766, slice: 888922
Sep 29 17:51:27 boss kernel: 
CPU1<T0:2666752,T1:888896,D:12,S:888922,C:2666766>
Sep 29 17:51:27 boss kernel: checking TSC synchronization across CPUs: 
passed.
Sep 29 17:51:27 boss kernel: Waiting on wait_init_idle (map = 0x2)
Sep 29 17:51:27 boss kernel: All processors have done init_idle
Sep 29 17:51:27 boss kernel: mtrr: your CPUs had inconsistent fixed MTRR 
settings
Sep 29 17:51:27 boss kernel: mtrr: probably your BIOS does not setup all 
CPUs
Sep 29 17:51:27 boss kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb130, 
last bus=2
Sep 29 17:51:27 boss kernel: PCI: Using configuration type 1
Sep 29 17:51:27 boss kernel: PCI: Probing PCI hardware
Sep 29 17:51:27 boss kernel: PCI: Probing PCI hardware (bus 00)
Sep 29 17:51:27 boss kernel: PCI: Using IRQ router default [1022/700c] at 
00:00.0
Sep 29 17:51:27 boss kernel: PCI->APIC IRQ transform: (B1,I5,P0) -> 17
Sep 29 17:51:27 boss kernel: PCI->APIC IRQ transform: (B2,I0,P3) -> 19
Sep 29 17:51:27 boss kernel: PCI->APIC IRQ transform: (B2,I9,P0) -> 17
Sep 29 17:51:27 boss kernel: BIOS failed to enable PCI standards compliance, 
fixing this error.
Sep 29 17:51:27 boss kernel: Linux NET4.0 for Linux 2.4
Sep 29 17:51:27 boss kernel: Based upon Swansea University Computer Society 
NET3.039
Sep 29 17:51:27 boss kernel: Initializing RT netlink socket
Sep 29 17:51:27 boss kernel: Starting kswapd
Sep 29 17:51:27 boss kernel: Detected PS/2 Mouse Port.
Sep 29 17:51:27 boss kernel: pty: 256 Unix98 ptys configured
Sep 29 17:51:27 boss kernel: Serial driver version 5.05c (2001-07-08) with 
MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Sep 29 17:51:27 boss kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Sep 29 17:51:27 boss kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Sep 29 17:51:27 boss kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
Sep 29 17:51:27 boss kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 
Modified by Andrey V. Savochki
n <saw@saw.sw.com.sg> and others
Sep 29 17:51:27 boss kernel: eth0: OEM i82557/i82558 10/100 Ethernet, 
00:0C:76:2A:2F:7D, IRQ 17.
Sep 29 17:51:27 boss kernel:   Board assembly a32040-002, Physical 
connectors present: RJ45
Sep 29 17:51:27 boss kernel:   Primary interface chip i82555 PHY #1.
Sep 29 17:51:27 boss kernel:   General self-test: passed.
Sep 29 17:51:27 boss kernel:   Serial sub-system self-test: passed.
Sep 29 17:51:27 boss kernel:   Internal registers self-test: passed.
Sep 29 17:51:27 boss kernel:   ROM checksum self-test: passed (0xd0a6c714).
Sep 29 17:51:27 boss kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Sep 29 17:51:27 boss kernel: agpgart: Maximum main memory to use for agp 
memory: 439M
Sep 29 17:51:27 boss kernel: agpgart: Detected AMD 760MP chipset
Sep 29 17:51:27 boss kernel: agpgart: AGP aperture is 128M @ 0xe0000000
Sep 29 17:51:27 boss kernel: Uniform Multi-Platform E-IDE driver Revision: 
7.00beta4-2.4
Sep 29 17:51:27 boss kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Sep 29 17:51:27 boss kernel: AMD7441: IDE controller at PCI slot 00:07.1
Sep 29 17:51:27 boss kernel: AMD7441: chipset revision 4
Sep 29 17:51:27 boss kernel: AMD7441: not 100%% native mode: will probe irqs 
later
Sep 29 17:51:27 boss kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Sep 29 17:51:27 boss kernel: AMD_IDE: Advanced Micro Devices [AMD] AMD-768 
[Opus] IDE (rev 04) UDMA1
00 controller on pci00:07.1
Sep 29 17:51:27 boss kernel:     ide0: BM-DMA at 0xe000-0xe007, BIOS 
settings: hda:DMA, hdb:pio
Sep 29 17:51:27 boss kernel:     ide1: BM-DMA at 0xe008-0xe00f, BIOS 
settings: hdc:pio, hdd:pio
Sep 29 17:51:27 boss kernel: hda: ST380011A, ATA DISK drive
Sep 29 17:51:27 boss kernel: blk: queue c0309fe0, I/O limit 4095Mb (mask 
0xffffffff)
Sep 29 17:51:27 boss kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 29 17:51:27 boss kernel: hda: attached ide-disk driver.
Sep 29 17:51:27 boss kernel: hda: 156301488 sectors (80026 MB) w/2048KiB 
Cache, CHS=9729/255/63, UDMA(100)
Sep 29 17:51:27 boss kernel: Partition check:
Sep 29 17:51:27 boss kernel:  hda: hda1 hda2 hda3 hda4
Sep 29 17:51:27 boss kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Sep 29 17:51:27 boss kernel: IP: routing cache hash table of 4096 buckets, 
32Kbytes
Sep 29 17:51:27 boss kernel: TCP: Hash tables configured (established 32768 
bind 32768)
Sep 29 17:51:27 boss kernel: NET4: Unix domain sockets 1.0/SMP for Linux 
NET4.0.
Sep 29 17:51:27 boss kernel: VFS: Mounted root (ext2 filesystem) readonly.
Sep 29 17:51:27 boss kernel: Freeing unused kernel memory: 264k freed
Sep 29 17:51:27 boss kernel: Adding Swap: 996020k swap-space (priority -1)
========================


J. Zhang, Dr
Institute of Biophysics
Nanjing University
Nanjing, P. R. China

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE* 
http://join.msn.com/?page=features/junkmail


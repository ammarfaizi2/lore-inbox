Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286946AbRL1Rqa>; Fri, 28 Dec 2001 12:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286951AbRL1RqS>; Fri, 28 Dec 2001 12:46:18 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:41907 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S286953AbRL1Rpv>; Fri, 28 Dec 2001 12:45:51 -0500
Date: Fri, 28 Dec 2001 12:49:05 -0500
To: Jens Axboe <axboe@suse.de>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011228124905.A15601@earthlink.net>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221185538.A131@earthlink.net> <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net> <20011224180244.C1241@suse.de> <20011227140723.A4713@earthlink.net> <20011228124037.K2973@suse.de> <20011228091401.A15569@earthlink.net> <20011228153022.D1248@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011228153022.D1248@suse.de>; from axboe@suse.de on Fri, Dec 28, 2001 at 03:30:22PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 03:30:22PM +0100, Jens Axboe wrote:
> Thanks for an excellent report. I can't quite see what the problem
> should be yet, especially since the problems seem to start with
> 2.5.2-pre1 which doesn't really have a lot of interesting changes. I'll
> keep looking, though. Could you do sysrq-t for a livelocked system?

I don't know how to do sysrq-t via serial console.  If I put a monitor
and keyboard on the box, syslogd is blocked when the livelock occurs,
and I haven't figured out a workaround yet.

2.5.1 runs dbench 32, 128, by the way.

> The livelocks in this mail appear different than the previous ones.
> Could you try running without swap?

Here is without swap on 2.5.2-pre2.

vmstat 8
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0      0 350756  19484   5464   0   0     0     0  100    41   0   0 100
 0  0  0      0 350756  19484   5464   0   0     0     0  100    41   0   0 100
 3 29  0      0 344668  19588   8464   0   0    29     0  108    70   1   1  98
 0 32  1      0 184264  20824 162556   0   0    32  9123 1085    59   3  86  11
21 11  3      0 181748  20864 164916   0   0     1 10500 1503    20   1  83  16
 0 32  1      0 148560  21272 196764   0   0     4  4838  893    52   2  47  51
 6 26  2      0 106532  21804 237140   0   0     2  5590  836    62   2  35  64
 0 32  2      0   4448   5380 353332   0   0    11    44  253   120   2  26  73
 0 32  2      0   4448   5380 353332   0   0     0     0  101    41   0   0 100
 0 32  2      0   4448   5380 353332   0   0     0     0  101    41   0   0 100

ps -eo cmd,wchan
CMD              WCHAN
init             do_select
[keventd]        context_thread
[ksoftirqd_CPU0] ksoftirqd
[kswapd]         kswapd
[bdflush]        wait_on_buffer
[kupdated]       wait_on_buffer
[kreiserfsd]     reiserfs_journal_commit_thread
/usr/sbin/syslog do_select
/usr/sbin/klogd  do_syslog
[eth0]           rtl8139_thread
/usr/sbin/sshd   do_select
/sbin/agetty tty read_chan
/sbin/agetty -h  read_chan
/usr/sbin/sshd   do_select
-bash            wait4
/usr/sbin/sshd   -
-bash            wait4
/bin/bash ./chk  wait4
/dbench 32      wait4
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      wait_on_buffer
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
/dbench 32      down
ps -eo cmd,wchan -


> > Kernel panic: Out of memory and no killable processes...
> 
> Someone else did report a similar case. Very strange, doesn't look bio
> related at all. WHat's the entire boot message for a 2.5.2-pre3 boot
> attempt like the above?

I rebuilt 2.5.2-pre3 with mrproper using the config that worked for 2.5.1 
first and noticed some depmod errors during the build:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.2-pre3; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.2-pre3/kernel/fs/nfs/nfs.o
depmod:         seq_escape
depmod:         seq_printf
make[1]: Entering directory `/usr/src/linux/arch/i386/boot'
sh -x ./install.sh 2.5.2-pre3 bzImage /usr/src/linux/System.map "/boot"

So I removed initrd, loopback, nfs, coda, ntfs, dosfs, vfat, and rebuilt
with mrproper.  

Here is the boot message and panic:

LILO 22.1 boot:
Loading lfs.............
Linux version 2.5.2-pre3 (root@mountain) (gcc version 2.95.3 20010315 (release)) #1 Fri Dec 28 12:33:00 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000018000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 98304
zone(0): 4096 pages.
zone(1): 94208 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=lfs ro root=1602 console=ttyS1,38400n8
Initializing CPU#0
Detected 501.155 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 385036k/393216k available (962k kernel code, 7796k reserved, 243k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 256 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.32
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 51536U3, ATA DISK drive
hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
hdc: Maxtor 52049U4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c028dcc4, I/O limit 4095Mb (mask 0xffffffff)
hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=1868/255/63, UDMA(33)
blk: queue c028e054, I/O limit 4095Mb (mask 0xffffffff)
hdc: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=39703/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
 hdc: hdc1 hdc2 hdc3 < hdc5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.22
PCI: Found IRQ 11 for device 00:13.0
IRQ routing conflict for 00:13.0, have irq 9, want irq 11
eth0: RealTek RTL8139 Fast Ethernet at 0xd8800000, 00:50:bf:25:68:f3, IRQ 9
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack (3072 buckets, 24576 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Kernel panic: Out of memory and no killable processes...


> > I re-ran dbench 32, 128 with 2.4.17rc2aa2 on this machine and 
>
> 2.5.1 vs 2.5.2-preX is much more interesting.

2.5.1 finishes dbench 32, 128 on this machine.  :)
Throughput 21.6466 MB/sec (NB=27.0582 MB/sec  216.466 MBit/sec)  32 procs
Throughput 5.91991 MB/sec (NB=7.39989 MB/sec  59.1991 MBit/sec)  128 procs


> (btw, attached patch should fix your highmem oops)
> 
> -- 
> Jens Axboe

I'm going to hold off testing on my highmem box for a while.

BTW, the original "cannot find init" after 2.5.1-pre1 was because
I had an invalid "root=" entry in lilo.conf for the kernels 
other than current and "old".  

-- 
Randy Hron


Return-Path: <linux-kernel-owner+w=401wt.eu-S1756883AbWLIVWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbWLIVWJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbWLIVWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:22:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:49960 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883AbWLIVWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:22:07 -0500
Message-ID: <457B28FC.70800@quantec-networks.de>
Date: Sat, 09 Dec 2006 22:22:04 +0100
From: Vincent Kessler <vincent.kessler@quantec-networks.de>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NPTL and time
Content-Type: multipart/mixed;
 boundary="------------060307040809020002070008"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9aba8ced811918ddd95995e45fa5cc6d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060307040809020002070008
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

i am having quite some problems with nptl and time functions.
Im not sure if it its intended behavior and if its kernel or
glibc related.

The problem is as follows:

A thread waits to an absolute point in time using sem_timedwait.
When sem_timedwait returns, i get different values for various
time related functions.
According to the man page of sem_timedwait it is either based on
CLOCK_REALTIME or on time(). So i would assume that after
timeout neither can return a time lower than the absolute time
passed to sem_timedwait.

I would be very pleased if someone would have a look at this
and explain what is happening.

Ive attached a test program for demonstration.
The problem occurs on a VIA Epia system.
The same test on an AthlonXP machine didnt show this behavior.
Maybe it is hardware related?


With best regards,

Vincent Kessler



Sample output:

Wake_time is the time passed to sem_timedwait.

0xad59ebb0: Woken up at
         iteration                     = 25
         wake_time                     = 1165695594
         time()                        = 1165695593
         ftime()                       = 1165695594.000
         gettimeofday()                = 1165695593.999940
         clock_gettime(CLOCK_REALTIME) = 1165695593.999944620
0x6459ebb0: Woken up at
         iteration                     = 26
         wake_time                     = 1165695596
         time()                        = 1165695595
         ftime()                       = 1165695596.000
         gettimeofday()                = 1165695595.999808
         clock_gettime(CLOCK_REALTIME) = 1165695595.999812200
0x82d9ebb0: Woken up at
         iteration                     = 57
         wake_time                     = 1165695658
         time()                        = 1165695657
         ftime()                       = 1165695658.000
         gettimeofday()                = 1165695657.999934
         clock_gettime(CLOCK_REALTIME) = 1165695657.999937606
0x9ed9ebb0: Woken up at
         iteration                     = 58
         wake_time                     = 1165695660
         time()                        = 1165695659
         ftime()                       = 1165695660.000
         gettimeofday()                = 1165695659.999822
         clock_gettime(CLOCK_REALTIME) = 1165695659.999825580
0xb2d9ebb0: Woken up at
         iteration                     = 88
         wake_time                     = 1165695720
         time()                        = 1165695719
         ftime()                       = 1165695720.000
         gettimeofday()                = 1165695719.999999
         clock_gettime(CLOCK_REALTIME) = 1165695720.000002669
0x5659ebb0: Woken up at
         iteration                     = 89
         wake_time                     = 1165695722
         time()                        = 1165695721
         ftime()                       = 1165695722.000
         gettimeofday()                = 1165695721.999878
         clock_gettime(CLOCK_REALTIME) = 1165695721.999881424




I am using a 2.6.19 vanilla kernel with
glibc 2.4 and gcc 4.1.1 on gentoo linux.

Testprogram was compiled like this:
g++ -c -I.   -Os -fomit-frame-pointer -march=i586 -pipe -Wall -Werror 
-std=gnu++98 -MD -MP -MF .dep/time_test.o.d time_test.cpp -o time_test.o

g++ -I.   -Os -fomit-frame-pointer -march=i586 -pipe -Wall -Werror 
-std=gnu++98 -MD -MP -MF .dep/time_test.elf.d time_test.o --output 
time_test.elf -lpthread -lrt

# gcc -v
Using built-in specs.
Target: i686-pc-linux-gnu
Configured with: /var/tmp/portage/gcc-4.1.1-r1/work/gcc-4.1.1/configure 
--prefix=/usr --bindir=/usr/i686-pc-linux-gnu/gcc-bin/4.1.1 
--includedir=/usr/lib/gcc/i686-pc-linux-gnu/4.1.1/include 
--datadir=/usr/share/gcc-data/i686-pc-linux-gnu/4.1.1 
--mandir=/usr/share/gcc-data/i686-pc-linux-gnu/4.1.1/man 
--infodir=/usr/share/gcc-data/i686-pc-linux-gnu/4.1.1/info 
--with-gxx-include-dir=/usr/lib/gcc/i686-pc-linux-gnu/4.1.1/include/g++-v4 
--host=i686-pc-linux-gnu --build=i686-pc-linux-gnu --disable-altivec 
--enable-nls --without-included-gettext --with-system-zlib 
--disable-checking --disable-werror --disable-libunwind-exceptions 
--disable-multilib --disable-libmudflap --disable-libssp 
--disable-libgcj --enable-languages=c,c++ --enable-shared 
--enable-threads=posix --enable-__cxa_atexit --enable-clocale=gnu
Thread model: posix
gcc version 4.1.1 (Gentoo 4.1.1-r1)

# ld -v
GNU ld version 2.16.1

# uname -a
Linux unnamed 2.6.19 #2 PREEMPT Sun Dec 3 22:18:08 CET 2006 i686 VIA 
Nehemiah CentaurHauls GNU/Linux

# cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 9
model name      : VIA Nehemiah
stepping        : 8
cpu MHz         : 666.582
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr cx8 sep mtrr pge cmov pat mmx 
fxsr sse rng rng_en ace ace_en
bogomips        : 1334.45

# dmesg
Linux version 2.6.19 (root@station3) (gcc version 4.1.1 (Gentoo 
4.1.1-r1)) #2 PREEMPT Sun Dec 3 22:18:08 CET 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)
  BIOS-e820: 000000001eff0000 - 000000001eff3000 (ACPI NVS)
  BIOS-e820: 000000001eff3000 - 000000001f000000 (ACPI data)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
495MB LOWMEM available.
Entering add_active_range(0, 0, 126960) 0 entries of 256 used
Zone PFN ranges:
   DMA             0 ->     4096
   Normal       4096 ->   126960
early_node_map[1] active PFN ranges
     0:        0 ->   126960
On node 0 totalpages: 126960
   DMA zone: 32 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 4064 pages, LIFO batch:0
   Normal zone: 959 pages used for memmap
   Normal zone: 121905 pages, LIFO batch:31
DMI 2.2 present.
ACPI: RSDP (v000 VT9174                                ) @ 0x000f6550
ACPI: RSDT (v001 VT9174 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1eff3000
ACPI: FADT (v001 VT9174 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1eff3040
ACPI: DSDT (v001 VT9174 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 20000000 (gap: 1f000000:e0ff0000)
Detected 666.582 MHz processor.
Built 1 zonelists.  Total pages: 125969
Kernel command line: root=/dev/hda1 ide=nodma
ide_setup: ide=nodma : Prevented DMA
No local APIC present or hardware disabled
mapped APIC to ffffd000 (013e2000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 499876k/507840k available (2016k kernel code, 7420k reserved, 
652k data, 160k init, 0k highmem)
virtual kernel memory layout:
     fixmap  : 0xfffb6000 - 0xfffff000   ( 292 kB)
     vmalloc : 0xdf800000 - 0xfffb4000   ( 519 MB)
     lowmem  : 0xc0000000 - 0xdeff0000   ( 495 MB)
       .init : 0xc039e000 - 0xc03c6000   ( 160 kB)
       .data : 0xc02f8253 - 0xc039b40c   ( 652 kB)
       .text : 0xc0100000 - 0xc02f8253   (2016 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1334.45 BogoMIPS 
(lpj=2668900)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0381b83f 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 64K (32 bytes/line)
CPU: After all inits, caps: 0381b93f 00000000 00000000 00000000 00000000 
000000dd 00000000
Compat vDSO mapped to ffffe000.
CPU: Centaur VIA Nehemiah stepping 08
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 1e20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfa960, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by vt8235 PM
PCI quirk: region 0500-050f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: e4000000-e5ffffff
   PREFETCH window: e0000000-e3ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 2 throttling states)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA CLE266 chipset
agpgart: AGP aperture is 4M @ 0xe6000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
eth0: VIA Rhine II at 0x1e000, 00:40:63:e1:88:6c, IRQ 11.
eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 41e1.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP MPPE Compression module registered
NET: Registered protocol family 24
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
     ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SanDisk SDCFB-512, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 1000944 sectors (512 MB) w/1KiB Cache, CHS=993/16/63
  hda: hda1
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
CAPI Subsystem Rev 1.1.2.8
capi20: Rev 1.1.2.7: started up with major 68 (middleware+capifs)
capifs: Rev 1.1.2.3
GRE over IPv4 tunneling driver
ip_conntrack version 2.4 (3967 buckets, 31736 max) - 228 bytes per conntrack
ip_conntrack_pptp version 3.1 loaded
ip_nat_pptp version 3.0 loaded
ip_tables: (C) 2000-2006 Netfilter Core Team
ClusterIP Version 0.8 loaded successfully
arp_tables: (C) 2002 David S. Miller
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
Time: tsc clocksource has been installed.
kjournald starting.  Commit interval 5 seconds
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
Time: acpi_pm clocksource has been installed.



-- 
Vincent Kessler                    Quantec Networks GmbH
Software Engineering               Herderstrasse 3
phone: +49-5139-893515             30916 Isernhagen, Germany
fax:   +49-5139-893516             www.quantec-networks.de

--------------060307040809020002070008
Content-Type: text/plain;
 name="time_test.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="time_test.cpp"


#include <stdio.h>
#include <semaphore.h>
#include <sys/timeb.h>
#include <sys/time.h>
#include <errno.h>
#include <string.h>
#include <pthread.h>
#include <time.h>


#define NUM_THREADS		200
#define INTERVAL		2

void* worker_thread(void *p_argument)
{
	int iIteration = 0;
	sem_t wake_semaphore;
	sem_init(&wake_semaphore, 0, 0);

	while (1)
	{
		iIteration++;
		struct timeb current_time;
		struct timeval current_timeofday;
		struct timespec clock_realtime;

		//Calculate next wake time
		ftime(&current_time);
		time_t wake_time = current_time.time + (INTERVAL - (current_time.time % INTERVAL));

		//Setup abstime struct for sem_timedwait
		struct timespec timeout;
		timeout.tv_sec = (long)wake_time;
		timeout.tv_nsec = 0;

		int result = sem_timedwait(&wake_semaphore, &timeout);

		//Get various time sources
		time_t time_time = time(NULL);
		ftime(&current_time);
		gettimeofday(&current_timeofday, NULL);
		clock_gettime(CLOCK_REALTIME, &clock_realtime);


		if (result != -1 && errno != ETIMEDOUT)
		{
			printf("%p: Error: sem_timedwait returned %u (%s)\n", (void*)pthread_self(), result, strerror(errno));
		}
		else
		{
			if (current_time.time != wake_time ||
				time(NULL) != wake_time ||
				current_timeofday.tv_sec != wake_time ||
				clock_realtime.tv_sec != wake_time)
			{
				printf("%p: Woken up at\n"
					"\titeration                     = %u\n"
					"\twake_time                     = %lu\n"
					"\ttime()                        = %lu\n"
					"\tftime()                       = %lu.%03u\n"
					"\tgettimeofday()                = %lu.%06lu\n"
					"\tclock_gettime(CLOCK_REALTIME) = %lu.%09lu\n", 
					(void*)pthread_self(), 
					iIteration, 
					wake_time,
					time_time,
					current_time.time,
					current_time.millitm,
					current_timeofday.tv_sec,
					current_timeofday.tv_usec,
					clock_realtime.tv_sec,
					clock_realtime.tv_nsec);
			}
		}
	}
	pthread_exit(0);
	return 0;
}



int main(int argc, char **ppargv)
{
	int i;
	pthread_t thread_handler_list[NUM_THREADS];

	for (i = 0; i < NUM_THREADS; i++)
	{
		if (pthread_create(&thread_handler_list[i], NULL, &worker_thread, NULL))
		{
			printf("Error creating thread no %u. %s\n", i, strerror(errno));
			return -1;
		}
	}

	pthread_join(thread_handler_list[0], NULL);


	return 0;
}

--------------060307040809020002070008--

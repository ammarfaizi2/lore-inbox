Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbRHASpo>; Wed, 1 Aug 2001 14:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267962AbRHASpf>; Wed, 1 Aug 2001 14:45:35 -0400
Received: from web13605.mail.yahoo.com ([216.136.175.116]:24595 "HELO
	web13605.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267940AbRHASpa>; Wed, 1 Aug 2001 14:45:30 -0400
Message-ID: <20010801184538.25407.qmail@web13605.mail.yahoo.com>
Date: Wed, 1 Aug 2001 11:45:38 -0700 (PDT)
From: Ivan Kalvatchev <iive@yahoo.com>
Subject: tmpfs trash the system
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.  It is possible for every user that have write
access to tmpfs mounted filesystem to lock the system.
2.  Why tmpfs have status of stable? 
This filesystem have limit checking and the output of
df shows that all free ram+swap is usable for this
filesystem. The problem comes then some process tries
to get all free space. 
The problem raise when free memory drops under
freepages.low, then kswapd starts swapping
aggressively. Then the system gets trashed (and maybe
free memory gets under freepages.low. look at SysRq
Meminfo at the bottom). 
I didn't dig in the source but i think that
immediately after one page is swapped out (discarded)
it is filled with data and at some point no more pages
are freed or just freed pages are reallocated. At this
point all non kernel processed are stopped and
computer is working on swap.
In this state i can switch virtual consoles, the hard
is working, and i can type on the screen. The programs
lock when i try to do something with them (maybe when
they allocate memory or when they need swapped
pages?). 
This could be "virtual memory" bug ( no free memory),
but it could be surrounded just by decreasing tmpfs
free space to (freemem - freepages.high).
The same horrible think happens to ramfs, but this
could be expected. Ramfs don't have size check so that
hack cannot be used for it.  In this case ramfs must
be marked as dangerous. 
I had very interesting conversation with some person
in the chat, that could not reproduce the bug, and he
told me to decrease memory that tmpfs could allocate.
But this just make problem harder to reproduce. The
same situation will raise if some process allocates
enough memory. Oh, and him kernel was patched with
some patche2.4.5-ac22.
3. filesystem. virtual memory, swap, kernel
4. Kernel-2.4.7, 2.4.6, 2.4.5, 2.4.4 ... (all with
tmpfs, without one with only shmfs)
5. 
6.
mkdir /mnt/tmp
mount tmpfs /mnt/tmp -o tmpfs 
dd if=/dev/zero if=/mnt/tmp/test

or just use /dev/shm as described  in Configure.help
7. Slackware8 and Slackware7.1
The logs bellow are made in stable state. I cannot
save logs when trashed:( 
I need at least second computer.(maybe later)
The last log if written on paper then on PC.

7.1  
--------------------------------------------------------------------
If some fields are empty or look unusual you may have
an old version.
Compare to the current minimal requirements in
Documentation/Changes.
 
Linux darkstar 2.4.7 #2 Tue Jul 24 19:53:07 EEST 2001
i586 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.26
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         nls_iso8859-1
------------------------------------------------------------------
7.2
------------------------------------------------------------------
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 6
model name	: AMD-K6tm w/ multimedia extensions
stepping	: 2
cpu MHz		: 200.459
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx
bogomips	: 399.76
------------------------------------------------------------------
7.3
------------------------------------------------------------------
nls_iso8859-1           2880   2 (autoclean)
------------------------------------------------------------------
7.4

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-09ffffff : System RAM
  00100000-001de671 : Kernel code
  001de672-0023509f : Kernel data
e0000000-e3ffffff : S3 Inc. ViRGE/DX or /GX
e4000000-e4ffffff : 3Dfx Interactive, Inc. Voodoo 2
ffff0000-ffffffff : reserved
------------------------------------------------------------------
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-0101 : OPL3-SA3
01f0-01f7 : ide0
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0300-0301 : mpu401
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e80-0e83 : WSS config
0e84-0e87 : MS Sound System
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
6400-641f : Intel Corporation 82371AB PIIX4 USB
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1
//-----------------------------------------------------------------
7.5
-----------------------------------------------------------------
00:00.0 Host bridge: Intel Corporation 430TX - 82439TX
MTXC (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4
ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4
IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB
PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 6400 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI
(rev 01)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0b.0 Multimedia video controller: 3Dfx Interactive,
Inc. Voodoo 2 (rev 02)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e4000000 (32-bit, prefetchable)
[size=16M]

00:0c.0 VGA compatible controller: S3 Inc. ViRGE/DX or
/GX (rev 01) (prog-if 00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit,
non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
-----------------------------------------------------------------------------
7.6
//
//
7.7 
/proc/meminfo
-----------------------------------------------------------------------------
        total:    used:    free:  shared: buffers: 
cached:
Mem:  163082240 54480896 108601344        0  3723264
40349696
Swap: 139821056        0 139821056
MemTotal:       159260 kB
MemFree:        106056 kB
MemShared:           0 kB
Buffers:          3636 kB
Cached:          39404 kB
SwapCached:          0 kB
Active:           3572 kB
Inact_dirty:     39468 kB
Inact_clean:         0 kB
Inact_target:        0 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       159260 kB
LowFree:        106056 kB
SwapTotal:      136544 kB
SwapFree:       136544 kB
-----------------------------------------------------------------------------

/proc/swaps
-----------------------------------------------------------------------------
Filename			Type		Size	Used	Priority
/dev/hda4                       partition	136544	0	-1
-----------------------------------------------------------------------------

mount
-----------------------------------------------------------------------------
/dev/hda3 on / type ext2 (rw)
/dev/hda1 on /mnt/hard type vfat (rw)
/dev/hda5 on /mnt/d type vfat (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /proc type proc (rw)
tmpfs on /dev/shm type tmpfs (rw)
-----------------------------------------------------------------------------
df
------------------------------------------------------------------
Filesystem           1k-blocks      Used Available
Use% Mounted on
/dev/hda3              1991824   1834820     54188 
98% /
/dev/hda1              2096160   1920352    175808 
92% /mnt/hard
/dev/hda5              3952252   3856036     96216 
98% /mnt/d
tmpfs                   242424         0    242424  
0% /dev/shm

------I wrote this on paper then back on PC. At this
point nothing wok-----
SysRq: Show Memory
Mem_info:
Free pages:        1524kB (    0 kB HighMem)
( Active: 37842, inactive_dirty: 29, inactive_clean:
0, free: 381 (383 766 1149) )
1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB
0*512kB 0*1024kB 0*2048kB = 508kB
0*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB
1*512kB 0*1024kB 0*2048kB = 1016kB)
= 0kB)
Swap cache: add 34136, delete 34136, find 0/0
Free swap:            0kB
40960 pages of RAM
0 pages of HIGHMEM
1147 reserved pages
430 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:       60kB
-----------------------------------------
I pressed few times Alt-SysRq-M, and i noted that
Active has changed with +-1



__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/

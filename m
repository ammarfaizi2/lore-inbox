Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbQLBIrx>; Sat, 2 Dec 2000 03:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbQLBIrm>; Sat, 2 Dec 2000 03:47:42 -0500
Received: from smtp-2u-1.atlantic.net ([209.208.25.2]:35084 "EHLO
	smtp-2u-1.atlantic.net") by vger.kernel.org with ESMTP
	id <S129729AbQLBIr3>; Sat, 2 Dec 2000 03:47:29 -0500
Date: Sat, 2 Dec 2000 04:19:35 -0500 (EST)
From: Burton Windle <burton@fint.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 240t12p3: Reproducable Oops
Message-ID: <Pine.LNX.4.21.0012020403310.20972-100000@fint.staticky.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
PROBLEM: 240t12p3: Reproducable oops involving ping

[2.] Full description of the problem/report:
While teaching myself Perl, I've either demonstrated a compiler error, or
appear to have found a way to make the 2.4.0-test12-pre3 kernel oops
reproducably many times.  Perhaps the kernel is just scared of my poor
Perl, but something doesn't like it. I was originally trying to see what a
full arpcache would like like, but then was having fun annoying my
roommates with ping storms when my die got more annoyed.

[3.] Keywords (i.e., modules, networking, kernel):
2.4.0-test12-pre3 oops ping

[4.] Kernel version (from /proc/version):
Linux version 2.4.0-test12-pre3 (root@toy) (gcc version 2.95.2 20000220
(Debian GNU/Linux)) #1 Wed Nov 29 11:53:59 EST 2000


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
Note: the oops happens many many times in a row, so much that it fills my
dmesg. This is the first entire oops that I can see, but all the ones
after this look very very similar.

ksymoops 2.3.4 on i586 2.4.0-test12-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12-pre3/ (default)
     -m /usr/src/linux/System.map (specified)

Unable to handle kernel paging request at virtual address cc012078
c0125ef0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0125ef0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010803
eax: 02000018   ebx: c11ffc14   ecx: 44012720   edx: c4012000
esi: 00000246   edi: 00000007   ebp: c1d15d40   esp: c4adff38
ds: 0018   es: 0018   ss: 0018
Process manyping.pl (pid: 478, stackpage=c4adf000)
Stack: c450a000 fffffff4 c21ff620 c01162e6 c11ffc14 00000007 c4ade000
080fa490
       00000004 c4adffbc c21ff620 c4adff94 00000000 c4ade000 c4c23920
c21ff62c
       fffffff4 fffffff4 00000000 00000000 00000000 c4adffa0 c4adffa0
00000000
Call Trace: [<c01162e6>] [<c010944f>] [<c010aa03>]
Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89

>>EIP; c0125ef0 <kmem_cache_alloc+24/54>   <=====
Trace; c01162e6 <do_fork+5be/940>
Trace; c010944f <sys_fork+13/18>
Trace; c010aa03 <system_call+33/40>
Code;  c0125ef0 <kmem_cache_alloc+24/54>
00000000 <_EIP>:
Code;  c0125ef0 <kmem_cache_alloc+24/54>   <=====
   0:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax   <=====
Code;  c0125ef4 <kmem_cache_alloc+28/54>
   4:   89 42 14                  mov    %eax,0x14(%edx)
Code;  c0125ef7 <kmem_cache_alloc+2b/54>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c0125efa <kmem_cache_alloc+2e/54>
   a:   75 05                     jne    11 <_EIP+0x11> c0125f01 <kmem_cache_alloc+35/54>
Code;  c0125efc <kmem_cache_alloc+30/54>
   c:   8b 02                     mov    (%edx),%eax
Code;  c0125efe <kmem_cache_alloc+32/54>
   e:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  c0125f01 <kmem_cache_alloc+35/54>
  11:   56                        push   %esi
Code;  c0125f02 <kmem_cache_alloc+36/54>
  12:   9d                        popf   
Code;  c0125f03 <kmem_cache_alloc+37/54>
  13:   89 00                     mov    %eax,(%eax)


[6.] A small shell script or example program which triggers the
     problem (if possible)
swapoff -a
cat manyping.pl
#!/usr/bin/perl -w

@ip = (1 .. 255);
foreach (@ip) {
    system("ping -c 40 -s 5000 192.168.0.$_ &");
}

I was backgrounding the above program (./manyping.pl &), and running it
with several (15?) instances at the same time.

[7.] Environment
This is an up-to-date Debian Woody system.

[7.1.] Software (add the output of the ver_linux script here)
Linux toy 2.4.0-test12-pre3 #1 Wed Nov 29 11:53:59 EST 2000 i586 unknown
Kernel modules         2.3.21
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0i
Modules Loaded         rtc es1371 ac97_codec ne 8390

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 12
cpu MHz		: 400.901
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
features	: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips	: 799.54

[7.3.] Module information (from /proc/modules):
rtc                     5280   0 (autoclean)
es1371                 24400   0
ac97_codec              7504   0 [es1371]
ne                      6352   1
8390                    6064   0 [ne]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
toy:~# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0280-029f : eth0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5c20-5c3f : PCI device 10b9:7101
d000-d00f : PCI device 10b9:5229
d400-d4ff : PCI device 121a:0005
d800-d83f : PCI device 1274:1371
  d800-d83f : es1371

toy:~# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-06ffffff : System RAM
  00100000-002260a7 : Kernel code
  002260a8-00239b83 : Kernel data
dc000000-ddffffff : PCI device 121a:0005
e0000000-e3ffffff : PCI device 10b9:1541
e6000000-e7ffffff : PCI device 121a:0005
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP System Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [b0] AGP version 1.0
		Status: RQ=28 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e0000000-dfffffff
	Prefetchable memory behind bridge: e8000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at d800 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at e6000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at d400 [size=256]
	Expansion ROM at 000c0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at d000 [size=16]


[7.6.] SCSI information (from /proc/scsi/scsi)
n/a
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
This happened originally when I was in X. I rebooted, and was able to
reproduce it on the console before any DRI stuff loaded. 


[X.] Other notes, patches, fixes, workarounds:

I am on LK, but please CC replys to me. Thank you!

-- 
Burton Windle				burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux/init/main.c:1384

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

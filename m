Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSEUXLH>; Tue, 21 May 2002 19:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316774AbSEUXLG>; Tue, 21 May 2002 19:11:06 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:33797 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S316770AbSEUXLB>; Tue, 21 May 2002 19:11:01 -0400
Date: Wed, 22 May 2002 01:11:00 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: samba@samba.org
Subject: smbfs related oops
Message-ID: <Pine.LNX.4.44.0205211919370.1752-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

[1.] One line summary of the problem:

rsync segfaulting and the kernel oops'ing while synchronizing two smbfs's

[2.] Full description of the problem/report:

I am implementing file synchronization between two Windows NT 4 machines 
through two smbfs mounts. Rsync runs for about half an hour; then the 
kernel gives an oops and rsync segfaults. Hereafter the smbfs file 
system is un-unmountable, even with umount -f (device or resource busy).

[3.] Keywords (i.e., modules, networking, kernel):

smbfs, networking

[4.] Kernel version (from /proc/version):

Linux version 2.4.18 (root@gere) (gcc version 2.95.2 20000220 (Debian 
GNU/Linux)) #2 man maj 6 15:05:32 CEST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Eh, this is quite embarrassing. I cannot decode the oops... Ksymoops 
2.4.3 just leaves the oops intact without symbolic information. 
System.map is in place, smbfs is compiled in-kernel (not as a module):

ksymoops 2.4.3 on i586 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Unable to handle kernel paging request at virtual address c4000000
c0167277
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0167277>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: f84e461a   ebx: ab5d031e   ecx: fcb613fd   edx: 00000000
esi: c4000000   edi: c1c8fe4c   ebp: c1c8fee4   esp: c1c8fdfc
ds: 0018   es: 0018   ss: 0018
Process rsync (pid: 2428, stackpage=c1c8f000)
Stack: c1c8fee4 c1c8feb4 c48378a8 00000000 00000000 00000000 00000000 c2874a40 
       c004f0e0 00000000 00189621 00000000 00000000 00000000 c07a5000 00000012 
       00000000 00000000 00000001 00000014 c0165ba5 c1c6ea20 c1c8ffb0 c01369c0 
Call Trace: [<c0165ba5>] [<c01369c0>] [<c01369c0>] [<c0165c34>] [<c01369c0>] 
   [<c0166ae6>] [<c01369c0>] [<c01367a9>] [<c01369c0>] [<c0136ae2>] [<c01369c0>] 
   [<c0106b33>] 
Code: 0f b6 56 00 46 89 d0 c1 e0 04 01 d8 c1 ea 04 01 d0 6b d8 0b 

[6.] A small shell script or example program which triggers the
     problem (if possible)

smbmount //odin/e\$ /bck/mnt -o username=xxx,password=xxx
smbmount //frigg/backup /bck/backup -o username=xxx,password=xxx
cd /bck
# Also happens with -aq but this prints more info
rsync -avv --delete Dokumenter2 /bck/backup

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Debian potato w/kernel 2.4.18

Linux gere 2.4.18 #2 man maj 6 15:05:32 CEST 2002 i586 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux             2.10s
mount                  2.10s
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Kbd                    [muligheder...]
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         nls_iso8859-1

moffe@gere:~# dpkg -l | grep samba
ii  samba          2.0.7-5        A LanManager like file and printer server fo
ii  samba-common   2.0.7-5        Samba common files used by both the server a

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 6
model name      : AMD-K6tm w/ multimedia extensions
stepping        : 2
cpu MHz         : 233.285
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 465.30

[7.3.] Module information (from /proc/modules):

nls_iso8859-1           2844   2 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

moffe@gere:~# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
7000-707f : 3Com Corporation 3c905C-TX [Fast Etherlink]
  7000-707f : 00:04.0
7400-74ff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
7800-780f : Acer Laboratories Inc. [ALi] M5229 IDE
  7800-7807 : ide0
  7808-780f : ide1
moffe@gere:~# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-001d43f9 : Kernel code
  001d43fa-0020dc37 : Kernel data
05100000-0510007f : 3Com Corporation 3c905C-TX [Fast Etherlink]
05101000-05101fff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
06000000-06ffffff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV] (rev b2)
        Subsystem: Acer Laboratories Inc. [ALi]: Unknown device 1531
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 set

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev b4)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0 set

00:04.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
        Subsystem: 3Com Corporation: Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 min, 10 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 7000 [size=128]
        Region 1: Memory at 05100000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 05120000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:06.0 VGA compatible controller: ATI Technologies Inc 3D Rage II+ 
215GTB [Mach64 GTB] (rev 9a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 4755
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 32 set, cache line size 08
        Region 0: Memory at 06000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 7400 [size=256]
        Region 2: Memory at 05101000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 05140000 [disabled] [size=128K]

00:0b.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 4 max, 32 set
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at 7800 [size=16]

[7.6.] SCSI information (from /proc/scsi/scsi)

No SCSI

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

It seems to happen when reading from the source share, as this share 
hangs when unmounting, but not the destination share.

In my searches for the offending files, I did:

moffe@gere:/tmp/mnt# tar cvf - Dokumenter2 | cat > /dev/null
[...]
Dokumenter2/sager/Steins/981024.Steins/4301044.D/PAHSIM.M/QUANT_DB.3
Dokumenter2/sager/Steins/981024.Steins/4301044.D/PAHSIM.M/RPTDEF.XLS
Dokumenter2/sager/Steins/981024.Steins/SEQUENCE.LOG
Dokumenter2/sager/Steins/981201.Steins/
Dokumenter2/sager/Steins/981201steins/
Segmentation fault
moffe@gere:/tmp/mnt#

(no, don't laugh; tar actually does nothing when doing "tar cvf 
/dev/null [...]" or "tar cvf - [...] > /dev/null")

[X.] Other notes, patches, fixes, workarounds:

The server has around 10Gb of data in 120.000 files (this Share contains 
most of the data by bytes, but around 30.000 files I guess). The Windows 
machine is Windows NT 4.0 service pack 6a. No file system errors on 
Linux nor Windows.

I'm not quite into kernel programming, so I'm somewhat at a loss as to 
what to do - but I will gladly tell more information, if I'm able to.

Regards
/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
May the smurf be with you... Always.
                 -- Obi-Smurf Kenobi
----------------------------------[ moffe at amagerkollegiet dot dk ] --





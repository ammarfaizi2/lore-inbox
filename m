Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315423AbSFMS0b>; Thu, 13 Jun 2002 14:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSFMS0a>; Thu, 13 Jun 2002 14:26:30 -0400
Received: from wkamphuis.student.utwente.nl ([130.89.163.252]:9993 "HELO
	wkamphuis.student.utwente.nl") by vger.kernel.org with SMTP
	id <S315423AbSFMS0X>; Thu, 13 Jun 2002 14:26:23 -0400
Message-ID: <3D08E3E1.7050408@wkamphuis.student.utwente.nl>
Date: Thu, 13 Jun 2002 20:26:41 +0200
From: Wolter Kamphuis <kernel@wkamphuis.student.utwente.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Two panic's while burning +700Mb file to cdr (2.4.19-pre7+)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm unsuccessfully trying to backup a large 738Mb file to cdr. While burning 
this file the machine panic's. Doing a emergency sync (alt+sysrq+s) or emergency 
unmount (alt+sysrq+u) gives an second panic.

I had to write the panic-output down by hand, the machine refused to sync, 
unmount or do anything at all. I hope the information below is usefull in 
finding and fixing the bug.

thanks in advance,
   Wolter Kamphuis


btw. I know that 738Mb won't fit on an 80min. cdr so cdrecord should give an 
error, a kernel-panic should not happen. Burning smaller files (700Mb) goes 
without problems. I tried burning the file 3 times, all resulting in the same panic.




the report:

=======================================
[1.] One line summary of the problem:
While burning a 738Mb file to a 80min cdr the machine panics. The panic is 
easily re-creatable.


=======================================
[2.] Full description of the problem/report:
While burning a (too) large file to cdr the machine panics. I'm using quality 
80min. cdr's and a Teac CD-W54E ide cdrw-burner. The panic happens every time I 
try to burn this single file, I tried it 3 times. Burning smaller files (700Mb) 
goes without problems.

The file is readable, copying the file or cat'ting to /dev/null doesn't give any 
problems. The cdrw-burner is connected to the primary ide-channel (ide-master), 
together with a Teac CD-540E cdrom-drive (ide-slave). I guess the problem must 
be somewhere in the ide-scsi module.


=======================================
[3.] Keywords (i.e., modules, networking, kernel):
ide-scsi, cdrecord, large file, panic


=======================================
[4.] Kernel version (from /proc/version):
Linux version 2.4.19-pre10-ac1 (root@wkamphuis.student.utwente.nl) (gcc version 
2.95.3 20010315 (release)) #1 Wed Jun 5 19:43:12 CEST 2002

The first time I got this problem I was running 2.4.19-pre7 with the low-latency 
patch, after upgrading to 2.4.19-pre10-ac1 I found the problem also occurs on 
this kernel. I've not tried any other kernels.


=======================================
[5.] Output of Oops.. message with symbolic information
Bug #1, during buring the (too) large file to cdr.

root@wkamphuis:~# ksymoops /tmp/panic1.txt
ksymoops 2.4.5 on i686 2.4.19-pre10-ac1.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.19-pre10-ac1/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

unable to handle kernel paging request at virtual address 80417c98
Oops: 0002
CPU: 0
EIP: 0010:[<d08795d3>] not tained
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000051 ebx: c14d0000 ecx: c02c0f00 edx: 000001f7
esi: ca09f440 edi: 80417c80 ebp: c02c0f44 esp: c22b5f48
ds: 0018 es: 0018 ss: 0018
Process nmbd(pid: 375, stackpage=c22b500)
Stack: c02c0f44 c1398080 00000286 c02c0f00 00000002 c02c0f51 c019823d c02c0f44
        c135f700 04000001 0000000e c22b5fc4 d0879560 c0109acf 0000000e c1398080
        c22b5fc4 00000380 c029bc80 0000000e c22b5fbc c0109c4e 0000000e c22b5fc4
Call Trace: [<c019823d>] [<d0879560>] [<c0109acf>] [<c0109c4e>] [<c010bc08>]
Code: ff 47 18 6a 01 55 e8 02 fd ff ff 31 c0 83 c4 08 e9 b1 01 00


 >>EIP; d08795d3 <END_OF_CODE+7fda214/????>   <=====

 >>ebx; c14d0000 <_end+12097f0/85777f0>
 >>ecx; c02c0f00 <ide_hwifs+0/21c0>
 >>esi; ca09f440 <END_OF_CODE+1800081/????>
 >>edi; 80417c80 Before first symbol
 >>ebp; c02c0f44 <ide_hwifs+44/21c0>
 >>esp; c22b5f48 <_end+1fef738/85777f0>

Trace; c019823d <ide_intr+bd/120>
Trace; d0879560 <END_OF_CODE+7fda1a1/????>
Trace; c0109acf <handle_IRQ_event+2f/60>
Trace; c0109c4e <do_IRQ+6e/b0>
Trace; c010bc08 <call_do_IRQ+5/d>

Code;  d08795d3 <END_OF_CODE+7fda214/????>
00000000 <_EIP>:
Code;  d08795d3 <END_OF_CODE+7fda214/????>   <=====
    0:   ff 47 18                  incl   0x18(%edi)   <=====
Code;  d08795d6 <END_OF_CODE+7fda217/????>
    3:   6a 01                     push   $0x1
Code;  d08795d8 <END_OF_CODE+7fda219/????>
    5:   55                        push   %ebp
Code;  d08795d9 <END_OF_CODE+7fda21a/????>
    6:   e8 02 fd ff ff            call   fffffd0d <_EIP+0xfffffd0d> d08792e0 
<END_OF_CODE+7fd9f21/????>
Code;  d08795de <END_OF_CODE+7fda21f/????>
    b:   31 c0                     xor    %eax,%eax
Code;  d08795e0 <END_OF_CODE+7fda221/????>
    d:   83 c4 08                  add    $0x8,%esp
Code;  d08795e3 <END_OF_CODE+7fda224/????>
   10:   e9 b1 01 00 00            jmp    1c6 <_EIP+0x1c6> d0879799 
<END_OF_CODE+7fda3da/????>

  <0>Kernel panic: Aieee, killing interrupt handler!

1 warning issued.  Results may not be reliable.




Bug #2, after the first panic, trying to sync using alt+sysrq+s:
root@wkamphuis:~# ksymoops /tmp/panic2.txt
ksymoops 2.4.5 on i686 2.4.19-pre10-ac1.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.19-pre10-ac1/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Syncing device 08:02 ... kernel BUG at sched.c:729!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c0112628>] Not tained
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 0010202
eax: 00000051 ebx: c14d0000 ecx: c02c0f00 edx: 000001f7
esi: ca09f440 edi: 80417c80 ebp: c02c0f44 esp: c22b5f48
ds: 0018 es: 0018 ss: 0018
Process nmbd(pid: 375, stackpage=c22b500)
Stack: c02c0f44 c1398080 00000286 c02c0f00 00000002 c02c0f51 c019823d c02c0f44
        c135f700 04000001 0000000e c22b5fc4 d0879560 c0109acf 0000000e c1398080
        c22b5fc4 00000380 c029bc80 0000000e c22b5fbc c0109c4e 0000000e c22b5fc4
Call Trace: [<c019823d>] [<d0879560>] [<c0109acf>] [<c0109c4e>] [<c010bc08>]
Code: 0f 0b d9 02 ec b0 21 c0 b8 00 e0 ff ff 21 e0 89 45 fc a1 24


 >>EIP; c0112628 <schedule+18/230>   <=====

 >>ebx; c14d0000 <_end+12097f0/85777f0>
 >>ecx; c02c0f00 <ide_hwifs+0/21c0>
 >>esi; ca09f440 <END_OF_CODE+1800081/????>
 >>edi; 80417c80 Before first symbol
 >>ebp; c02c0f44 <ide_hwifs+44/21c0>
 >>esp; c22b5f48 <_end+1fef738/85777f0>

Trace; c019823d <ide_intr+bd/120>
Trace; d0879560 <END_OF_CODE+7fda1a1/????>
Trace; c0109acf <handle_IRQ_event+2f/60>
Trace; c0109c4e <do_IRQ+6e/b0>
Trace; c010bc08 <call_do_IRQ+5/d>

Code;  c0112628 <schedule+18/230>
00000000 <_EIP>:
Code;  c0112628 <schedule+18/230>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c011262a <schedule+1a/230>
    2:   d9 02                     flds   (%edx)
Code;  c011262c <schedule+1c/230>
    4:   ec                        in     (%dx),%al
Code;  c011262d <schedule+1d/230>
    5:   b0 21                     mov    $0x21,%al
Code;  c011262f <schedule+1f/230>
    7:   c0 b8 00 e0 ff ff 21      sarb   $0x21,0xffffe000(%eax)
Code;  c0112636 <schedule+26/230>
    e:   e0 89                     loopne ffffff99 <_EIP+0xffffff99> c01125c1 
<scheduler_tick+221/260>
Code;  c0112638 <schedule+28/230>
   10:   45                        inc    %ebp
Code;  c0112639 <schedule+29/230>
   11:   fc                        cld
Code;  c011263a <schedule+2a/230>
   12:   a1 24 00 00 00            mov    0x24,%eax

  <0>Kernel panic: Aieee, killing interrupt handler!

1 warning issued.  Results may not be reliable.



=======================================
[6.] A small shell script or example program which triggers the problem
mkisofs -l -J -r /a/large/file | cdrecord dev=1,0,0 speed=4 fs=8m -data -v -v -

mkisofs 1.14 (i686-pc-linux-gnu)
Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling


=======================================
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
The machine is a home-made linux-from-scratch system made according to the 
linux-from-scratch 3.1 book. I compiled everything myself on this machine.

root@wkamphuis:~# /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux wkamphuis.student.utwente.nl 2.4.19-pre10-ac1 #1 Wed Jun 5 19:43:12 CEST 
2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11m
mount                  2.11m
modutils               2.4.12
e2fsprogs              1.25
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         ipt_limit ipt_LOG ipt_REJECT ipt_MASQUERADE iptable_nat 
ip_conntrack iptable_filter ip_tables ide-scsi sg sr_mod via686a i2c-proc 
i2c-isa i2c-core serial smbfs loop 3c59x


=======================================
[7.2.] Processor information (from /proc/cpuinfo):
root@wkamphuis:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) processor
stepping        : 1
cpu MHz         : 699.677
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1395.91


=======================================
[7.3.] Module information (from /proc/modules):
root@wkamphuis:~# cat /proc/modules
ipt_limit                960   2
ipt_LOG                 3136   2
ipt_REJECT              2848   2
ipt_MASQUERADE          1216   2
iptable_nat            13172   1 [ipt_MASQUERADE]
ip_conntrack           13388   1 [ipt_MASQUERADE iptable_nat]
iptable_filter          1760   1
ip_tables              10880   8 [ipt_limit ipt_LOG ipt_REJECT ipt_MASQUERADE 
iptable_nat iptable_filter]
ide-scsi                8320   0
sg                     24676   0 (unused)
sr_mod                 13208   0 (unused)
via686a                 7780   0
i2c-proc                6304   0 [via686a]
i2c-isa                 1220   0 (unused)
i2c-core               12416   0 [via686a i2c-proc i2c-isa]
serial                 42304   1
smbfs                  32544   0 (unused)
loop                    8528   0 (unused)
3c59x                  24936   2


=======================================
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
root@wkamphuis:~# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
   6000-607f : via686a-sensors
d000-d00f : VIA Technologies, Inc. Bus Master IDE
   d000-d007 : ide0
   d008-d00f : ide1
dc00-dc7f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
   dc00-dc7f : 00:08.0
e000-e07f : 3Com Corporation 3c905C-TX/TX-M [Tornado] (#2)
   e000-e07f : 00:09.0
e400-e47f : 3Com Corporation 3c905C-TX/TX-M [Tornado] (#3)
   e400-e47f : 00:0a.0
e800-e80f : 3ware Inc 3ware 7000-series ATA-RAID
   e800-e80c : 3ware Storage Controller


root@wkamphuis:~# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000cd000-000cd7ff : Extension ROM
000ce000-000ce7ff : Extension ROM
000cf000-000cffff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
   00100000-002164a2 : Kernel code
   002164a3-002654ab : Kernel data
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d5ffffff : PCI Bus #01
   d4000000-d5ffffff : nVidia Corporation Vanta [NV6]
d6000000-d7ffffff : PCI Bus #01
   d6000000-d6ffffff : nVidia Corporation Vanta [NV6]
d9000000-d97fffff : 3ware Inc 3ware 7000-series ATA-RAID
d9800000-d980007f : 3Com Corporation 3c905C-TX/TX-M [Tornado] (#2)
d9801000-d980107f : 3Com Corporation 3c905C-TX/TX-M [Tornado] (#3)
d9802000-d980200f : 3ware Inc 3ware 7000-series ATA-RAID
d9803000-d980307f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
ffff0000-ffffffff : reserved


=======================================
[7.5.] PCI information ('lspci -vvv' as root)
root@wkamphuis:~# lspci -vvv
00:00.0 Class 0600: 1106:0305 (rev 03)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 Class 0604: 1106:8305
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: d6000000-d7ffffff
         Prefetchable memory behind bridge: d4000000-d5ffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Class 0601: 1106:0686 (rev 40)
         Subsystem: 1106:0000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at d000 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Class 0600: 1106:3057 (rev 40)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Capabilities: [68] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Class 0200: 10b7:9200 (rev 74)
         Subsystem: 10b7:1000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at dc00 [size=128]
         Region 1: Memory at d9803000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:09.0 Class 0200: 10b7:9200 (rev 74)
         Subsystem: 10b7:1000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 12
         Region 0: I/O ports at e000 [size=128]
         Region 1: Memory at d9800000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 Class 0200: 10b7:9200 (rev 74)
         Subsystem: 10b7:1000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at e400 [size=128]
         Region 1: Memory at d9801000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0c.0 Class 0104: 13c1:1001 (rev 01)
         Subsystem: 13c1:1001
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2250ns min), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at e800 [size=16]
         Region 1: Memory at d9802000 (32-bit, non-prefetchable) [size=16]
         Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=8M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [40] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 Class 0300: 10de:002d (rev 15)
         Subsystem: 1569:002d
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 0
         Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at d4000000 (32-bit, prefetchable) [size=32M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2,x4
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


=======================================
[7.6.] SCSI information (from /proc/scsi/scsi)
root@wkamphuis:~# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0
   Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: TEAC     Model: CD-W54E          Rev: 1.1B
   Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
   Vendor: TEAC     Model: CD-540E          Rev: 3.0A
   Type:   CD-ROM                           ANSI SCSI revision: 02


=======================================
[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

The machine is a AMD Duron 700Mhz on a MSI K7T turbo mainboard. It has a VIA 
686a chipset. The cdrw-burner is master on the primary ide-channel, a 
cdrom-drive is slave on the primary-ide channel. The machine has a 3ware 7450 
raidcontroller for the os and data. The machine is used as a personal server, 
i.e. web, ftp and email. The machine normally never crashes.


=======================================
[X.] Other notes, patches, fixes, workarounds:
root@wkamphuis:~# dmesg
Linux version 2.4.19-pre10-ac1 (root@wkamphuis.student.utwente.nl) (gcc version 
2.95.3 20010315 (release)) #1 Wed Jun 5 19:43:12 CEST 2002
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
128MB LOWMEM available.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=19-pre10-ac1 ro root=802 hda=ide-scsi 
hdb=ide-scsi
ide_setup: hda=ide-scsi
ide_setup: hdb=ide-scsi
Initializing CPU#0
Detected 699.677 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1395.91 BogoMIPS
Memory: 127172k/131072k available (1113k kernel code, 3516k reserved, 316k data, 
204k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb180, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
block: 240 slots per queue, batch=60
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: CD-W54E, ATAPI CD/DVD-ROM drive
hdb: CD-540E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
SCSI subsystem driver Revision: 1.00
3ware Storage Controller device driver for Linux v1.02.00.020.
PCI: Found IRQ 11 for device 00:0c.0
PCI: Sharing IRQ 11 with 00:08.0
scsi0 : Found a 3ware Storage Controller at 0xe800, IRQ: 11, P-chip: 1.3
scsi0 : 3ware Storage Controller
3w-xxxx: scsi0: AEN: Unclean shutdown detected: Unit #0.
   Vendor: 3ware     Model: 3w-xxxx           Rev: 1.0
   Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 586108416 512-byte hdwr sectors (300088 MB)
Partition check:
  sda: sda1 sda2 sda3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 497972k swap-space (priority -1)
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,2), internal journal
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,3), internal journal
PCI: Found IRQ 11 for device 00:08.0
PCI: Sharing IRQ 11 with 00:0c.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:08.0: 3Com PCI 3c905C Tornado at 0xdc00. Vers LK1.1.16
PCI: Found IRQ 12 for device 00:09.0
00:09.0: 3Com PCI 3c905C Tornado at 0xe000. Vers LK1.1.16
PCI: Found IRQ 10 for device 00:0a.0
00:0a.0: 3Com PCI 3c905C Tornado at 0xe400. Vers LK1.1.16
loop: loaded (max 8 devices)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
i2c-core.o: i2c core module
i2c-isa.o version 2.6.3 (20020322)
i2c-core.o: adapter ISA main adapter registered as adapter 0.
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.6.1 (20010825)
via686a.o version 2.6.3 (20020322)
i2c-core.o: driver VIA 686A registered.
i2c-core.o: client [Via 686A Integrated Sensors] registered to adapter [ISA main 
adapter](pos. 0).
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: TEAC      Model: CD-W54E           Rev: 1.1B
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: TEAC      Model: CD-540E           Rev: 3.0A
   Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack (1024 buckets, 8192 max)
eth0: no IPv6 routers present
3w-xxxx: scsi0: AEN: Initialization started: Unit #0.
eth0: Setting full-duplex based on MII #24 link partner capability of 45e1.

root@wkamphuis:~# cat /usr/src/linux/.config | grep -v "is not set"
(removed some not-used parts)

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y

#
# Processor type and features
#
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m

#
# Multi-device support (RAID and LVM)
#

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IPV6=y

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_CONSTANTS=y

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=y

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m

#
#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Watchdog Cards
#
CONFIG_AMD_RNG=y
CONFIG_RTC=y

#
# File systems
#
CONFIG_QUOTA=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

#
# Network File Systems
#
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"

#
# Partition Types
#
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y


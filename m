Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131570AbQLLSwa>; Tue, 12 Dec 2000 13:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131569AbQLLSwU>; Tue, 12 Dec 2000 13:52:20 -0500
Received: from postfix3.free.fr ([212.27.32.22]:1033 "HELO postfix3.free.fr")
	by vger.kernel.org with SMTP id <S131493AbQLLSwR>;
	Tue, 12 Dec 2000 13:52:17 -0500
Message-ID: <3A366CA5.5020502@epita.fr>
Date: Tue, 12 Dec 2000 19:21:25 +0100
From: Olivier Cahagne <cahagn_o@epita.fr>
Reply-To: cahagn_o@epita.fr
Organization: Epita
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; m18) Gecko/20001211
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.4.0-test12 with heavy file manipulation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC me when replying as I follow this list on the Web)

[1.] One line summary of the problem:
2.4.0-test12 non-fatal oops while copying files or doing shell file name 
completion.

[2.] Full description of the problem/report:
With 2.4.0-test12, I got a non reproducible oops after having compiled 
XFree 4.0.2 from CVS and copying files and doing shell file name completion.
Even after oopsing, I could ssh on this machine and still type 'ls' or 
things like this but completion would oops one more time, then, with the 
time, 'uptime' would oops too, and ssh wouldn't work anymore.
Ctrl-Alt-Del on the console would oops again and again so I was forced 
to power off the machine manually (ext2 wasn't corrupt when I rebooted, 
a simple fsck and the machine actually runs fine).

I suspect it deals with ext2 filesystem manipulation as this kernel 
oopsed after compiling XFree 4.0.2 and Mesa 3.4, copying various 
TrueType fonts in a directory on the same ext2 filesystem.

I've been testing every 2.4.0 kernel since test1 and all of them ran 
successfully on this machine.

[3.] Keywords (i.e., modules, networking, kernel):
ext2, filesystem

[4.] Kernel version (from /proc/version):
Linux version 2.4.0-test12 (root@pc2) (gcc version egcs-2.91.66 
19990314/Linux (egcs-1.1.2 release)) #1 mar déc 12 16:13:44 GMT-5 2000

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

ksymoops 2.3.5 on i586 2.4.0-test12.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.0-test12/ (default)
      -m /boot/System.map-2.4.0-test12 (specified)

Dec 12 21:11:20 pc2 kernel: Unable to handle kernel paging request at 
virtual address 30c0cc80
Dec 12 21:11:20 pc2 kernel: c0141dc7
Dec 12 21:11:20 pc2 kernel: *pde = 00000000
Dec 12 21:11:20 pc2 kernel: Oops: 0000
Dec 12 21:11:20 pc2 kernel: CPU:    0
Dec 12 21:11:20 pc2 kernel: EIP:    0010:[find_inode+27/84]
Dec 12 21:11:20 pc2 kernel: EFLAGS: 00010217
Dec 12 21:11:20 pc2 kernel: eax: c7fe0000   ebx: 30c0cc60   ecx: 
0000001a   edx: 0001c4e2
Dec 12 21:11:20 pc2 kernel: esi: 30c0cc60   edi: 00000000   ebp: 
c7fecf88   esp: c60adeb8
Dec 12 21:11:20 pc2 kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 21:11:20 pc2 kernel: Process zsh (pid: 374, stackpage=c60ad000)
Dec 12 21:11:20 pc2 kernel: Stack: 0001c4e2 00000000 0001c4e2 c7f8fe00 
c0142198 c7f8fe00 0001c4e2 c7fecf88
Dec 12 21:11:20 pc2 kernel:        00000000 00000000 0001c4e2 c7c632e0 
c71ae900 c71ae95c c7fecf88 c015054b
Dec 12 21:11:20 pc2 kernel:        c7f8fe00 0001c4e2 00000000 00000000 
fffffff4 c7c632e0 c71ae900 c4b342b0
Dec 12 21:11:20 pc2 kernel: Call Trace: [iget4+76/220] 
[ext2_lookup+91/136] [real_lookup+82/192] [path_walk+1459/2076] 
[getname+92/160]
[__user_walk+60/88] [sys_stat64+22/112]
Dec 12 21:11:20 pc2 kernel: Code: 39 53 20 75 24 8b 54 24 14 39 93 8c 00 
00 00 75 18 85 ff 74
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   39 53 20                  cmp    %edx,0x20(%ebx)
Code;  00000003 Before first symbol
    3:   75 24                     jne    29 <_EIP+0x29> 00000029 Before 
first symbol
Code;  00000005 Before first symbol
    5:   8b 54 24 14               mov    0x14(%esp,1),%edx
Code;  00000009 Before first symbol
    9:   39 93 8c 00 00 00         cmp    %edx,0x8c(%ebx)
Code;  0000000f Before first symbol
    f:   75 18                     jne    29 <_EIP+0x29> 00000029 Before 
first symbol
Code;  00000011 Before first symbol
   11:   85 ff                     test   %edi,%edi
Code;  00000013 Before first symbol
   13:   74 00                     je     15 <_EIP+0x15> 00000015 Before 
first symbol

Dec 12 21:13:57 pc2 kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000018
Dec 12 21:13:57 pc2 kernel: c01329b6
Dec 12 21:13:57 pc2 kernel: *pde = 00000000
Dec 12 21:13:57 pc2 kernel: Oops: 0000
Dec 12 21:13:57 pc2 kernel: CPU:    0
Dec 12 21:13:57 pc2 kernel: EIP:    0010:[try_to_free_buffers+54/368]
Dec 12 21:13:57 pc2 kernel: EFLAGS: 00010207
Dec 12 21:13:57 pc2 kernel: eax: 00000000   ebx: 00000000   ecx: 
c1124b08   edx: 00000000
Dec 12 21:13:57 pc2 kernel: esi: 00000000   edi: c609e660   ebp: 
00000000   esp: c1237f90
Dec 12 21:13:57 pc2 kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 21:13:57 pc2 kernel: Process bdflush (pid: 5, stackpage=c1237000)
Dec 12 21:13:57 pc2 kernel: Stack: c10d4fe0 c10d4fc4 c021a3f8 00000000 
c609e660 ffffffff c012a14f c10d4fc4
Dec 12 21:13:57 pc2 kernel:        00000000 c1236000 c0282c7c 00000000 
0008e000 00000021 00000000 00000000
Dec 12 21:13:57 pc2 kernel:        00003b48 00000000 c0132e3f 00000003 
00000000 00010f00 c7ff3f8c c7ff3fd8
Dec 12 21:13:57 pc2 kernel: Call Trace: [page_launder+795/2056] 
[bdflush+127/260] [kernel_thread+35/48]
Dec 12 21:13:57 pc2 kernel: Code: 8b 50 18 8b 40 10 83 e2 46 8b 76 28 09 
d0 0f 85 f6 00 00 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 50 18                  mov    0x18(%eax),%edx
Code;  00000003 Before first symbol
    3:   8b 40 10                  mov    0x10(%eax),%eax
Code;  00000006 Before first symbol
    6:   83 e2 46                  and    $0x46,%edx
Code;  00000009 Before first symbol
    9:   8b 76 28                  mov    0x28(%esi),%esi
Code;  0000000c Before first symbol
    c:   09 d0                     or     %edx,%eax
Code;  0000000e Before first symbol
    e:   0f 85 f6 00 00 00         jne    10a <_EIP+0x10a> 0000010a 
Before first symbol

Dec 12 21:14:00 pc2 kernel: Unable to handle kernel paging request at 
virtual address 00fa0121
Dec 12 21:14:00 pc2 kernel: c0141dc7
Dec 12 21:14:00 pc2 kernel: *pde = 00000000
Dec 12 21:14:00 pc2 kernel: Oops: 0000
Dec 12 21:14:00 pc2 kernel: CPU:    0
Dec 12 21:14:00 pc2 kernel: EIP:    0010:[find_inode+27/84]
Dec 12 21:14:00 pc2 kernel: EFLAGS: 00010213
Dec 12 21:14:00 pc2 kernel: eax: c7fe0000   ebx: 00fa0101   ecx: 
0000001a   edx: 0007e091
Dec 12 21:14:00 pc2 kernel: esi: 00fa0101   edi: 00000000   ebp: 
c7fecf88   esp: c43cbeb8
Dec 12 21:14:00 pc2 kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 21:14:00 pc2 kernel: Process netscape-commun (pid: 515, 
stackpage=c43cb000)
Dec 12 21:14:00 pc2 kernel: Stack: 0007e091 00000000 0007e091 c7f8fe00 
c0142198 c7f8fe00 0007e091 c7fecf88
Dec 12 21:14:00 pc2 kernel:        00000000 00000000 0007e091 c1e1d960 
c0fc2580 c0fc25dc c7fecf88 c015054b
Dec 12 21:14:00 pc2 kernel:        c7f8fe00 0007e091 00000000 00000000 
fffffff4 c1e1d960 c0fc2580 c56d5084
Dec 12 21:14:00 pc2 kernel: Call Trace: [iget4+76/220] 
[ext2_lookup+91/136] [real_lookup+82/192] [path_walk+1459/2076] 
[getname+92/160]
[__user_walk+60/88] [sys_newstat+22/112]
Dec 12 21:14:00 pc2 kernel: Code: 39 53 20 75 24 8b 54 24 14 39 93 8c 00 
00 00 75 18 85 ff 74

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   39 53 20                  cmp    %edx,0x20(%ebx)
Code;  00000003 Before first symbol
    3:   75 24                     jne    29 <_EIP+0x29> 00000029 Before 
first symbol
Code;  00000005 Before first symbol
    5:   8b 54 24 14               mov    0x14(%esp,1),%edx
Code;  00000009 Before first symbol
    9:   39 93 8c 00 00 00         cmp    %edx,0x8c(%ebx)
Code;  0000000f Before first symbol
    f:   75 18                     jne    29 <_EIP+0x29> 00000029 Before 
first symbol
Code;  00000011 Before first symbol
   11:   85 ff                     test   %edi,%edi
Code;  00000013 Before first symbol
   13:   74 00                     je     15 <_EIP+0x15> 00000015 Before 
first symbol

Dec 12 21:16:18 pc2 kernel: Unable to handle kernel paging request at 
virtual address 0c00c004
Dec 12 21:16:18 pc2 kernel: c01304a8
Dec 12 21:16:18 pc2 kernel: *pde = 00000000
Dec 12 21:16:18 pc2 kernel: Oops: 0000
Dec 12 21:16:18 pc2 kernel: CPU:    0
Dec 12 21:16:18 pc2 kernel: EIP:    0010:[get_hash_table+104/148]
Dec 12 21:16:18 pc2 kernel: EFLAGS: 00010206
Dec 12 21:16:18 pc2 kernel: eax: c1224000   ebx: 00000000   ecx: 
00000c40   edx: 0c00c000
Dec 12 21:16:18 pc2 kernel: esi: 00000006   edi: 00000302   ebp: 
000f4e2a   esp: c550dea4
Dec 12 21:16:18 pc2 kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 21:16:18 pc2 kernel: Process cp (pid: 558, stackpage=c550d000)
Dec 12 21:16:18 pc2 kernel: Stack: c014e54c 00001000 00000000 c550df04 
00000c40 c01312f8 00000302 000f4e2a
Dec 12 21:16:18 pc2 kernel:        00001000 c014e54c c01315f2 c3e0cde0 
00000000 c1120ce0 c5c691e0 00001000
Dec 12 21:16:18 pc2 kernel:        00000000 00000302 c550df04 c3e0cde0 
c43f4000 00001000 00000000 c3e0cde0
Dec 12 21:16:19 pc2 kernel: Call Trace: [ext2_get_block+0/1348] 
[unmap_underlying_metadata+28/100] [ext2_get_block+0/1348] [__block_prep
are_write+286/584] [block_prepare_write+34/60] [ext2_get_block+0/1348] 
[ext2_prepare_write+25/32]
Dec 12 21:16:19 pc2 kernel: Code: 39 6a 04 75 12 31 c0 66 8b 42 08 3b 44 
24 20 75 06 66 39 7a

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   39 6a 04                  cmp    %ebp,0x4(%edx)
Code;  00000003 Before first symbol
    3:   75 12                     jne    17 <_EIP+0x17> 00000017 Before 
first symbol
Code;  00000005 Before first symbol
    5:   31 c0                     xor    %eax,%eax
Code;  00000007 Before first symbol
    7:   66 8b 42 08               mov    0x8(%edx),%ax
Code;  0000000b Before first symbol
    b:   3b 44 24 20               cmp    0x20(%esp,1),%eax
Code;  0000000f Before first symbol
    f:   75 06                     jne    17 <_EIP+0x17> 00000017 Before 
first symbol
Code;  00000011 Before first symbol
   11:   66 39 7a 00               cmp    %di,0x0(%edx)


Dec 12 21:17:02 pc2 kernel: Unable to handle kernel paging request at 
virtual address 99cce026
Dec 12 21:17:02 pc2 kernel: c012fec4
Dec 12 21:17:02 pc2 kernel: *pde = 00000000
Dec 12 21:17:02 pc2 kernel: Oops: 0000
Dec 12 21:17:02 pc2 kernel: CPU:    0
Dec 12 21:17:02 pc2 kernel: EIP:    0010:[sync_buffers+48/464]
Dec 12 21:17:02 pc2 kernel: EFLAGS: 00010202
Dec 12 21:17:02 pc2 kernel: eax: 99cce006   ebx: 99cce006   ecx: 
000039f7   edx: c7f9d7e0
Dec 12 21:17:02 pc2 kernel: esi: 00001e07   edi: 00000000   ebp: 
00000001   esp: c5749f88
Dec 12 21:17:02 pc2 kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 21:17:02 pc2 kernel: Process shutdown (pid: 561, stackpage=c5749000)
Dec 12 21:17:02 pc2 kernel: Stack: 00000000 00000000 0804c4f0 bffffbec 
c3e0c120 00000000 0000fbec 99cce006
Dec 12 21:17:03 pc2 kernel:        c0130098 00000000 00000000 c5748000 
c01300bf 00000000 c010ac03 bffffbcc
Dec 12 21:17:03 pc2 kernel:        00000002 00000002 00000000 0804c4f0 
bffffbec 00000024 0000002b 0000002b
Dec 12 21:17:03 pc2 kernel: Call Trace: [fsync_dev+16/48] 
[sys_sync+7/16] [system_call+51/64]
Dec 12 21:17:03 pc2 kernel: Code: 8b 58 20 83 3d 70 67 26 c0 00 74 63 66 
83 7c 24 1a 00 74 0b

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 58 20                  mov    0x20(%eax),%ebx
Code;  00000003 Before first symbol
    3:   83 3d 70 67 26 c0 00      cmpl   $0x0,0xc0266770
Code;  0000000a Before first symbol
    a:   74 63                     je     6f <_EIP+0x6f> 0000006f Before 
first symbol
Code;  0000000c Before first symbol
    c:   66 83 7c 24 1a 00         cmpw   $0x0,0x1a(%esp,1)
Code;  00000012 Before first symbol
   12:   74 0b                     je     1f <_EIP+0x1f> 0000001f Before 
first symbol

I had several other forthcoming oops on the same machine after this 
first oops (when keeping on doing completion things, typing 'uptime' and 
hitting 'Ctrl-Alt-Del'). As this is my first oops report, I don't know 
if all of the oops are relevant, mail me if you need the others (I have 
a 70KB file with oops).

[6.] A small shell script or example program which triggers the
      problem (if possible)
None

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux pc2 2.4.0-test12 #1 mar déc 12 16:13:44 GMT-5 2000 i586 unknown
Kernel modules         2.3.15
Gnu C                  egcs-2.91.66
Binutils               2.9.5.0.22
Linux C Library        2.1.3
Dynamix linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Kbd                    0.3.3
Sh-utils               2.0

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 501.124
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow 
k6_mtrr
bogomips        : 999.42

[7.3.] Module information (from /proc/modules):
NVdriver              530316   0
agpgart                12964   1 [NVdriver]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5c20-5c3f : Acer Laboratories Inc. [ALi] M7101 PMU
d000-d00f : Acer Laboratories Inc. [ALi] M5229 IDE
   d000-d007 : ide0
   d008-d00f : ide1
d400-d43f : Ensoniq ES1371 [AudioPCI-97]
   d400-d43f : es1371
d800-d81f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
   d800-d81f : ne2k-pci
ec00-ec03 : acpi
ec04-ec05 : acpi
ec08-ec0b : acpi
ec18-ec1b : acpi
ec1c-ec1f : acpi

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffbfff : System RAM
   00100000-00216d87 : Kernel code
   00216d88-0022b147 : Kernel data
07ffc000-07ffefff : ACPI Tables
07fff000-07ffffff : ACPI Non-volatile Storage
de800000-de800fff : Acer Laboratories Inc. [ALi] M5237 USB
df000000-dfffffff : PCI Bus #01
   df000000-dfffffff : nVidia Corporation Vanta [NV6]
e0000000-e3ffffff : Acer Laboratories Inc. [ALi] M1541
e5f00000-e7ffffff : PCI Bus #01
   e6000000-e7ffffff : nVidia Corporation Vanta [NV6]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
         Subsystem: Acer Laboratories Inc. [ALi]: Unknown device 1541
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64 set
         Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
         Capabilities: [b0] AGP version 1.0
                 Status: RQ=28 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=28 SBA- AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if 
00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 set
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000e000-0000dfff
         Memory behind bridge: df000000-dfffffff
         Prefetchable memory behind bridge: e5f00000-e7ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) 
(prog-if 10 [OHCI])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 80 max, 0 set
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at de800000 (32-bit, non-prefetchable) [size=4K]

00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
         Subsystem: Acer Laboratories Inc. [ALi]: Unknown device 7101
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV] (rev c3)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
         Latency: 0 set

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 12
         Region 0: I/O ports at d800 [size=32]

00:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 02)
         Subsystem: Ensoniq: Unknown device 1371
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 12 min, 128 max, 32 set
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at d400 [size=64]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- AuxPwr+ DSI+ D1- D2+ PME+
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) 
(prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 2 min, 4 max, 32 set
         Interrupt: pin A routed to IRQ 0
         Region 4: I/O ports at d000 [size=16]
01:00.0 VGA compatible controller: nVidia Corporation Riva TNT2 Model 64 
(rev 15) (prog-if 00 [VGA])
         Subsystem: Elsa AG: Unknown device 0c3a
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 5 min, 1 max, 248 set
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at df000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at e6000000 (32-bit, prefetchable) [size=32M]
         Expansion ROM at e5ff0000 [disabled] [size=64K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                 Command: RQ=28 SBA- AGP+ 64bit- FW- Rate=x1

[7.6.] SCSI information (from /proc/scsi/scsi)
None

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
This is a basic machine with IDE CD-ROM, Hard drive, one NIC and one AGP 
card. Asus P5A-B with ALi Aladdin chipset, here's .config extract with 
IDE config:
#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

Here's the relevant part from boot log:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try 
using pci=biosirq.
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: ST38641A, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: Pioneer CD-ROM ATAPI Model DR-A24X 0102, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16809660 sectors (8607 MB) w/128KiB Cache, CHS=1046/255/63, UDMA(33)
hdc: set_drive_speed_status: status=0x00 { }
hdc: ATAPI 20X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.11
Partition check:
  hda:hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
hda: set_multmode: error=0x04 { DriveStatusError }
  hda1 hda2 hda3

(These last warnings disappear if I compile MultiMode by Default in 
kernel: CONFIG_IDEDISK_MULTI_MODE=y)

-- 
Olivier.Cahagne@epita.fr

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

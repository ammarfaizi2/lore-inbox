Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSBZXGA>; Tue, 26 Feb 2002 18:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287425AbSBZXF4>; Tue, 26 Feb 2002 18:05:56 -0500
Received: from tassadar.physics.auth.gr ([155.207.123.25]:41857 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S286959AbSBZXEt>; Tue, 26 Feb 2002 18:04:49 -0500
Date: Wed, 27 Feb 2002 01:04:47 +0200 (EET)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: linux-kernel@vger.kernel.org
Subject: assertion failure : ext3 & lvm , 2.4.17 smp & 2.4.18-ac1 smp
Message-ID: <Pine.LNX.4.44.0202270017250.5280-100000@tassadar.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:
assertion failure messages on an lvm partition with ext3  filesystem

[2.] Full description of the problem/report:

 each time some continued write activity occures on an lvm device
consisted of loopback mounted files ,  a big assertion failure error comes
out and the device becomes unusable . A reboot from the power button / reset
is required since the system is unable to reboot on its own , even in singe
user mode . kjournald and process dealing with the lvm parition are in
uninterruptable sleep and unkillable .
  The issue started the moment i converted an ext2 filesystem on the lvm
device to ext3 . First tried with 2.4.17-smp , continued with 2.4.18-ac1 .
 Both patched with smbfs-2.4.16-lfs.patch , modified slightly in the
2.4.18 case to apply cleanly .
  The lvm device is consisted of 10 loopback mounted files of 23 gbytes ,
which reside on samba mounted shares .

  Everything works ok if i mount as ext2 .
[3.] Keywords (i.e., modules, networking, kernel):

lvm 1.0.3 , ext3  , loopback , 2.4.17 smp 2.4.18-ac1 smp
[4.] Kernel version (from /proc/version):
Linux version 2.4.18-ac1 (root@tassadar) (gcc version 2.95.3 20010315
(release)) #2 SMP Tue Feb 26 23:13:44 EET 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
well there is not oops word in the message but looks like one so i decoded
one anyway

 they look in the kernel logs like this :

Assertion failure in do_get_write_access() at transaction.c:730: "(((jh2bh(jh))->b_state & (1UL << BH_Uptodate)) != 0)"
invalid operand: 0000
CPU:    1
EIP:    0010:[do_get_write_access+1206/1344] Not tainted
EFLAGS: 00010282
eax: 0000007b   ebx: d7f7da94   ecx: 00000056 edx: 00000001
esi: c59df9a0   edi: d7f7da00   ebp: c9a73820 esp: ce4edcd4
ds: 0018   es: 0018   ss: 0018
Process wget (pid: 466, stackpage=ce4ed000)
Stack: c02887c0 c0288bce c02887a0 000002da c0288d80 d7f7da00 c59df9a0 c9a73820
d7f7da94 00000001 00000001 00000000 00000000 c72f04c0 c016277d c59df9a0
c9a73820 00000000 c59df9a0 0000154b c1c22c00 ce4edd8c c0157ae8 c59df9a0
Call Trace: [journal_get_write_access+57/92] [ext3_new_block+1056/1908] [ext3_alloc_block+30/36]
[ext3_alloc_branch+63/648] [ext3_get_block_handle+458/696]
[ext3_get_block+90/96] [__block_prepare_write+219/732] [block_prepare_write+34/60] [ext3_get_block+0/96]
[ext3_prepare_write+213/452] [ext3_get_block+0/96]
[generic_file_write+1160/1880] [ext3_file_write+70/76] [sys_write+143/256] [system_call+51/56]
Code: 0f 0b 83 c4 14 90 8b 4d 00 8b 41 38 0f b6 50 25 8b 7d 0c 8b



here is another one , decoded

ksymoops 2.4.3 on i686 2.4.18-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-ac1/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Warning (compare_maps): ksyms_base symbol ___strtok not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c020c120, System.map says c0156740.  Ignoring ksyms_base entry
invalid operand: 0000
CPU:    1
EIP:    0010:[<c015d745>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000007b   ebx: d8298e80   ecx: 00000056   edx: 00000001
esi: da44ae94   edi: d8298e80   ebp: da44ae00   esp: c726dce8
ds: 0018   es: 0018   ss: 0018
Process wget (pid: 13623, stackpage=c726d000)
Stack: c0278200 c027860e c02781e0 000002d8 c02787c0 da44ae00 c8c0d2e0
d8298e80
       da44ae94 00000001 00000001 00000000 00000000 c9f32be0 c015d7e9
c8c0d2e0
Call Trace: [<c015d7e9>] [<c0152e00>] [<c0154aa6>] [<c0154d9b>]
[<c015541e>]
   [<c0134ef0>] [<c0155566>] [<c01353e2>] [<c01359ee>] [<c015550c>]
[<c0155a0d>]

   [<c015550c>] [<c01289bb>] [<c01536ea>] [<c0132e46>] [<c0106d9b>]
Code: 0f 0b 83 c4 14 8d b6 00 00 00 00 8b 03 8b 7b 0c 8b 50 38 8b

>>EIP; c015d744 <ext3_add_entry+1a4/400>   <=====
Trace; c015d7e8 <ext3_add_entry+248/400>
Trace; c0152e00 <proc_pid_lookup+13c/1ec>
Trace; c0154aa6 <kmsg_poll+2a/44>
Trace; c0154d9a <proc_tty_unregister_driver+26/2c>
Trace; c015541e <devices_read_proc+6/34>
Trace; c0134ef0 <get_unused_fd+a0/188>
Trace; c0155566 <cmdline_read_proc+e/54>
Trace; c01353e2 <sys_lseek+12/cc>
Trace; c01359ee <do_readv_writev+236/29c>
Trace; c015550c <dma_read_proc+24/34>
Trace; c0155a0c <elf_kcore_store_hdr+34/2f0>
Trace; c015550c <dma_read_proc+24/34>
Trace; c01289ba <sys_msync+76/104>
Trace; c01536ea <proc_register+7a/88>
Trace; c0132e46 <shmem_writepage+3e/114>
Trace; c0106d9a <lcall7+a/4c>
Code;  c015d744 <ext3_add_entry+1a4/400>
0000000000000000 <_EIP>:
Code;  c015d744 <ext3_add_entry+1a4/400>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015d746 <ext3_add_entry+1a6/400>
   2:   83 c4 14                  add    $0x14,%esp
Code;  c015d748 <ext3_add_entry+1a8/400>
   5:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c015d74e <ext3_add_entry+1ae/400>
   b:   8b 03                     mov    (%ebx),%eax
Code;  c015d750 <ext3_add_entry+1b0/400>
   d:   8b 7b 0c                  mov    0xc(%ebx),%edi
Code;  c015d754 <ext3_add_entry+1b4/400>
  10:   8b 50 38                  mov    0x38(%eax),%edx
Code;  c015d756 <ext3_add_entry+1b6/400>
  13:   8b 00                     mov    (%eax),%eax


3 warnings issued.  Results may not be reliable.




[6.] A small shell script or example program which triggers the
     problem (if possible)
/usr/bin/wget -r  -l inf -nr -nc -b -np -nH ftp://ftp.kernel.org/pub/
on the lvm does the trick for me after say 30 seconds max .
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux test 2.4.18-ac1 #2 SMP Tue Feb 26 23:13:44 EET 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.25
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded
[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 267.277
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
mmx
bogomips        : 532.48

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 267.277
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
mmx
bogomips        : 534.11

[7.3.] Module information (from /proc/modules):

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
b800-b83f : Intel Corp. 82557 [Ethernet Pro 100]
  b800-b83f : eepro100
d000-d0ff : Adaptec AIC-7880U
  d000-d0ff : aic7xxx
d400-d41f : Intel Corp. 82371AB PIIX4 USB
d800-d80f : Intel Corp. 82371AB PIIX4 IDE
  d800-d807 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b800-b83f : Intel Corp. 82557 [Ethernet Pro 100]
  b800-b83f : eepro100
d000-d0ff : Adaptec AIC-7880U
  d000-d0ff : aic7xxx
d400-d41f : Intel Corp. 82371AB PIIX4 USB
d800-d80f : Intel Corp. 82371AB PIIX4 IDE
  d800-d807 : ide0
  d808-d80f : ide1
e400-e43f : Intel Corp. 82371AB PIIX4 ACPI
e800-e81f : Intel Corp. 82371AB PIIX4 ACPI

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000cc000-000d0fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1bffcfff : System RAM
  00100000-00279def : Kernel code
  00279df0-002f08ff : Kernel data
1bffd000-1bffefff : ACPI Tables
1bfff000-1bffffff : ACPI Non-volatile Storage
da800000-da8fffff : Intel Corp. 82557 [Ethernet Pro 100]
db000000-db000fff : Intel Corp. 82557 [Ethernet Pro 100]
  db000000-db000fff : eepro100
db800000-db800fff : Adaptec AIC-7880U
  db800000-db800fff : aic7xxx
dc000000-e3cfffff : PCI Bus #01
  dc000000-dfffffff : S3 Inc. 86c368 [Trio 3D/2X]
e3f00000-e3ffffff : PCI Bus #01
e4000000-e7ffffff : Intel Corp. 440LX/EX - 82443LX/EX Host bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge
(rev 03
)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort+ >SERR+ <PERR-
        Latency: 64
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge
(rev 03)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: dc000000-e3cfffff
        Prefetchable memory behind bridge: e3f00000-e3ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00
 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 0
        Region 4: I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:06.0 SCSI storage controller: Adaptec AIC-7880U
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d000 [disabled] [size=256]
        Region 1: Memory at db800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at db000000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at b800 [size=64]
        Region 2: Memory at da800000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot
+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 01)
(prog-if
 00 [VGA])
        Subsystem: S3 Inc. Trio3D/2X
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 63750ns max)
        Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at e3ff0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] AGP version 1.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x2

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: VIKING II 9.1WLS Rev: 5520
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle Univercity of Thessaloniki , Greece
=============================================================================


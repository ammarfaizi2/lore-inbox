Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266339AbRGLRTy>; Thu, 12 Jul 2001 13:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266399AbRGLRTp>; Thu, 12 Jul 2001 13:19:45 -0400
Received: from mail.linuxcare.com ([216.88.157.164]:3050 "HELO
	mail.linuxcare.com") by vger.kernel.org with SMTP
	id <S266339AbRGLRTb>; Thu, 12 Jul 2001 13:19:31 -0400
From: Ned Bass <ned@linuxcare.com>
Date: Thu, 12 Jul 2001 10:12:19 -0700
To: linux-kernel@vger.kernel.org
Subject: Oops triggered by ftp connection attempt through Linux firewall
Message-ID: <20010712101219.D5476@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wish to be personally CC'ed the answers/comments posted to the list in
response to my posting.

[1.] One line summary of the problem:    

Ftp connection attempt through Linux firewall triggers kernel Oops.

[2.] Full description of the problem/report:

A kernel Oops error occurs on a Linux 2.4.6 system that provides IP
masquerading for a local area network. The crash is triggered when a
connection is attempted to port 21 on ftp.freesoftware.com from any
host on the local network which uses the Linux system as its default
gateway.  Attempting to connect to port 21 on the Linux system itself
results in a no route to host error message.  The severity of the crash
prevents interactive access to the system, and a hard reboot is required.
The error has been 100% reproducible using the scenario described above.
After the Oops, the filesystems can be synced using Alt-Printscreen-S,
however attempting to remount readonly using Alt-Printscreen-U caused
additional kernel panics.

[3.] Keywords (i.e., modules, networking, kernel):

NAT, IP masquerading, networking

[4.] Kernel version (from /proc/version):

Linux version 2.4.6 (root@debian) (gcc version 2.95.4 20010319 (Debian prerelease)) #8 Tue Jul 10 20:50:32 PDT 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.1 on i586 2.4.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6/ (default)
     -m /boot/System.map-2.4.6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 000078e5
c02393c2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02392c2>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c7c738e0   ebx: 000078e5     ecx: 00000000       edx: 000078e5
esi: c7dfe4e0   edi: c7c73680     ebp: 00000000       esp: c030bdd8
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 0, stackpage=c030b000)
Stack: fffffe00 c023936b c7dfe4e0 fffffe00 c7dfe4e0 c0239923 c7dfe4e0 c7dfe4e0
        c12dd800 c62ef120 c12dd800 ffffffe6 c023c807 c7dfe4e0 00000020 c4d4a320
        c7dfe4e0 c62ef120 c023fb0f c7dfe4e0 c7dfe4e0 00000000 00000004 c02487ac
Call Trace: [<c023936b>] [<c0239923>] [<c023c807>] [<c023fb0f>] <c02487ac>] [<c024883d>] [<c0240a96>]
        [<c0245e9c>] [<c0248792>] [<c02487ac>] [<c0245eea>] [<c0240a96>] [<c02405dc>] [<c0245e44>] [<c0245e9c>]
        [<c0245118>] [<c0245299>] [<c0245118>] [<c0240a96>] [<c0244f76>] [<c0245118>] [<c023ce2d>] [<c0113e3f>]
        [<c0107e6d>] [<c0105130>] [<c0106b70>] [<c0105130>] [<c0105153>] [<c01051b7>] [<c0105000>]
Code: 8b 1b 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 09

>>EIP; c02392c2 <skb_drop_fraglist+1a/40>   <=====
Trace; c023936b <skb_release_data+5f/74>
Trace; c0239923 <skb_linearize+cf/130>
Trace; c023c807 <dev_queue_xmit+27/244>
Trace; c023fb0f <neigh_resolve_output+137/1a8>
Trace; c02487ac <ip_finish_output2+0/c8>
Trace; c024883d <ip_finish_output2+91/c8>
Trace; c0240a96 <nf_hook_slow+ee/144>
Trace; c0245e9c <ip_forward_finish+0/54>
Trace; c0248792 <ip_finish_output+f2/f8>
Trace; c02487ac <ip_finish_output2+0/c8>
Trace; c0245eea <ip_forward_finish+4e/54>
Trace; c0240a96 <nf_hook_slow+ee/144>
Trace; c02405dc <nf_unregister_sockopt+1c/60>
Trace; c0245e44 <ip_forward+1a4/1fc>
Trace; c0245e9c <ip_forward_finish+0/54>
Trace; c0245118 <ip_rcv_finish+0/1b8>
Trace; c0245299 <ip_rcv_finish+181/1b8>
Trace; c0245118 <ip_rcv_finish+0/1b8>
Trace; c0240a96 <nf_hook_slow+ee/144>
Trace; c0244f76 <ip_rcv+336/36c>
Trace; c0245118 <ip_rcv_finish+0/1b8>
Trace; c023ce2d <net_rx_action+135/210>
Trace; c0113e3f <do_softirq+3f/68>
Trace; c0107e6d <do_IRQ+9d/b0>
Trace; c0105130 <default_idle+0/28>
Trace; c0106b70 <ret_from_intr+0/7>
Trace; c0105130 <default_idle+0/28>
Trace; c0105153 <default_idle+23/28>
Trace; c01051b7 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Code;  c02392c2 <skb_drop_fraglist+1a/40>
00000000 <_EIP>:
Code;  c02392c2 <skb_drop_fraglist+1a/40>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c02392c4 <skb_drop_fraglist+1c/40>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c02392c7 <skb_drop_fraglist+1f/40>
   5:   83 f8 01                  cmp    $0x1,%eax
Code;  c02392ca <skb_drop_fraglist+22/40>
   8:   74 0a                     je     14 <_EIP+0x14> c02392d6 <skb_drop_fraglist+2e/40>
Code;  c02392cc <skb_drop_fraglist+24/40>
   a:   ff 4a 70                  decl   0x70(%edx)
Code;  c02392cf <skb_drop_fraglist+27/40>
   d:   0f 94 c0                  sete   %al
Code;  c02392d2 <skb_drop_fraglist+2a/40>
  10:   84 c0                     test   %al,%al
Code;  c02392d4 <skb_drop_fraglist+2c/40>
  12:   74 09                     je     1d <_EIP+0x1d> c02392df <skb_drop_fraglist+37/40>

Kernel panic: Aiee, killing interrup handler!

1 warning and 1 error issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

	# run from host on local network
	# with Linux box as default gw
	telnet ftp.freesoftware.com 21

[7.] Environment

Linux 2.4.6 IP masquerading firewall shares DSL Internet connection with
home LAN.  DSL provider uses PPP over Ethernet.  PPPoE support in the
kernel is being used with a patched version of pppd.  Firewall has two
network interfaces; ppp0 has a dynamically assigned public IP address
and eth1 uses a static private IP adress.  IP masquerading is allowed
for the local network. Loadable module support is disabled in the kernel
for security reasons.

[7.1.] Software (add the output of the ver_linux script here)
 
Linux debian 2.4.6 #8 Tue Jul 10 20:50:32 PDT 2001 i586 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.7
util-linux             
util-linux             Note: /usr/bin/fdformat is obsolete and is no longer available.
util-linux             Please use /usr/bin/superformat instead (make sure you have the 
util-linux             fdutils package installed first).  Also, there had been some
util-linux             major changes from version 4.x.  Please refer to the documentation.
util-linux             
mount                  2.10s
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0k-pre8
PPP                    2.4.0
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.58
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 4
model name	: Pentium MMX
stepping	: 3
cpu MHz		: 199.907
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx
bogomips	: 398.95

[7.3.] Module information (from /proc/modules):

Loadable module support disabled in kernel.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0220-022f : soundblaster
02e8-02ef : serial(set)
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0378-037a : parport0
03c0-03df : vga+
  03c0-03df : matrox
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
d400-d4ff : Adaptec 7892A
d800-d87f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
  d800-d87f : 00:0b.0
e000-e03f : Intel Corporation 82557 [Ethernet Pro 100]
  e000-e03f : eepro100
e800-e80f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000cc000-000d25ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00285619 : Kernel code
  0028561a-00309d7b : Kernel data
e4800000-e4800fff : Adaptec 7892A
  e4800000-e4800fff : aic7xxx
e5000000-e500007f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
e5800000-e58fffff : Intel Corporation 82557 [Ethernet Pro 100]
e6000000-e6000fff : Intel Corporation 82557 [Ethernet Pro 100]
  e6000000-e6000fff : eepro100
e6800000-e6803fff : Matrox Graphics, Inc. MGA 2064W [Millennium]
  e6800000-e6803fff : matroxfb MMIO
e7800000-e7ffffff : Matrox Graphics, Inc. MGA 2064W [Millennium]
  e7800000-e7ffffff : matroxfb FB
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)


00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 4: I/O ports at e800 [disabled] [size=16]

00:09.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 15
	Region 0: Memory at e6800000 (32-bit, non-prefetchable) [size=16K]
	Region 1: Memory at e7800000 (32-bit, prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at e000 [size=64]
	Region 2: Memory at e5800000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] (rev 04)
	Subsystem: 3Com Corporation 3C900B-TPO Etherlink XL TPO 10Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 12000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d800 [size=128]
	Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 SCSI storage controller: Adaptec 7892A (rev 02)
	Subsystem: Adaptec: Unknown device e2a0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: I/O ports at d400 [disabled] [size=256]
	Region 1: Memory at e4800000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HITACHI  Model: DK32CJ-18MC      Rev: J6A6
  Type:   Direct-Access                    ANSI SCSI revision: 03

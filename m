Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269247AbUINV6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269247AbUINV6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269553AbUINRJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:09:05 -0400
Received: from mileva.nscl.msu.edu ([35.8.61.11]:21004 "EHLO
	mileva.lite.msu.edu") by vger.kernel.org with ESMTP id S269536AbUINQyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:54:09 -0400
Message-Id: <200409141654.i8EGs3Hn029605@mileva.lite.msu.edu>
Subject: PROBLEM: kjournald Oops in 2.6.8
To: linux-kernel@vger.kernel.org
Date: Tue, 14 Sep 2004 12:54:03 -0400 (EDT)
From: Guy Albertelli II <guy@albertelli.com>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

1.
   Kernel Oops in kjournald


2.
   Server hung while under heavy load, upon reboot an Ooops was found
   in the logs
   - the main filesystem is ext3 on a Dell PowerEdge RAID Controller 3/DC
        using the megaraid driver
   - The particular build of the kernel is the Fedora Core 2 
        2.6.8-1.512smp kernel.

3.
   Oops, kjournald


4.
   Linux version 2.6.8-1.521smp (bhcompile@tweety.build.redhat.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 SMP Mon Aug 16 09:25:06 EDT 2004


5.
Sep 13 20:55:00 s10 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Sep 13 20:55:00 s10 kernel:  printing eip:
Sep 13 20:55:00 s10 kernel: f8861407
Sep 13 20:55:00 s10 kernel: *pde = 00003001
Sep 13 20:55:00 s10 kernel: Oops: 0002 [#1]
Sep 13 20:55:00 s10 kernel: SMP 
Sep 13 20:55:00 s10 kernel: Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables md5 ipv6 parport_pc lp parport autofs4 sunrpc tg3 floppy sg microcode st dm_mod ohci_hcd button battery asus_acpi ac ext3 jbd megaraid aic7xxx sd_mod scsi_mod
Sep 13 20:55:00 s10 kernel: CPU:    2
Sep 13 20:55:00 s10 kernel: EIP:    0060:[<f8861407>]    Not tainted
Sep 13 20:55:00 s10 kernel: EFLAGS: 00010202   (2.6.8-1.521smp) 
Sep 13 20:55:00 s10 kernel: EIP is at journal_commit_transaction+0x70c/0x13f7 [jbd]
Sep 13 20:55:00 s10 kernel: eax: 211da6ec   ebx: 00000000   ecx: 0196a980   edx: 00000000
Sep 13 20:55:00 s10 kernel: esi: 211da6ec   edi: e1f03a00   ebp: e1e38780   esp: e0aadda0
Sep 13 20:55:00 s10 kernel: ds: 007b   es: 007b   ss: 0068
Sep 13 20:55:00 s10 kernel: Process kjournald (pid: 1138, threadinfo=e0aad000 task=e0839370)
Sep 13 20:55:00 s10 kernel: Stack: 00000000 00000000 00000000 00000000 00000000 2c5d1a7c e1f03a00 5511ddac 
Sep 13 20:55:00 s10 kernel:        00000359 00000002 e0aade14 0211c589 000001f6 00000000 00000002 00000230 
Sep 13 20:55:00 s10 kernel:        0000015f 00000280 00000000 00000075 0240d1b8 0240d1d0 00000000 e0839370 
Sep 13 20:55:00 s10 kernel: Call Trace:
Sep 13 20:55:00 s10 kernel:  [<0211c589>] find_busiest_group+0xe6/0x2b7
Sep 13 20:55:00 s10 kernel:  [<0211ebdc>] autoremove_wake_function+0x0/0x2d
Sep 13 20:55:00 s10 kernel:  [<0211ebdc>] autoremove_wake_function+0x0/0x2d
Sep 13 20:55:00 s10 kernel:  [<f886418f>] kjournald+0x10d/0x326 [jbd]
Sep 13 20:55:00 s10 kernel:  [<0211ebdc>] autoremove_wake_function+0x0/0x2d
Sep 13 20:55:00 s10 kernel:  [<0211ebdc>] autoremove_wake_function+0x0/0x2d


6.
Only happened once so far.


7.1 ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux s10.lite.msu.edu 2.6.8-1.521smp #1 SMP Mon Aug 16 09:25:06 EDT 2004 i686 i686 i386 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12
mount                  2.12
module-init-tools      2.4.26
e2fsprogs              1.35
pcmcia-cs              3.2.7
quota-tools            3.10.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.0
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         md5 ipv6 parport_pc lp parport autofs4 sunrpc tg3 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables floppy sg microcode st dm_mod ohci_hcd button battery asus_acpi ac ext3 jbd megaraid aic7xxx sd_mod scsi_mod



7.2  /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 1.50GHz
stepping	: 2
cpu MHz		: 1492.645
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2932.73

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 1.50GHz
stepping	: 2
cpu MHz		: 1492.645
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2981.88

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 1.50GHz
stepping	: 2
cpu MHz		: 1492.645
cache size	: 512 KB
physical id	: 1
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2973.69

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 1.50GHz
stepping	: 2
cpu MHz		: 1492.645
cache size	: 512 KB
physical id	: 1
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2973.69

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 1.50GHz
stepping	: 2
cpu MHz		: 1492.645
cache size	: 512 KB
physical id	: 2
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2973.69

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 1.50GHz
stepping	: 2
cpu MHz		: 1492.645
cache size	: 512 KB
physical id	: 2
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2973.69

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 1.50GHz
stepping	: 2
cpu MHz		: 1492.645
cache size	: 512 KB
physical id	: 3
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2973.69

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 1.50GHz
stepping	: 2
cpu MHz		: 1492.645
cache size	: 512 KB
physical id	: 3
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2973.69


7.3 /proc/modules
md5 7745 1 - Live 0xf8a27000
ipv6 233701 36 - Live 0xf8b0f000
parport_pc 24577 0 - Live 0xf8a88000
lp 12461 0 - Live 0xf8a83000
parport 36489 2 parport_pc,lp, Live 0xf8a90000
autofs4 20165 0 - Live 0xf89f3000
sunrpc 128805 1 - Live 0xf8aa8000
tg3 79045 0 - Live 0xf8a5d000
ipt_REJECT 8897 1 - Live 0xf8a23000
ipt_state 5569 8 - Live 0xf8a20000
ip_conntrack 30929 1 ipt_state, Live 0xf8a2b000
iptable_filter 6209 1 - Live 0xf8876000
ip_tables 18497 3 ipt_REJECT,ipt_state,iptable_filter, Live 0xf89fa000
floppy 54481 0 - Live 0xf88a6000
sg 33377 0 - Live 0xf89e9000
microcode 10209 0 - Live 0xf8872000
st 34653 0 - Live 0xf89df000
dm_mod 49477 0 - Live 0xf88b6000
ohci_hcd 22097 0 - Live 0xf887a000
button 8793 0 - Live 0xf886e000
battery 11085 0 - Live 0xf8825000
asus_acpi 13017 0 - Live 0xf8832000
ac 7373 0 - Live 0xf8829000
ext3 99497 3 - Live 0xf88c4000
jbd 58457 1 ext3, Live 0xf885e000
megaraid 38153 4 - Live 0xf8853000
aic7xxx 145145 0 - Live 0xf8881000
sd_mod 20801 5 - Live 0xf881e000
scsi_mod 102025 5 sg,st,megaraid,aic7xxx,sd_mod, Live 0xf8839000



7.4 /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
08b0-08bf : 0000:00:0f.1
  08b0-08b7 : ide0
  08b8-08bf : ide1
0cf8-0cff : PCI conf1
9cf0-9cff : 0000:10:01.0
d000-dfff : PCI Bus #04
  dc00-dcff : 0000:04:01.0
e800-e8ff : 0000:00:04.0
ec00-ecff : 0000:00:03.0

/proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c93ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-dffeffff : System RAM
  00100000-002d9fff : Kernel code
  002da000-003922ff : Kernel data
dfff0000-dfffebff : ACPI Tables
dfffec00-dfffefff : reserved
ee800000-ee800fff : 0000:10:01.0
eff00000-eff0ffff : 0000:0a:02.0
  eff00000-eff0ffff : tg3
eff10000-eff1ffff : 0000:0a:01.0
  eff10000-eff1ffff : tg3
f0000000-f7ffffff : PCI Bus #04
  f0000000-f7ffffff : PCI Bus #05
    f0000000-f7ffffff : 0000:05:00.0
      f0000000-f000007f : megaraid
fcd00000-fcffffff : PCI Bus #04
  fcdff000-fcdfffff : 0000:04:01.0
  fcf00000-fcffffff : PCI Bus #05
fd000000-fdffffff : 0000:00:04.0
fe100000-fe100fff : 0000:00:0f.2
  fe100000-fe100fff : ohci_hcd
fe101000-fe101fff : 0000:00:04.0
fe102000-fe102fff : 0000:00:03.0
  fe102000-fe102fff : aic7xxx
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved


7.5 lspci -vvv

00:00.0 Host bridge: ServerWorks CMIC-HE (rev 22)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CMIC-HE
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 Host bridge: ServerWorks CMIC-HE
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 Host bridge: ServerWorks CMIC-HE
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 0109
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), Cache Line Size 10
	Interrupt: pin A routed to IRQ 177
	BIST result: 00
	Region 0: I/O ports at ec00 [disabled] [size=fe000000]
	Region 1: Memory at fe102000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 0109
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size 10
	Region 0: Memory at fd000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at e800 [size=256]
	Region 2: Memory at fe101000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
	Subsystem: ServerWorks CSB5 South Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 82 [Master PriP])
	Subsystem: ServerWorks CSB5 IDE Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 08b0 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
	Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fe100000 (32-bit, non-prefetchable)

00:0f.3 ISA bridge: ServerWorks CSB5 LPC bridge
	Subsystem: ServerWorks: Unknown device 0230
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:10.0 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit+ 133MHz+ SCD- USC-, DC=bridge, DMMRBC=0, DMOST=4, DMCRS=0, RSCEM-

00:10.2 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit+ 133MHz+ SCD- USC-, DC=bridge, DMMRBC=0, DMOST=4, DMCRS=0, RSCEM-

00:11.0 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit+ 133MHz+ SCD- USC-, DC=bridge, DMMRBC=0, DMOST=4, DMCRS=0, RSCEM-

00:11.2 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit+ 133MHz+ SCD- USC-, DC=bridge, DMMRBC=0, DMOST=4, DMCRS=0, RSCEM-

00:12.0 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit+ 133MHz+ SCD- USC-, DC=bridge, DMMRBC=0, DMOST=4, DMCRS=0, RSCEM-

00:12.2 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit+ 133MHz+ SCD- USC-, DC=bridge, DMMRBC=0, DMOST=4, DMCRS=0, RSCEM-

03:01.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=03, secondary=04, subordinate=05, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fcd00000-fcffffff
	Prefetchable memory behind bridge: 00000000f0000000-00000000f7f00000
	Expansion ROM at 0000d000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

04:00.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fcf00000-fcffffff
	Prefetchable memory behind bridge: 00000000f0000000-00000000f7f00000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

04:01.0 SCSI storage controller: QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI Processor (rev 06)
	Subsystem: American Megatrends Inc. QLA12160 on AMI MegaRAID
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), Cache Line Size 10
	Interrupt: pin A routed to IRQ 185
	Region 0: I/O ports at dc00 [size=fce00000]
	Region 1: Memory at fcdff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:00.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 20)
	Subsystem: Dell Computer Corporation PowerEdge RAID Controller 3/DC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 10
	Interrupt: pin A routed to IRQ 193
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=fcf00000]
	Expansion ROM at 00010000 [disabled]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0a:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5700 Gigabit Ethernet (rev 14)
	Subsystem: Dell Computer Corporation Broadcom BCM5700 1000Base-T
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), Cache Line Size 10
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at eff10000 (64-bit, non-prefetchable)
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=255 Dev=31 Func=1 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 04a02432c8020268  Data: 8901

0a:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5700 Gigabit Ethernet (rev 14)
	Subsystem: Dell Computer Corporation Broadcom BCM5700 1000Base-T
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), Cache Line Size 10
	Interrupt: pin A routed to IRQ 209
	Region 0: Memory at eff00000 (64-bit, non-prefetchable)
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=255 Dev=31 Func=1 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 66e27013323b4b3c  Data: d614

10:01.0 Modem: Broadcom Corporation BCM4212 v.90 56k modem (rev 02) (prog-if 00 [Generic])
	Subsystem: Dell Computer Corporation: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 217
	Region 0: Memory at ee800000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 9cf0 [size=16]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-



7.6 /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: QUANTUM  Model: SDLT320          Rev: 3131
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD 0 RAID5  173G Rev: 196T
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 04 Id: 06 Lun: 00
  Vendor: PE/PV    Model: 1x8 SCSI BP      Rev: 1.1 
  Type:   Processor                        ANSI SCSI revision: 02

-- 
guy@albertelli.com  LON-CAPA Developer  0-7-3-4-

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966205AbWKNQwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966205AbWKNQwt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966206AbWKNQwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:52:49 -0500
Received: from port254.ds1-he.adsl.cybercity.dk ([217.157.198.197]:43365 "EHLO
	gere.msconsult.dk") by vger.kernel.org with ESMTP id S966205AbWKNQwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:52:46 -0500
To: linux-kernel@vger.kernel.org
Subject: BUG: soft lockup detected on CPU#0! (2.6.18.2)
From: rasmus@msconsult.dk (=?utf-8?q?Rasmus_B=C3=B8g_Hansen?=)
Date: Tue, 14 Nov 2006 17:52:17 +0100
Message-ID: <867ixyvum6.fsf@gere.msconsult.dk>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Organization: MS Consult
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-MSC-MailScanner: Found to be clean
X-MSC-MailScanner-From: rasmus@msconsult.dk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

[1.] One line summary of the problem:

Kernel BUG's and freezes after a soft lockup.

[2.] Full description of the problem/report:

The night before sunday, my server froze. It was entirely dead and had
to be power cycled. There was no seriel console connected but it
managed to log a short BUG before, which seems related to smbfs.

As it happened in the night, I am unsure what triggered the bug, but
it was during the nightly backup routines, which includes running
rsync over ssh (over ADSL so pretty slow) and writing some large
.tar.bz2 to a smbfs drive. I assume (but do no know for sure) that it
was the last one that triggered the bug.

[3.] Keywords (i.e., modules, networking, kernel):

soft lockup, smbfs, SMP

[4.] Kernel version (from /proc/version):

Linux version 2.6.18.2 (root@gere) (gcc version 3.3.5 (Debian
1:3.3.5-13)) #1 SMP Wed Nov 8 10:00:34 CET 2006

[5.] Most recent kernel version which did not have the bug:

I never saw it before - it has been running 2.6.18.1 as well as 2.6.18

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Nov 12 03:54:57 gere kernel: BUG: soft lockup detected on CPU#0!
Nov 12 03:54:57 gere kernel:  [softlockup_tick+170/195] softlockup_tick+0xaa/0xc3
Nov 12 03:54:57 gere kernel:  [update_process_times+56/137] update_process_times+0x38/0x89
Nov 12 03:54:57 gere kernel:  [smp_apic_timer_interrupt+105/117] smp_apic_timer_interrupt+0x69/0x75
Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
Nov 12 03:54:57 gere kernel:  [apic_timer_interrupt+31/36] apic_timer_interrupt+0x1f/0x24
Nov 12 03:54:57 gere kernel:  [journal_init_revoke+49/678] journal_init_revoke+0x31/0x2a6
Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
Nov 12 03:54:57 gere kernel:  [__wake_up_common+63/94] __wake_up_common+0x3f/0x5e
Nov 12 03:54:57 gere kernel:  [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
Nov 12 03:54:57 gere kernel:  [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
Nov 12 03:54:57 gere kernel:  [smbiod+0/348] smbiod+0x0/0x15c
Nov 12 03:54:57 gere kernel:  [kthread+191/195] kthread+0xbf/0xc3
Nov 12 03:54:57 gere kernel:  [kthread+0/195] kthread+0x0/0xc3
Nov 12 03:54:57 gere kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

[7.] A small shell script or example program which triggers the
     problem (if possible)

I am not entirely sure how to reproduce the bug in a reliable manner
as backup routines since (and before) have been running flawlessly.

[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)

Debian stable with a few backports - output from ver_linux:

Linux gere 2.6.18.2 #1 SMP Wed Nov 8 10:00:34 CET 2006 i686 GNU/Linux
 
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Kbd                    [tilvalg...]
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         nls_cp865 nls_iso8859_15 nfsd exportfs lockd nfs_acl sunrpc parport_pc lp parport autofs4 dm_mod eeprom lm85 hwmon_vid hwmon i2c_i801 i2c_core rtc

[8.2.] Processor information (from /proc/cpuinfo):

P4 2.8GHz, running HT.

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 3
cpu MHz         : 2793.144
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe constant_tsc pni monitor ds_cpl cid
bogomips        : 5589.25

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 3
cpu MHz         : 2793.144
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe constant_tsc pni monitor ds_cpl cid
bogomips        : 5586.19

[8.3.] Module information (from /proc/modules):

nls_cp865 9856 0 - Live 0xe08ae000
nls_iso8859_15 8832 0 - Live 0xe08aa000
nfsd 109672 2 - Live 0xe0932000
exportfs 9216 1 nfsd, Live 0xe08a6000
lockd 69128 2 nfsd, Live 0xe08d5000
nfs_acl 7552 1 nfsd, Live 0xe0873000
sunrpc 155580 3 nfsd,lockd,nfs_acl, Live 0xe08ea000
parport_pc 38212 1 - Live 0xe08b4000
lp 13988 0 - Live 0xe0850000
parport 38600 2 parport_pc,lp, Live 0xe088a000
autofs4 23812 1 - Live 0xe0883000
dm_mod 60696 0 - Live 0xe0896000
eeprom 10128 0 - Live 0xe086b000
lm85 37284 0 - Live 0xe0878000
hwmon_vid 7168 1 lm85, Live 0xe0868000
hwmon 6788 1 lm85, Live 0xe085d000
i2c_i801 11532 0 - Live 0xe0859000
i2c_core 22528 3 eeprom,lm85,i2c_i801, Live 0xe0861000
rtc 12052 0 - Live 0xe0855000


[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

# cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fe2ffff : System RAM
  00100000-002c62ca : Kernel code
  002c62cb-003c9703 : Kernel data
1fe30000-1fe4149f : ACPI Non-volatile Storage
1fe414a0-1ff2ffff : System RAM
1ff30000-1ff3ffff : ACPI Tables
1ff40000-1ffeffff : ACPI Non-volatile Storage
1fff0000-1fffffff : reserved
30000000-300fffff : PCI Bus #03
  30000000-3001ffff : 0000:03:06.0
30100000-301003ff : 0000:00:1f.1
f8000000-fbffffff : 0000:00:00.0
fc900000-fc9fffff : PCI Bus #02
  fc9e0000-fc9fffff : 0000:02:01.0
fca00000-feafffff : PCI Bus #03
  fd000000-fdffffff : 0000:03:06.0
  feafe000-feafefff : 0000:03:08.0
    feafe000-feafefff : e100
  feaff000-feafffff : 0000:03:06.0
febffc00-febfffff : 0000:00:1d.7
fecf0000-fecf0fff : reserved
fed20000-fed9ffff : reserved
# cat /proc/ioports 
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0400-047f : 0000:00:1f.0
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0420-0420 : ACPI PM2_CNT_BLK
  0428-042f : ACPI GPE0_BLK
0500-053f : 0000:00:1f.0
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #02
  ac00-ac1f : 0000:02:01.0
b000-bfff : PCI Bus #03
  b800-b8ff : 0000:03:06.0
  bc00-bc3f : 0000:03:08.0
    bc00-bc3f : e100
c800-c81f : 0000:00:1f.3
  c800-c81f : i801_smbus
cc00-cc1f : 0000:00:1d.0
d000-d01f : 0000:00:1d.1
d400-d41f : 0000:00:1d.2
d800-d81f : 0000:00:1d.3
dc00-dc0f : 0000:00:1f.2
  dc00-dc0f : libata
e000-e003 : 0000:00:1f.2
  e000-e003 : libata
e400-e407 : 0000:00:1f.2
  e400-e407 : libata
e800-e803 : 0000:00:1f.2
  e800-e803 : libata
ec00-ec07 : 0000:00:1f.2
  ec00-ec07 : libata
ffa0-ffaf : 0000:00:1f.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

[8.5.] PCI information ('lspci -vvv' as root)


--=-=-=
Content-Disposition: inline; filename=lspci.txt
Content-Description: lspci

0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
	Subsystem: Intel Corp. 82875P Memory Controller Hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: fc900000-fc9fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at cc00 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at d000 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at d400 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at d800 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: 30000000-300fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 177
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at 30100000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 177
	Region 0: I/O ports at ec00 [size=8]
	Region 1: I/O ports at e800 [size=4]
	Region 2: I/O ports at e400 [size=8]
	Region 3: I/O ports at e000 [size=4]
	Region 4: I/O ports at dc00 [size=16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 185
	Region 4: I/O ports at c800 [size=32]

0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller (LOM)
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63750ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fc9e0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at ac00 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at b800 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 30000000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:03:08.0 Ethernet controller: Intel Corp. 82562EZ 10/100 Ethernet Controller (rev 01)
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at bc00 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


--=-=-=


[8.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3250823AS      Rev: 3.03
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3250823AS      Rev: 3.03
  Type:   Direct-Access                    ANSI SCSI revision: 05

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

The system runs from three ATA disks in RAID1 (one disk used as spare)
with some data on those disks too - the rest resides on the two SATA
disks (also RAID1).

The machine acts as a multipurpose server (mail, web, file server). It
has no particular high load and has never shown this behaviour
before.

The entire dmesg output (from kern.log) might be useful as well as my
.config:


--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kern.log
Content-Transfer-Encoding: quoted-printable
Content-Description: dmesg output

Nov  8 17:46:37 gere kernel: Linux version 2.6.18.2 (root@gere) (gcc versio=
n 3.3.5 (Debian 1:3.3.5-13)) #1 SMP Wed Nov 8 10:00:34 CET 2006
Nov  8 17:46:37 gere kernel: BIOS-provided physical RAM map:
Nov  8 17:46:37 gere kernel:  BIOS-e820: 0000000000000000 - 000000000009fc0=
0 (usable)
Nov  8 17:46:37 gere kernel:  BIOS-e820: 000000000009fc00 - 00000000000a000=
0 (reserved)
Nov  8 17:46:37 gere kernel:  BIOS-e820: 00000000000e6000 - 000000000010000=
0 (reserved)
Nov  8 17:46:37 gere kernel:  BIOS-e820: 0000000000100000 - 000000001fe3000=
0 (usable)
Nov  8 17:46:37 gere kernel:  BIOS-e820: 000000001fe30000 - 000000001fe414a=
0 (ACPI NVS)
Nov  8 17:46:37 gere kernel:  BIOS-e820: 000000001fe414a0 - 000000001ff3000=
0 (usable)
Nov  8 17:46:37 gere kernel:  BIOS-e820: 000000001ff30000 - 000000001ff4000=
0 (ACPI data)
Nov  8 17:46:37 gere kernel:  BIOS-e820: 000000001ff40000 - 000000001fff000=
0 (ACPI NVS)
Nov  8 17:46:37 gere kernel:  BIOS-e820: 000000001fff0000 - 000000002000000=
0 (reserved)
Nov  8 17:46:37 gere kernel:  BIOS-e820: 00000000fecf0000 - 00000000fecf100=
0 (reserved)
Nov  8 17:46:37 gere kernel:  BIOS-e820: 00000000fed20000 - 00000000feda000=
0 (reserved)
Nov  8 17:46:37 gere kernel: 511MB LOWMEM available.
Nov  8 17:46:37 gere kernel: found SMP MP-table at 000ff780
Nov  8 17:46:37 gere kernel: On node 0 totalpages: 130864
Nov  8 17:46:37 gere kernel:   DMA zone: 4096 pages, LIFO batch:0
Nov  8 17:46:37 gere kernel:   Normal zone: 126768 pages, LIFO batch:31
Nov  8 17:46:37 gere kernel: DMI 2.3 present.
Nov  8 17:46:37 gere kernel: ACPI: RSDP (v000 ACPIAM                       =
         ) @ 0x000f61a0
Nov  8 17:46:37 gere kernel: ACPI: RSDT (v001 INTEL  S875PWP3 0x20040429 MS=
FT 0x00000097) @ 0x1ff30000
Nov  8 17:46:37 gere kernel: ACPI: FADT (v002 INTEL  S875PWP3 0x20040429 MS=
FT 0x00000097) @ 0x1ff30200
Nov  8 17:46:37 gere kernel: ACPI: MADT (v001 INTEL  S875PWP3 0x20040429 MS=
FT 0x00000097) @ 0x1ff30300
Nov  8 17:46:37 gere kernel: ACPI: WDDT (v001 INTEL  OEMWDDT  0x00000001 MS=
FT 0x0100000d) @ 0x1ff345c0
Nov  8 17:46:37 gere kernel: ACPI: DSDT (v001 INTEL  S875PWP3 0x00000001 MS=
FT 0x0100000d) @ 0x00000000
Nov  8 17:46:37 gere kernel: ACPI: PM-Timer IO Port: 0x408
Nov  8 17:46:37 gere kernel: ACPI: Local APIC address 0xfee00000
Nov  8 17:46:37 gere kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enab=
led)
Nov  8 17:46:37 gere kernel: Processor #0 15:3 APIC version 20
Nov  8 17:46:37 gere kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enab=
led)
Nov  8 17:46:37 gere kernel: Processor #1 15:3 APIC version 20
Nov  8 17:46:37 gere kernel: ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x=
1])
Nov  8 17:46:37 gere kernel: ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x=
1])
Nov  8 17:46:37 gere kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi=
_base[0])
Nov  8 17:46:37 gere kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfe=
c00000, GSI 0-23
Nov  8 17:46:37 gere kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq =
2 dfl dfl)
Nov  8 17:46:37 gere kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq =
9 high level)
Nov  8 17:46:37 gere kernel: ACPI: IRQ0 used by override.
Nov  8 17:46:37 gere kernel: ACPI: IRQ2 used by override.
Nov  8 17:46:37 gere kernel: ACPI: IRQ9 used by override.
Nov  8 17:46:37 gere kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Nov  8 17:46:37 gere kernel: Using ACPI (MADT) for SMP configuration inform=
ation
Nov  8 17:46:37 gere kernel: Allocating PCI resources starting at 30000000 =
(gap: 20000000:decf0000)
Nov  8 17:46:37 gere kernel: Detected 2793.084 MHz processor.
Nov  8 17:46:37 gere kernel: Built 1 zonelists.  Total pages: 130864
Nov  8 17:46:37 gere kernel: Kernel command line: auto BOOT_IMAGE=3DLinux r=
o root=3D900
Nov  8 17:46:37 gere kernel: mapped APIC to ffffd000 (fee00000)
Nov  8 17:46:37 gere kernel: mapped IOAPIC to ffffc000 (fec00000)
Nov  8 17:46:37 gere kernel: Enabling fast FPU save and restore... done.
Nov  8 17:46:37 gere kernel: Enabling unmasked SIMD FPU exception support..=
. done.
Nov  8 17:46:37 gere kernel: Initializing CPU#0
Nov  8 17:46:37 gere kernel: PID hash table entries: 2048 (order: 11, 8192 =
bytes)
Nov  8 17:46:37 gere kernel: Console: colour VGA+ 80x25
Nov  8 17:46:37 gere kernel: Dentry cache hash table entries: 65536 (order:=
 6, 262144 bytes)
Nov  8 17:46:37 gere kernel: Inode-cache hash table entries: 32768 (order: =
5, 131072 bytes)
Nov  8 17:46:37 gere kernel: Memory: 514876k/523456k available (1816k kerne=
l code, 7840k reserved, 1037k data, 188k init, 0k highmem)
Nov  8 17:46:37 gere kernel: Checking if this processor honours the WP bit =
even in supervisor mode... Ok.
Nov  8 17:46:37 gere kernel: Calibrating delay using timer specific routine=
.. 5589.30 BogoMIPS (lpj=3D27946549)
Nov  8 17:46:37 gere kernel: Mount-cache hash table entries: 512
Nov  8 17:46:37 gere kernel: CPU: After generic identify, caps: bfebfbff 00=
000000 00000000 00000000 0000041d 00000000 00000000
Nov  8 17:46:37 gere kernel: CPU: After vendor identify, caps: bfebfbff 000=
00000 00000000 00000000 0000041d 00000000 00000000
Nov  8 17:46:37 gere kernel: monitor/mwait feature present.
Nov  8 17:46:37 gere kernel: using mwait in idle threads.
Nov  8 17:46:37 gere kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Nov  8 17:46:37 gere kernel: CPU: L2 cache: 1024K
Nov  8 17:46:37 gere kernel: CPU: Physical Processor ID: 0
Nov  8 17:46:37 gere kernel: CPU: After all inits, caps: bfebfbff 00000000 =
00000000 00000180 0000041d 00000000 00000000
Nov  8 17:46:37 gere kernel: Intel machine check architecture supported.
Nov  8 17:46:37 gere kernel: Intel machine check reporting enabled on CPU#0.
Nov  8 17:46:37 gere kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) ava=
ilable
Nov  8 17:46:37 gere kernel: CPU0: Thermal monitoring enabled
Nov  8 17:46:37 gere kernel: Compat vDSO mapped to ffffe000.
Nov  8 17:46:37 gere kernel: Checking 'hlt' instruction... OK.
Nov  8 17:46:37 gere kernel: Freeing SMP alternatives: 12k freed
Nov  8 17:46:37 gere kernel: ACPI: Core revision 20060707
Nov  8 17:46:37 gere kernel: CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz steppi=
ng 03
Nov  8 17:46:37 gere kernel: Booting processor 1/1 eip 2000
Nov  8 17:46:37 gere kernel: Initializing CPU#1
Nov  8 17:46:37 gere kernel: Calibrating delay using timer specific routine=
.. 5586.19 BogoMIPS (lpj=3D27930985)
Nov  8 17:46:37 gere kernel: CPU: After generic identify, caps: bfebfbff 00=
000000 00000000 00000000 0000041d 00000000 00000000
Nov  8 17:46:37 gere kernel: CPU: After vendor identify, caps: bfebfbff 000=
00000 00000000 00000000 0000041d 00000000 00000000
Nov  8 17:46:37 gere kernel: monitor/mwait feature present.
Nov  8 17:46:37 gere kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Nov  8 17:46:37 gere kernel: CPU: L2 cache: 1024K
Nov  8 17:46:37 gere kernel: CPU: Physical Processor ID: 0
Nov  8 17:46:37 gere kernel: CPU: After all inits, caps: bfebfbff 00000000 =
00000000 00000180 0000041d 00000000 00000000
Nov  8 17:46:37 gere kernel: Intel machine check architecture supported.
Nov  8 17:46:37 gere kernel: Intel machine check reporting enabled on CPU#1.
Nov  8 17:46:37 gere kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (12) ava=
ilable
Nov  8 17:46:37 gere kernel: CPU1: Thermal monitoring enabled
Nov  8 17:46:37 gere kernel: CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz steppi=
ng 03
Nov  8 17:46:37 gere kernel: Total of 2 processors activated (11175.50 Bogo=
MIPS).
Nov  8 17:46:37 gere kernel: ENABLING IO-APIC IRQs
Nov  8 17:46:37 gere kernel: ..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic=
2=3D-1 pin2=3D-1
Nov  8 17:46:37 gere kernel: checking TSC synchronization across 2 CPUs: pa=
ssed.
Nov  8 17:46:37 gere kernel: Brought up 2 CPUs
Nov  8 17:46:37 gere kernel: migration_cost=3D56
Nov  8 17:46:37 gere kernel: NET: Registered protocol family 16
Nov  8 17:46:37 gere kernel: ACPI: bus type pci registered
Nov  8 17:46:37 gere kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0031, =
last bus=3D3
Nov  8 17:46:37 gere kernel: PCI: Using configuration type 1
Nov  8 17:46:37 gere kernel: Setting up standard PCI resources
Nov  8 17:46:37 gere kernel: ACPI: Interpreter enabled
Nov  8 17:46:37 gere kernel: ACPI: Using IOAPIC for interrupt routing
Nov  8 17:46:37 gere kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Nov  8 17:46:37 gere kernel: PCI: Probing PCI hardware (bus 00)
Nov  8 17:46:37 gere kernel: PCI quirk: region 0400-047f claimed by ICH4 AC=
PI/GPIO/TCO
Nov  8 17:46:37 gere kernel: PCI quirk: region 0500-053f claimed by ICH4 GP=
IO
Nov  8 17:46:37 gere kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00=
:1f.1
Nov  8 17:46:37 gere kernel: Boot video device is 0000:03:06.0
Nov  8 17:46:37 gere kernel: PCI: Firmware left 0000:03:08.0 e100 interrupt=
s enabled, disabling
Nov  8 17:46:37 gere kernel: PCI: Transparent bridge - 0000:00:1e.0
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.=
_PRT]
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.=
P0P1._PRT]
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.=
P0P2._PRT]
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.=
P0P3._PRT]
Nov  8 17:46:37 gere kernel: ACPI: Power Resource [URP1] (off)
Nov  8 17:46:37 gere kernel: ACPI: Power Resource [URP2] (off)
Nov  8 17:46:37 gere kernel: ACPI: Power Resource [FDDP] (off)
Nov  8 17:46:37 gere kernel: ACPI: Power Resource [LPTP] (off)
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6=
 7 9 10 11 12 14 15)
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 =
7 9 10 *11 12 14 15)
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 =
7 9 *10 11 12 14 15)
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 =
7 *9 10 11 12 14 15)
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 =
7 9 10 *11 12 14 15)
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 =
7 9 10 11 12 14 15) *0, disabled.
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 =
7 9 10 11 12 14 15) *0, disabled.
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 =
7 *9 10 11 12 14 15)
Nov  8 17:46:37 gere kernel: Intel 82802 RNG detected
Nov  8 17:46:37 gere kernel: SCSI subsystem initialized
Nov  8 17:46:37 gere kernel: PCI: Using ACPI for IRQ routing
Nov  8 17:46:37 gere kernel: PCI: If a device doesn't work, try "pci=3Drout=
eirq".  If it helps, post a report
Nov  8 17:46:37 gere kernel: PCI: Bridge: 0000:00:01.0
Nov  8 17:46:37 gere kernel:   IO window: disabled.
Nov  8 17:46:37 gere kernel:   MEM window: disabled.
Nov  8 17:46:37 gere kernel:   PREFETCH window: disabled.
Nov  8 17:46:37 gere kernel: PCI: Bridge: 0000:00:03.0
Nov  8 17:46:37 gere kernel:   IO window: a000-afff
Nov  8 17:46:37 gere kernel:   MEM window: fc900000-fc9fffff
Nov  8 17:46:37 gere kernel:   PREFETCH window: disabled.
Nov  8 17:46:37 gere kernel: PCI: Bridge: 0000:00:1e.0
Nov  8 17:46:37 gere kernel:   IO window: b000-bfff
Nov  8 17:46:37 gere kernel:   MEM window: fca00000-feafffff
Nov  8 17:46:37 gere kernel:   PREFETCH window: 30000000-300fffff
Nov  8 17:46:37 gere kernel: PCI: Setting latency timer of device 0000:00:1=
e.0 to 64
Nov  8 17:46:37 gere kernel: NET: Registered protocol family 2
Nov  8 17:46:37 gere kernel: IP route cache hash table entries: 4096 (order=
: 2, 16384 bytes)
Nov  8 17:46:37 gere kernel: TCP established hash table entries: 16384 (ord=
er: 5, 131072 bytes)
Nov  8 17:46:37 gere kernel: TCP bind hash table entries: 8192 (order: 4, 6=
5536 bytes)
Nov  8 17:46:37 gere kernel: TCP: Hash tables configured (established 16384=
 bind 8192)
Nov  8 17:46:37 gere kernel: TCP reno registered
Nov  8 17:46:37 gere kernel: Machine check exception polling timer started.
Nov  8 17:46:37 gere kernel: Initializing Cryptographic API
Nov  8 17:46:37 gere kernel: io scheduler noop registered
Nov  8 17:46:37 gere kernel: io scheduler anticipatory registered (default)
Nov  8 17:46:37 gere kernel: e100: Intel(R) PRO/100 Network Driver, 3.5.10-=
k2-NAPI
Nov  8 17:46:37 gere kernel: e100: Copyright(c) 1999-2005 Intel Corporation
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt 0000:03:08.0[A] -> GSI 20 =
(level, low) -> IRQ 169
Nov  8 17:46:37 gere kernel: e100: eth0: e100_probe: addr 0xfeafe000, irq 1=
69, MAC addr 00:0C:F1:E8:33:ED
Nov  8 17:46:37 gere kernel: Uniform Multi-Platform E-IDE driver Revision: =
7.00alpha2
Nov  8 17:46:37 gere kernel: ide: Assuming 33MHz system bus speed for PIO m=
odes; override with idebus=3Dxx
Nov  8 17:46:37 gere kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Nov  8 17:46:37 gere kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 000=
7)
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 =
(level, low) -> IRQ 177
Nov  8 17:46:37 gere kernel: ICH5: chipset revision 2
Nov  8 17:46:37 gere kernel: ICH5: not 100%% native mode: will probe irqs l=
ater
Nov  8 17:46:37 gere kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settin=
gs: hda:DMA, hdb:DMA
Nov  8 17:46:37 gere kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settin=
gs: hdc:DMA, hdd:DMA
Nov  8 17:46:37 gere kernel: Probing IDE interface ide0...
Nov  8 17:46:37 gere kernel: hda: WDC WD1200JB-00DUA3, ATA DISK drive
Nov  8 17:46:37 gere kernel: hdb: WDC WD1200JB-00DUA3, ATA DISK drive
Nov  8 17:46:37 gere kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov  8 17:46:37 gere kernel: Probing IDE interface ide1...
Nov  8 17:46:37 gere kernel: hdc: WDC WD1200JB-00DUA3, ATA DISK drive
Nov  8 17:46:37 gere kernel: hdd: GCR-8523B, ATAPI CD/DVD-ROM drive
Nov  8 17:46:37 gere kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov  8 17:46:37 gere kernel: hda: max request size: 512KiB
Nov  8 17:46:37 gere kernel: hda: 234441648 sectors (120034 MB) w/8192KiB C=
ache, CHS=3D16383/255/63, UDMA(100)
Nov  8 17:46:37 gere kernel: hda: cache flushes supported
Nov  8 17:46:37 gere kernel:  hda: hda1 hda2 hda3 hda4
Nov  8 17:46:37 gere kernel: hdb: max request size: 512KiB
Nov  8 17:46:37 gere kernel: hdb: 234441648 sectors (120034 MB) w/8192KiB C=
ache, CHS=3D16383/255/63, UDMA(100)
Nov  8 17:46:37 gere kernel: hdb: cache flushes supported
Nov  8 17:46:37 gere kernel:  hdb: hdb1 hdb2 hdb3 hdb4
Nov  8 17:46:37 gere kernel: hdc: max request size: 512KiB
Nov  8 17:46:37 gere kernel: hdc: 234441648 sectors (120034 MB) w/8192KiB C=
ache, CHS=3D16383/255/63, UDMA(100)
Nov  8 17:46:37 gere kernel: hdc: cache flushes supported
Nov  8 17:46:37 gere kernel:  hdc: hdc1 hdc2 hdc3 hdc4
Nov  8 17:46:37 gere kernel: libata version 2.00 loaded.
Nov  8 17:46:37 gere kernel: ata_piix 0000:00:1f.2: version 2.00
Nov  8 17:46:37 gere kernel: ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 =
(level, low) -> IRQ 177
Nov  8 17:46:37 gere kernel: PCI: Setting latency timer of device 0000:00:1=
f.2 to 64
Nov  8 17:46:37 gere kernel: ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 =
bmdma 0xDC00 irq 177
Nov  8 17:46:37 gere kernel: ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 =
bmdma 0xDC08 irq 177
Nov  8 17:46:37 gere kernel: scsi0 : ata_piix
Nov  8 17:46:37 gere kernel: ata1.00: ATA-7, max UDMA/133, 488397168 sector=
s: LBA48 NCQ (depth 0/32)
Nov  8 17:46:37 gere kernel: ata1.00: ata1: dev 0 multi count 16
Nov  8 17:46:37 gere kernel: ata1.00: configured for UDMA/133
Nov  8 17:46:37 gere kernel: scsi1 : ata_piix
Nov  8 17:46:37 gere kernel: ata2.00: ATA-7, max UDMA/133, 488397168 sector=
s: LBA48 NCQ (depth 0/32)
Nov  8 17:46:37 gere kernel: ata2.00: ata2: dev 0 multi count 16
Nov  8 17:46:37 gere kernel: ata2.00: configured for UDMA/133
Nov  8 17:46:37 gere kernel:   Vendor: ATA       Model: ST3250823AS       R=
ev: 3.03
Nov  8 17:46:37 gere kernel:   Type:   Direct-Access                      A=
NSI SCSI revision: 05
Nov  8 17:46:37 gere kernel:   Vendor: ATA       Model: ST3250823AS       R=
ev: 3.03
Nov  8 17:46:37 gere kernel:   Type:   Direct-Access                      A=
NSI SCSI revision: 05
Nov  8 17:46:37 gere kernel: SCSI device sda: 488397168 512-byte hdwr secto=
rs (250059 MB)
Nov  8 17:46:37 gere kernel: sda: Write Protect is off
Nov  8 17:46:37 gere kernel: sda: Mode Sense: 00 3a 00 00
Nov  8 17:46:37 gere kernel: SCSI device sda: drive cache: write back
Nov  8 17:46:37 gere kernel: SCSI device sda: 488397168 512-byte hdwr secto=
rs (250059 MB)
Nov  8 17:46:37 gere kernel: sda: Write Protect is off
Nov  8 17:46:37 gere kernel: sda: Mode Sense: 00 3a 00 00
Nov  8 17:46:37 gere kernel: SCSI device sda: drive cache: write back
Nov  8 17:46:37 gere kernel:  sda: sda1
Nov  8 17:46:37 gere kernel: sd 0:0:0:0: Attached scsi disk sda
Nov  8 17:46:37 gere kernel: SCSI device sdb: 488397168 512-byte hdwr secto=
rs (250059 MB)
Nov  8 17:46:37 gere kernel: sdb: Write Protect is off
Nov  8 17:46:37 gere kernel: sdb: Mode Sense: 00 3a 00 00
Nov  8 17:46:37 gere kernel: SCSI device sdb: drive cache: write back
Nov  8 17:46:37 gere kernel: SCSI device sdb: 488397168 512-byte hdwr secto=
rs (250059 MB)
Nov  8 17:46:37 gere kernel: sdb: Write Protect is off
Nov  8 17:46:37 gere kernel: sdb: Mode Sense: 00 3a 00 00
Nov  8 17:46:37 gere kernel: SCSI device sdb: drive cache: write back
Nov  8 17:46:37 gere kernel:  sdb: sdb1
Nov  8 17:46:37 gere kernel: sd 1:0:0:0: Attached scsi disk sdb
Nov  8 17:46:37 gere kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov  8 17:46:37 gere kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov  8 17:46:37 gere kernel: mice: PS/2 mouse device common for all mice
Nov  8 17:46:37 gere kernel: md: raid1 personality registered for level 1
Nov  8 17:46:37 gere kernel: md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_=
DISKS=3D27
Nov  8 17:46:37 gere kernel: md: bitmap version 4.39
Nov  8 17:46:37 gere kernel: EDAC MC: Ver: 2.0.1 Nov  8 2006
Nov  8 17:46:37 gere kernel: EDAC i82875p: i82875p init one
Nov  8 17:46:37 gere kernel: PCI: Unable to reserve mem region #1:1000@fecf=
0000 for device 0000:00:06.0
Nov  8 17:46:37 gere kernel: EDAC MC0: Giving out device to i82875p_edac i8=
2875p: DEV 0000:00:00.0
Nov  8 17:46:37 gere kernel: TCP bic registered
Nov  8 17:46:37 gere kernel: NET: Registered protocol family 1
Nov  8 17:46:37 gere kernel: NET: Registered protocol family 17
Nov  8 17:46:37 gere kernel: Starting balanced_irq
Nov  8 17:46:37 gere kernel: Using IPI Shortcut mode
Nov  8 17:46:37 gere kernel: md: Autodetecting RAID arrays.
Nov  8 17:46:37 gere kernel: Time: tsc clocksource has been installed.
Nov  8 17:46:37 gere kernel: md: autorun ...
Nov  8 17:46:37 gere kernel: md: considering sdb1 ...
Nov  8 17:46:37 gere kernel: md:  adding sdb1 ...
Nov  8 17:46:37 gere kernel: md:  adding sda1 ...
Nov  8 17:46:37 gere kernel: md: hdc4 has different UUID to sdb1
Nov  8 17:46:37 gere kernel: md: hdc3 has different UUID to sdb1
Nov  8 17:46:37 gere kernel: md: hdc1 has different UUID to sdb1
Nov  8 17:46:37 gere kernel: md: hdb4 has different UUID to sdb1
Nov  8 17:46:37 gere kernel: md: hdb3 has different UUID to sdb1
Nov  8 17:46:37 gere kernel: md: hdb1 has different UUID to sdb1
Nov  8 17:46:37 gere kernel: md: hda4 has different UUID to sdb1
Nov  8 17:46:37 gere kernel: md: hda3 has different UUID to sdb1
Nov  8 17:46:37 gere kernel: md: hda1 has different UUID to sdb1
Nov  8 17:46:37 gere kernel: md: created md3
Nov  8 17:46:37 gere kernel: md: bind<sda1>
Nov  8 17:46:37 gere kernel: md: bind<sdb1>
Nov  8 17:46:37 gere kernel: md: running: <sdb1><sda1>
Nov  8 17:46:37 gere kernel: raid1: raid set md3 active with 2 out of 2 mir=
rors
Nov  8 17:46:37 gere kernel: md: considering hdc4 ...
Nov  8 17:46:37 gere kernel: md:  adding hdc4 ...
Nov  8 17:46:37 gere kernel: md: hdc3 has different UUID to hdc4
Nov  8 17:46:37 gere kernel: md: hdc1 has different UUID to hdc4
Nov  8 17:46:37 gere kernel: md:  adding hdb4 ...
Nov  8 17:46:37 gere kernel: md: hdb3 has different UUID to hdc4
Nov  8 17:46:37 gere kernel: md: hdb1 has different UUID to hdc4
Nov  8 17:46:37 gere kernel: md:  adding hda4 ...
Nov  8 17:46:37 gere kernel: md: hda3 has different UUID to hdc4
Nov  8 17:46:37 gere kernel: md: hda1 has different UUID to hdc4
Nov  8 17:46:37 gere kernel: md: created md2
Nov  8 17:46:37 gere kernel: md: bind<hda4>
Nov  8 17:46:37 gere kernel: md: bind<hdb4>
Nov  8 17:46:37 gere kernel: md: bind<hdc4>
Nov  8 17:46:37 gere kernel: md: running: <hdc4><hdb4><hda4>
Nov  8 17:46:37 gere kernel: raid1: raid set md2 active with 2 out of 2 mir=
rors
Nov  8 17:46:37 gere kernel: md: considering hdc3 ...
Nov  8 17:46:37 gere kernel: md:  adding hdc3 ...
Nov  8 17:46:37 gere kernel: md: hdc1 has different UUID to hdc3
Nov  8 17:46:37 gere kernel: md:  adding hdb3 ...
Nov  8 17:46:37 gere kernel: md: hdb1 has different UUID to hdc3
Nov  8 17:46:37 gere kernel: md:  adding hda3 ...
Nov  8 17:46:37 gere kernel: md: hda1 has different UUID to hdc3
Nov  8 17:46:37 gere kernel: md: created md1
Nov  8 17:46:37 gere kernel: md: bind<hda3>
Nov  8 17:46:37 gere kernel: md: bind<hdb3>
Nov  8 17:46:37 gere kernel: md: bind<hdc3>
Nov  8 17:46:37 gere kernel: md: running: <hdc3><hdb3><hda3>
Nov  8 17:46:37 gere kernel: raid1: raid set md1 active with 2 out of 2 mir=
rors
Nov  8 17:46:37 gere kernel: md: considering hdc1 ...
Nov  8 17:46:37 gere kernel: md:  adding hdc1 ...
Nov  8 17:46:37 gere kernel: md:  adding hdb1 ...
Nov  8 17:46:37 gere kernel: md:  adding hda1 ...
Nov  8 17:46:37 gere kernel: md: created md0
Nov  8 17:46:37 gere kernel: md: bind<hda1>
Nov  8 17:46:37 gere kernel: md: bind<hdb1>
Nov  8 17:46:37 gere kernel: md: bind<hdc1>
Nov  8 17:46:37 gere kernel: md: running: <hdc1><hdb1><hda1>
Nov  8 17:46:37 gere kernel: raid1: raid set md0 active with 2 out of 2 mir=
rors
Nov  8 17:46:37 gere kernel: md: ... autorun DONE.
Nov  8 17:46:37 gere kernel: input: AT Translated Set 2 keyboard as /class/=
input/input0
Nov  8 17:46:37 gere kernel: kjournald starting.  Commit interval 5 seconds
Nov  8 17:46:37 gere kernel: EXT3-fs: mounted filesystem with ordered data =
mode.
Nov  8 17:46:37 gere kernel: VFS: Mounted root (ext3 filesystem) readonly.
Nov  8 17:46:37 gere kernel: Freeing unused kernel memory: 188k freed
Nov  8 17:46:37 gere kernel: Write protecting the kernel read-only data: 66=
9k
Nov  8 17:46:37 gere kernel: Adding 248996k swap on /dev/hda2.  Priority:1 =
extents:1 across:248996k
Nov  8 17:46:37 gere kernel: Adding 248996k swap on /dev/hdc2.  Priority:1 =
extents:1 across:248996k
Nov  8 17:46:37 gere kernel: EXT3 FS on md0, internal journal
Nov  8 17:46:37 gere kernel: Real Time Clock Driver v1.12ac
Nov  8 17:46:37 gere kernel: ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 =
(level, low) -> IRQ 185
Nov  8 17:46:37 gere kernel: device-mapper: ioctl: 4.7.0-ioctl (2006-06-24)=
 initialised: dm-devel@redhat.com
Nov  8 17:46:37 gere kernel: kjournald starting.  Commit interval 5 seconds
Nov  8 17:46:37 gere kernel: EXT3 FS on md1, internal journal
Nov  8 17:46:37 gere kernel: EXT3-fs: mounted filesystem with ordered data =
mode.
Nov  8 17:46:37 gere kernel: kjournald starting.  Commit interval 5 seconds
Nov  8 17:46:37 gere kernel: EXT3 FS on md2, internal journal
Nov  8 17:46:37 gere kernel: EXT3-fs: mounted filesystem with ordered data =
mode.
Nov  8 17:46:37 gere kernel: kjournald starting.  Commit interval 5 seconds
Nov  8 17:46:37 gere kernel: EXT3 FS on md3, internal journal
Nov  8 17:46:37 gere kernel: EXT3-fs: mounted filesystem with ordered data =
mode.
Nov  8 17:46:37 gere kernel: e100: eth0: e100_watchdog: link up, 100Mbps, f=
ull-duplex
Nov  8 17:46:37 gere kernel: IA-32 Microcode Update Driver: v1.14a <tigran@=
veritas.com>
Nov  8 17:46:37 gere kernel: microcode: CPU1 updated from revision 0x9 to 0=
xb, date =3D 05122004=20
Nov  8 17:46:37 gere kernel: microcode: CPU0 updated from revision 0x9 to 0=
xb, date =3D 05122004=20
Nov  8 17:46:37 gere kernel: process `syslogd' is using obsolete setsockopt=
 SO_BSDCOMPAT
Nov  8 17:46:40 gere kernel: parport0: PC-style at 0x378 [PCSPP,TRISTATE,EP=
P]
Nov  8 17:46:40 gere kernel: lp0: using parport0 (polling).
Nov  8 17:46:53 gere kernel: Installing knfsd (copyright (C) 1996 okir@mona=
d.swb.de).
Nov  9 02:30:00 gere kernel: smb_create: BUDGET/.bogf=C2=A2ring.doc.uyAYcs =
failed, error=3D-2
Nov  9 02:30:00 gere kernel: smb_create: BUDGET/.budget.k=C2=A2kken.990908.=
xls.p8JOYx failed, error=3D-2
Nov  9 02:30:00 gere kernel: smb_create: BUDGET/.=C2=A2nskeliste.jul99.xls.=
81HZKD failed, error=3D-2
Nov 10 02:29:57 gere kernel: smb_create: BUDGET/.bogf=C2=A2ring.doc.CLcUDu =
failed, error=3D-2
Nov 10 02:29:57 gere kernel: smb_create: BUDGET/.budget.k=C2=A2kken.990908.=
xls.GrXVlK failed, error=3D-2
Nov 10 02:29:57 gere kernel: smb_create: BUDGET/.=C2=A2nskeliste.jul99.xls.=
Y6Fg4Z failed, error=3D-2
Nov 11 02:29:57 gere kernel: smb_create: BUDGET/.bogf=C2=A2ring.doc.ohlRzs =
failed, error=3D-2
Nov 11 02:29:57 gere kernel: smb_create: BUDGET/.budget.k=C2=A2kken.990908.=
xls.1PdTMY failed, error=3D-2
Nov 11 02:29:57 gere kernel: smb_create: BUDGET/.=C2=A2nskeliste.jul99.xls.=
H3ne0u failed, error=3D-2
Nov 12 02:29:59 gere kernel: smb_create: BUDGET/.bogf=C2=A2ring.doc.ZR8ooX =
failed, error=3D-2
Nov 12 02:29:59 gere kernel: smb_create: BUDGET/.budget.k=C2=A2kken.990908.=
xls.XhDbfQ failed, error=3D-2
Nov 12 02:29:59 gere kernel: smb_create: BUDGET/.=C2=A2nskeliste.jul99.xls.=
g9lh6I failed, error=3D-2
Nov 12 03:54:57 gere kernel: BUG: soft lockup detected on CPU#0!
Nov 12 03:54:57 gere kernel:  [softlockup_tick+170/195] softlockup_tick+0xa=
a/0xc3
Nov 12 03:54:57 gere kernel:  [update_process_times+56/137] update_process_=
times+0x38/0x89
Nov 12 03:54:57 gere kernel:  [smp_apic_timer_interrupt+105/117] smp_apic_t=
imer_interrupt+0x69/0x75
Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
Nov 12 03:54:57 gere kernel:  [apic_timer_interrupt+31/36] apic_timer_inter=
rupt+0x1f/0x24
Nov 12 03:54:57 gere kernel:  [journal_init_revoke+49/678] journal_init_rev=
oke+0x31/0x2a6
Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
Nov 12 03:54:57 gere kernel:  [__wake_up_common+63/94] __wake_up_common+0x3=
f/0x5e
Nov 12 03:54:57 gere kernel:  [autoremove_wake_function+0/87] autoremove_wa=
ke_function+0x0/0x57
Nov 12 03:54:57 gere kernel:  [autoremove_wake_function+0/87] autoremove_wa=
ke_function+0x0/0x57
Nov 12 03:54:57 gere kernel:  [smbiod+0/348] smbiod+0x0/0x15c
Nov 12 03:54:57 gere kernel:  [kthread+191/195] kthread+0xbf/0xc3
Nov 12 03:54:57 gere kernel:  [kthread+0/195] kthread+0x0/0xc3
Nov 12 03:54:57 gere kernel:  [kernel_thread_helper+5/11] kernel_thread_hel=
per+0x5/0xb

--=-=-=
Content-Disposition: inline; filename=config-2.6.18.2
Content-Description: .config

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.18.2
# Wed Nov  8 09:55:00 2006
#
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_CPUSETS is not set
CONFIG_RELAY=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
# CONFIG_LBD is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_LSF=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=m
CONFIG_IOSCHED_CFQ=m
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
# CONFIG_HPET_TIMER is not set
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_BKL is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=0x100000
# CONFIG_HOTPLUG_CPU is not set
CONFIG_COMPAT_VDSO=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_SATA_INTEL_COMBINED=y
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID456=m
# CONFIG_MD_RAID5_RESHAPE is not set
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_LXT_PHY=m
CONFIG_CICADA_PHY=m
CONFIG_VITESSE_PHY=m
CONFIG_SMSC_PHY=m
CONFIG_FIXED_PHY=m
# CONFIG_FIXED_MII_10_FDX is not set
# CONFIG_FIXED_MII_100_FDX is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_GEODE is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=m
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_RTC_IRQ=y
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=m
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
CONFIG_SENSORS_EEPROM=m
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
CONFIG_VIDEO_V4L2=y

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=y
# CONFIG_FB is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
# CONFIG_VIDEO_SELECT is not set
CONFIG_DUMMY_CONSOLE=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
CONFIG_MMC=m
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_BLOCK=m
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=m

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
CONFIG_EDAC=y

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=y
# CONFIG_EDAC_AMD76X is not set
CONFIG_EDAC_E7XXX=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82875P=y
CONFIG_EDAC_I82860=m
# CONFIG_EDAC_R82600 is not set
CONFIG_EDAC_POLL=y

#
# Real Time Clock
#
CONFIG_RTC_LIB=m
CONFIG_RTC_CLASS=m

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=m
CONFIG_RTC_INTF_PROC=m
CONFIG_RTC_INTF_DEV=m
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set

#
# RTC drivers
#
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_TEST is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# DMA Engine support
#
CONFIG_DMA_ENGINE=y

#
# DMA Clients
#
CONFIG_NET_DMA=y

#
# DMA Devices
#
CONFIG_INTEL_IOATDMA=m

#
# File systems
#
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=m
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=m

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_SPKM3=m
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp865"
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_VM is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_UNWIND_INFO=y
# CONFIG_STACK_UNWIND is not set
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUG_RODATA=y
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_PLIST=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


I will, of course, post useful information, if necessary.

Regards
/Rasmus

--=20
Rasmus B=C3=B8g Hansen
MSC Aps
B=C3=B8gesvinget 8
2740 Skovlunde
44 53 93 66

--=-=-=--


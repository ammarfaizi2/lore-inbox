Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263232AbUEBVN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbUEBVN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 17:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUEBVN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 17:13:29 -0400
Received: from mail3.absamail.co.za ([196.35.40.69]:28485 "EHLO absamail.co.za")
	by vger.kernel.org with ESMTP id S263232AbUEBVNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 17:13:01 -0400
Subject: [BUG 2.6.6-rc2-mm1] rmmod processor causes kernel panic on
	speedstep-centrino
From: Niel Lambrechts <antispam@absamail.co.za>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1083532317.18059.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 02 May 2004 23:11:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Problem:
rmmod processor causes kernel panic on speedstep-centrino

Description:
I read somewhere that module "processor" affects madwifi performance, so
I decided to remove the module. (I had to rmmod thermal as well) This
caused a kernel panic, yet the thinkpad is still up and seemingly, fully
functional and used to submit this report with.

Kernel version:
2.6.6-rc2-mm1, with own dsdt.

Output: (after rmmod processor)
Badness in remove_proc_entry at fs/proc/generic.c:685
Call Trace:
 [<c01865fc>] remove_proc_entry+0x17c/0x190
 [<e19d3940>] acpi_thermal_remove_fs+0x48/0x6b [thermal]
 [<e19d3dcb>] acpi_thermal_remove+0xd0/0xed [thermal]
 [<c02a73bb>] acpi_driver_detach+0x63/0xbc
 [<c02a7501>] acpi_bus_unregister_driver+0x3c/0x92
 [<e19d3e1b>] acpi_thermal_exit+0x33/0x53 [thermal]
 [<c012fa59>] sys_delete_module+0x159/0x1b0
 [<c01489f8>] do_munmap+0x158/0x1b0
 [<c010619b>] syscall_call+0x7/0xb

Badness in remove_proc_entry at fs/proc/generic.c:685
Call Trace:
 [<c01865fc>] remove_proc_entry+0x17c/0x190
 [<e19dd323>] acpi_processor_remove_fs+0x48/0x6b [processor]
 [<e19dd89c>] acpi_processor_remove+0x98/0xc7 [processor]
 [<c02a73bb>] acpi_driver_detach+0x63/0xbc
 [<c02a7501>] acpi_bus_unregister_driver+0x3c/0x92
 [<e19dd96d>] acpi_processor_exit+0x3d/0x5d [processor]
 [<c012fa59>] sys_delete_module+0x159/0x1b0
 [<c01489f8>] do_munmap+0x158/0x1b0
 [<c010619b>] syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address e19db3e6
 printing eip:
e19db3e6
*pde = 1fdc8067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<e19db3e6>]    Tainted: PF  VLI
EFLAGS: 00010296   (2.6.6-rc2-mm1)
EIP is at 0xe19db3e6
eax: 00000000   ebx: 00ba74be   ecx: 00000000   edx: 00000000
esi: dfca76f8   edi: 00ba71ed   ebp: dfca7600   esp: c04e5fc0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c04e4000 task=c0455a40)
Stack: 00569007 00000000 c04e4000 0009ef00 c0512120 00569007 c01040dd
00000816
       c04e684e c0455a40 00000000 c050ac64 00000040 c04e6450 c0513020
c010019f
Call Trace:
 [<c01040dd>] cpu_idle+0x2d/0x40
 [<c04e684e>] start_kernel+0x18e/0x1d0
 [<c04e6450>] unknown_bootoption+0x0/0x130

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <6>ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (39 C)
     osl-0889 [4473527] os_wait_semaphore     : Failed to acquire
semaphore[dff5ee40|1|0], AE_TIME
     osl-0889 [4492698] os_wait_semaphore     : Failed to acquire
semaphore[dff5ee40|1|0], AE_TIME
     osl-0889 [4517096] os_wait_semaphore     : Failed to acquire
semaphore[dff5ee40|1|0], AE_TIME

Activity at time of problem:
ath_pci : madwifi wireless driver modules in use: ath_pci, ath_hal, wlan
boot options: acpi=yes, resume=/dev/hda2 (i use swsusp)

Environment:
Thinkpad R50P
SuSE 9.0 pro

Software:
# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux ksyrium 2.6.6-rc2-mm1 #10 Mon Apr 26 09:41:13 SAST 2004 i686 i686
i386 GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
binutils               2.14.90.0.5
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.14-pre2
e2fsprogs              1.34
jfsutils               1.1.2
xfsprogs               2.5.6
pcmcia-cs              3.2.4
PPP                    2.4.1
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        x    1 root     root      1470060 Oct  2  2003
/lib/libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.1.14
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         thermal processor ath_pci wlan ath_hal ipaq vmnet
vmmon nls_iso8859_15 nls_cp437 vfat fat sd_mod usb_storage snd_pcm_oss
e1000 snd_mixer_oss nvram usbserial ipv6 snd_intel8x0 snd_ac97_codec
snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi
snd_seq_device snd soundcore uhci_hcd ohci_hcd ehci_hcd usbcore
speedstep_centrino battery fan ac button ide_scsi nls_iso8859_1


Processor:
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1700MHz
stepping        : 5
cpu MHz         : 598.161
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov
pat clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
bogomips        : 1185.43

Module info:
# cat /proc/modules
thermal 18064 0 - Live 0xe19d2000
processor 25264 1 thermal, Live 0xe1bc9000
ath_pci 40996 0 - Live 0xe1a7c000
wlan 64104 2 ath_pci, Live 0xe1b34000
ath_hal 129040 2 ath_pci, Live 0xe1bee000
ipaq 11864 0 - Live 0xe1bc5000
vmnet 30864 12 - Live 0xe1ac3000
vmmon 48920 0 - Live 0xe1ba7000
nls_iso8859_15 4672 0 - Live 0xe1a50000
nls_cp437 5760 0 - Live 0xe1a4d000
vfat 16256 0 - Live 0xe1a59000
fat 46720 1 vfat, Live 0xe1b9a000
sd_mod 19456 0 - Live 0xe1a53000
usb_storage 71904 0 - Live 0xe1b87000
snd_pcm_oss 63588 0 - Live 0xe1b23000
e1000 86220 0 - Live 0xe1a65000
snd_mixer_oss 21952 4 snd_pcm_oss, Live 0xe1afb000
nvram 9288 1 - Live 0xe1aa0000
usbserial 29552 1 ipaq, Live 0xe1aac000
ipv6 261216 10 - Live 0xe1b46000
snd_intel8x0 36996 4 - Live 0xe1ab8000
snd_ac97_codec 68164 1 snd_intel8x0, Live 0xe1ae9000
snd_pcm 109924 3 snd_pcm_oss,snd_intel8x0, Live 0xe1acd000
snd_timer 28612 1 snd_pcm, Live 0xe1aa4000
snd_page_alloc 12420 2 snd_intel8x0,snd_pcm, Live 0xe19eb000
snd_mpu401_uart 8832 1 snd_intel8x0, Live 0xe1a3a000
snd_rawmidi 27040 1 snd_mpu401_uart, Live 0xe1a43000
snd_seq_device 8776 1 snd_rawmidi, Live 0xe1a36000
snd 65860 10
snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xe1a88000
soundcore 10016 4 snd, Live 0xe19f0000
uhci_hcd 32984 0 - Live 0xe1a2c000
ohci_hcd 33820 0 - Live 0xe1a02000
ehci_hcd 41800 0 - Live 0xe19f6000
usbcore 121396 8 ipaq,usb_storage,usbserial,uhci_hcd,ohci_hcd,ehci_hcd,
Live 0xe1a0d000
speedstep_centrino 5700 0 - Live 0xe19e6000
battery 12108 0 - Live 0xe19c5000
fan 5324 0 - Live 0xe19d8000
ac 6348 0 - Live 0xe19c9000
button 8024 0 - Live 0xe198e000
ide_scsi 17668 0 - Live 0xe19cc000
nls_iso8859_1 4096 3 - Live 0xe1991000

Loaded drivers:
# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03bc-03be : parport0
03c0-03df : vesafb
03e0-03e1 : i82365
03f6-03f6 : ide0
03f8-03ff : serial
04d0-04d1 : pnp 00:0b
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-105f : pnp 00:0b
  1060-107f : pnp 00:0b
1180-11bf : 0000:00:1f.0
  1180-11bf : pnp 00:0b
1800-181f : 0000:00:1d.0
  1800-181f : uhci_hcd
1820-183f : 0000:00:1d.1
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.2
  1840-185f : uhci_hcd
1860-186f : 0000:00:1f.1
  1860-1867 : ide0
  1868-186f : ide1
1880-189f : 0000:00:1f.3
18c0-18ff : 0000:00:1f.5
1c00-1cff : 0000:00:1f.5
2000-207f : 0000:00:1f.6
2400-24ff : 0000:00:1f.6
3000-3fff : PCI Bus #01
  3000-30ff : 0000:01:00.0
4000-40ff : PCI CardBus #03
4400-44ff : PCI CardBus #03
4800-48ff : PCI CardBus #07
4c00-4cff : PCI CardBus #07
8000-803f : 0000:02:01.0
  8000-803f : e1000

# cat /proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000d0000-000d0fff : Adapter ROM
000d1000-000d1fff : Adapter ROM
000d2000-000d3fff : reserved
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ff5ffff : System RAM
  00100000-003d39ac : Kernel code
  003d39ad-004e213f : Kernel data
1ff60000-1ff77fff : ACPI Tables
1ff78000-1ff79fff : ACPI Non-volatile Storage
1ff80000-1fffffff : reserved
20000000-200003ff : 0000:00:1f.1
20400000-207fffff : PCI CardBus #03
20800000-20bfffff : PCI CardBus #03
20c00000-20ffffff : PCI CardBus #07
21000000-213fffff : PCI CardBus #07
b0000000-b0000fff : 0000:02:00.0
  b0000000-b0000fff : yenta_socket
b1000000-b1000fff : 0000:02:00.1
  b1000000-b1000fff : yenta_socket
c0000000-c00003ff : 0000:00:1d.7
  c0000000-c00003ff : ehci_hcd
c0000800-c00008ff : 0000:00:1f.5
  c0000800-c00008ff : Intel 82801DB-ICH4 - Controller
c0000c00-c0000dff : 0000:00:1f.5
  c0000c00-c0000dff : Intel 82801DB-ICH4 - AC'97
c0100000-c01fffff : PCI Bus #01
  c0100000-c010ffff : 0000:01:00.0
c0200000-c020ffff : 0000:02:01.0
  c0200000-c020ffff : e1000
c0210000-c021ffff : 0000:02:02.0
  c0210000-c021ffff : ath
c0220000-c023ffff : 0000:02:01.0
  c0220000-c023ffff : e1000
d0000000-dfffffff : 0000:00:00.0
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
    e0000000-e0ffffff : vesafb
ff800000-ffffffff : reserved

PCI information:
#lspci -vvv
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller
(rev 03)
	Subsystem: IBM: Unknown device 0529
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [4104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev
03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0100000-c01fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
(prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
(prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
(prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 1840 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01) (prog-if 20
[EHCI])
	Subsystem: IBM: Unknown device 052e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=168
	I/O behind bridge: 00004000-00008fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev
01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller
(rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 01)
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio
Controller (rev 01)
	Subsystem: IBM: Unknown device 0554
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at c0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 01)
(prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 0525
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device
4e54 (rev 80) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 054f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 CardBus bridge: Texas Instruments: Unknown device ac46 (rev 01)
	Subsystem: IBM: Unknown device 0552
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 03e1

02:00.1 CardBus bridge: Texas Instruments: Unknown device ac46 (rev 01)
	Subsystem: IBM: Unknown device 0552
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 10
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at b1000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 20c00000-20fff000 (prefetchable)
	Memory window 1: 21000000-213ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 03e1

02:01.0 Ethernet controller: Intel Corp.: Unknown device 101e (rev 03)
	Subsystem: IBM: Unknown device 0549
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0220000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at 8000 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
		Address: 0000000000000000  Data: 0000

02:02.0 Ethernet controller: Unknown device 168c:1014 (rev 01)
	Subsystem: Unknown device 17ab:8331
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168 (2500ns min, 7000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0210000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

SCSI info:
Unused

Regards,
Niel





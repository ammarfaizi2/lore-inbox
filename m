Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267737AbTBRJEE>; Tue, 18 Feb 2003 04:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbTBRJEE>; Tue, 18 Feb 2003 04:04:04 -0500
Received: from smtp4.arnet.com.ar ([200.45.191.22]:16337 "HELO
	smtp4.arnet.com.ar") by vger.kernel.org with SMTP
	id <S267737AbTBRJDw> convert rfc822-to-8bit; Tue, 18 Feb 2003 04:03:52 -0500
Date: Tue, 18 Feb 2003 06:09:19 -0300
From: Horacio de Oro <hgdeoro@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: rmmod hangs when I do 'rmmod usbcore'
Message-Id: <20030218060919.724241c9.hgdeoro@yahoo.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===========================
[1.] Summary of the problem
===========================
rmmod hangs when I do 'rmmod usbcore'

======================================
[2.] Description of the problem/report
======================================
I want to try 2.5.62, so I compiled it w/modules support. Booted OK.
Doing 'modprobe hid' I get the modules 'usbcore' and'hid' loaded
(but the usb keyboar doesn't work).
Doing 'rmmod hid' everything is OK, but doing
'rmmod usbcore', the process 'rmmod' hangs, and
doing 'ps aux' show this:

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.9  0.1  1228  468 ?        S    05:22   0:05 init [
root         2  0.0  0.0     0    0 ?        SWN  05:22   0:00 [ksoftirqd/0]
root         3  0.1  0.0     0    0 ?        SW<  05:22   0:00 [events/0]
root         4  0.0  0.0     0    0 ?        SW   05:22   0:00 [pdflush]
root         5  0.0  0.0     0    0 ?        SW   05:22   0:00 [pdflush]
root         6  0.0  0.0     0    0 ?        SW   05:22   0:00 [kswapd0]
root         7  0.0  0.0     0    0 ?        SW<  05:22   0:00 [aio/0]
root         9  0.0  0.0     0    0 ?        SW<  05:22   0:00 [reiserfs/0]
root        91  0.0  0.0     0    0 ?        SW   05:22   0:00 [eth0]
...
root       217  0.0  0.0     0    0 ?        SW   05:22   0:00 [khubd]
...
root       531  0.0  0.1  1196  360 pts/2    D    05:31   0:00 rmmod usbcore

Doing SysRq+T show this:

Feb 18 05:33:16 corralito kernel: rmmod         D 00000082 4254125288   531    340                     (NOTLB)
Feb 18 05:33:16 corralito kernel: Call Trace:
Feb 18 05:33:16 corralito kernel:  [__crc_pci_dev_driver+4653385/5847388] khubd_exited+0x0/0x14 [usbcore]
Feb 18 05:33:16 corralito kernel:  [wait_for_completion+143/224] wait_for_completion+0x8f/0xe0
Feb 18 05:33:16 corralito kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Feb 18 05:33:16 corralito kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Feb 18 05:33:16 corralito kernel:  [__crc_pci_dev_driver+4653389/5847388] khubd_exited+0x4/0x14 [usbcore]
Feb 18 05:33:16 corralito kernel:  [__crc_pci_dev_driver+4653389/5847388] khubd_exited+0x4/0x14 [usbcore]
Feb 18 05:33:16 corralito kernel:  [kill_proc_info+66/112] kill_proc_info+0x42/0x70
Feb 18 05:33:16 corralito kernel:  [__crc_pci_dev_driver+4654941/5847388] +0x0/0x140 [usbcore]
Feb 18 05:33:16 corralito kernel:  [__crc_pci_dev_driver+4564407/5847388] usb_hub_cleanup+0x2a/0x40 [usbcore]
Feb 18 05:33:16 corralito kernel:  [__crc_pci_dev_driver+4605833/5847388] +0x2c/0x40 [usbcore]
Feb 18 05:33:16 corralito kernel:  [__crc_pci_dev_driver+4652989/5847388] +0x0/0x80 [usbcore]
Feb 18 05:33:16 corralito kernel:  [sys_delete_module+396/448] sys_delete_module+0x18c/0x1c0
Feb 18 05:33:16 corralito kernel:  [__crc_pci_dev_driver+4654941/5847388] +0x0/0x140 [usbcore]
Feb 18 05:33:16 corralito kernel:  [sys_munmap+68/112] sys_munmap+0x44/0x70
Feb 18 05:33:16 corralito kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

After this, doing 'lsmod' hangs too:

Feb 18 05:33:16 corralito kernel: lsmod         D 00000082 4293452264   550    348                     (NOTLB)
Feb 18 05:33:16 corralito kernel: Call Trace:
Feb 18 05:33:16 corralito kernel:  [__down+150/256] __down+0x96/0x100
Feb 18 05:33:16 corralito kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Feb 18 05:33:16 corralito kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
Feb 18 05:33:16 corralito kernel:  [.text.lock.module+95/162] .text.lock.module+0x5f/0xa2
Feb 18 05:33:16 corralito kernel:  [seq_read+213/752] seq_read+0xd5/0x2f0
Feb 18 05:33:16 corralito kernel:  [vfs_read+188/304] vfs_read+0xbc/0x130
Feb 18 05:33:16 corralito kernel:  [sys_read+62/96] sys_read+0x3e/0x60
Feb 18 05:33:16 corralito kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

In the .config I have:

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set


I'm using the keyboard with NO problem on 
2.5.59-mm2, but usb support compiled into kernel, NO modules support at all.




=================================================
[3.] Keywords (i.e., modules, networking, kernel)
=================================================
usbcore

========================================
[4.] Kernel version (from /proc/version)
========================================
Linux version 2.5.62 (horacio@corralito) (gcc version 3.2.2)
                  #1 Tue Feb 18 00:12:41 ART 2003

[7.] Environment

================================================
[7.1.] Software (output of the ver_linux script)
================================================
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
module-init-tools      0.9.9
e2fsprogs              1.32
pcmcia-cs              3.2.2
PPP                    2.4.1
Linux C Library        3.1.so[0m
Dynamic linker (ldd)   2.3.1
Linux C++ Library      ..
Procps                 3.1.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.7
Modules Loaded         ppp_deflate zlib_deflate zlib_inflate
                       bsd_comp hid usbcore ppp_async
                       ipt_MASQUERADE ipt_state iptable_nat
                       ip_conntrack iptable_filter ip_tables

=================================================
[7.2.] Processor information (from /proc/cpuinfo)
=================================================
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 7
model name	: mobile AMD Duron(tm) Processor
stepping	: 0
cpu MHz		: 946.502
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 1863.68

==============================================
[7.3.] Module information (from /proc/modules)
==============================================
ppp_deflate 5440 0 [unsafe], Live 0xd0ad3000
zlib_deflate 21752 1 ppp_deflate, Live 0xd0b17000
zlib_inflate 22272 1 ppp_deflate, Live 0xd0b10000
bsd_comp 6016 0 [unsafe], Live 0xd0a98000
hid 23168 0 - Live 0xd0adc000
usbcore 108212 1 hid, Live 0xd0af4000
ppp_async 10752 1 [unsafe], Live 0xd0acf000
ipt_MASQUERADE 3008 1 [unsafe], Live 0xd0ac6000
ipt_state 1856 2 [unsafe], Live 0xd0ac8000
iptable_nat 24084 2 ipt_MASQUERADE,[unsafe], Live 0xd0aa9000
ip_conntrack 31820 5 ipt_MASQUERADE,ipt_state,iptable_nat,[unsafe], Live 0xd0ab0000
iptable_filter 2112 1 [unsafe], Live 0xd0a9b000
ip_tables 16192 10 ipt_MASQUERADE,ipt_state,iptable_nat,iptable_filter,[unsafe], Live 0xd0a9f000

============================================
[7.4.1.] Hardware information: /proc/ioports
============================================
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
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : VIA Technologies, In VT82C686 AC97 Audio 
1400-14ff : Realtek Semiconducto RTL-8139/8139C/8139C
  1400-14ff : 8139too
1800-181f : VIA Technologies, In USB
1840-184f : VIA Technologies, In VT82C586/B/686A/B PI
  1840-1847 : ide0
  1848-184f : ide1
1850-1853 : VIA Technologies, In VT82C686 AC97 Audio 
1854-1857 : VIA Technologies, In VT82C686 AC97 Audio 
1858-185f : Conexant HSF 56k HSFi Modem
8100-810f : VIA Technologies, In VT82C686 [Apollo Sup

=========================================
[7.4.2.] Hardware information /proc/iomem
=========================================
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0eeeffff : System RAM
  00100000-00283c3d : Kernel code
  00283c3e-003049c3 : Kernel data
0eef0000-0eefefff : ACPI Tables
0eeff000-0eefffff : ACPI Non-volatile Storage
0ef00000-0effffff : System RAM
e8000000-e800ffff : Conexant HSF 56k HSFi Modem
e8010000-e80100ff : Realtek Semiconducto RTL-8139/8139C/8139C
  e8010000-e80100ff : 8139too
e8100000-e81fffff : PCI Bus #01
  e8100000-e817ffff : S3 Inc. VT8636A [ProSavage K
ec000000-efffffff : VIA Technologies, In VT8363/8365 [KT133/K
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : S3 Inc. VT8636A [ProSavage K
    f0000000-f0eeffff : vesafb
ffbfe000-ffbfefff : Texas Instruments PCI1410 PC card Card
fff80000-ffffffff : reserved

=====================================
[7.5.] PCI information ('lspci -vvv')
=====================================
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 80)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e8100000-e81fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 42)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1840 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 10
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
	Subsystem: Compaq Computer Corporation: Unknown device 0097
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: I/O ports at 1854 [size=4]
	Region 2: I/O ports at 1850 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 8d88
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 4
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at 1858 [size=8]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b103
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ffbfe000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: ffbfd000-ffbfd000 (prefetchable)
	Memory window 1: fbbfd000-ffbfc000
	I/O window 0: 00001c00-00001cff
	I/O window 1: 00002000-000020ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at e8010000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: S3 Inc. VT8636A [ProSavage KN133] AGP4X VGA Controller (TwisterK) (rev 01) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 0086
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x4

========================
[7.6.] Other information
========================
Distribution: Debian GNU/Linux unstable

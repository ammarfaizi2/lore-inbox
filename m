Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVBPRN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVBPRN1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 12:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVBPRNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 12:13:12 -0500
Received: from omr.tzo.com ([64.27.166.104]:7434 "HELO omr.tzo.com")
	by vger.kernel.org with SMTP id S262085AbVBPRK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 12:10:59 -0500
X-TZO-Forward: linux-kernel@vger.kernel.org
Date: Wed, 16 Feb 2005 12:10:56 -0500 (EST)
From: Jerry Abramson <jerry@jabramson.com>
To: linux-kernel@vger.kernel.org
Subject: System hang writing large file to ext3 filesystem - 2.4.29
Message-ID: <Pine.LNX.4.44.0502161207180.5233-100000@promise.jabramson.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please reply to me personally since I am not subscribed to the list.

[1.]
System freezing writing large (12GB or 5GB) file to ext3 filesystem on
internal PATA IDE IBM Deskstar 250MB hard drive reading from promise
SATA TX4 on-board fake-RAID controller (using ft3xx partial-source 
driver).

[2.] I originally though this was a bug with USB since it was freezing writing
to an external (Maxtor OneTouch II 300GB) hard drive.

However, I have reproduced the problem after moving a different hard-drive
inside the case.

This is on an intel S875WP1LX motherboard
with four hard-drives connected to the promise
RAID array as a RAID 0+1 using the promise supplied ft3xx driver. It must
be noted that I am reading from the RAID array when the system freezes. I
don't think this is a promise issue (see below about freezing on 
a completely different system with standard PATA IDE hard-drives).

I somehow believe my backup scripts are to blame, but the system shouldn't
hang.

I am running a set of backup scripts that used to be on a completely different
system (Intel PII/333MHz). On this system, writing to an internal ext2
filesystem I was hanging with any kernel newer than 2.4.8. I don't know if 
this is related or not.

I have included the backup scripts at the end of the E-Mail.

I moved a spare IBM hard-drive (Deskstar 250GB PATA) inside the case and 
switched my
backup scripts to write to it instead of the external USB hard-drive.

This worked for a few days without a hitch.

However, the system froze last night during writing a large ext3 file 
(12GB) similar to the way it was freezing
when writing to the external hard-drive and a large file. I know this 
for a fact because I have a (.1) file that is moved out of
the way during the backup and only deleted after the backup completes.

It is the same large file (12GB) that was causing the system lock-up 
with USB. I also had lockup with a 5GB tar file on occasion.

I am now  at a complete loss.

Any ideas on workarounds, Perhaps piping the gzip through dd with a 
delay or small block-size?

I had had the backup scripts running on an old PII/333MHz and couldn't 
upgrade that kernel beyond
2.4.8 because of lock-ups that I attributed to the motherboard. It looks 
like it wasn't the MB or system after all
but somehow my backup scripts are driving the error.

I am real unhappy in this situation and don't know where to turn. I am a 
long-time Linux user and cannot understand
why simple scripts to write large tar files would cause a system lock-up.

Here's the proof of where the freeze occurs:

# ll -t *tar* *cpio*
-rw-r--r--    1 root     root          *11G* Feb *15 00:45* 
promiseVIDEOS.tar
-rw-r--r--    1 root     root         3.9G Feb 15 00:39 promisePICTURES.tar
-rw-r--r--    1 root     root         665M Feb 15 00:20 
promiseSRCBUILD.tar.gz
-rw-r--r--    1 root     root         373M Feb 15 00:17 promiseLOCAL.tar.gz
-rw-r--r--    1 root     root          78M Feb 15 00:15 promiseHOME.tar.gz
-rw-r--r--    1 root     root          68M Feb 15 00:15 promiseVAR.tar.gz
-rw-r--r--    1 root     root         1.7G Feb 15 00:12 promiseUSR.tar.gz
-rw-r--r--    1 root     root         168K Feb 15 00:04 
promiseROOT.toc_cpio.gz
-rw-r--r--    1 root     root          69M Feb 15 00:04 promiseROOT.cpio.gz
-rwx------    1 root     root         1.7K Feb 15 00:00 backup_cpio*
-rwx------    1 root     root         3.7K Feb 15 00:00 backup_tar*
-rw-r--r--    1 root     root         1.6G Feb 14 00:48 promiseAUDIO.tar
-rw-r--r--    1 root     root          *12G* Feb 14 00:43 
*promiseVIDEOS.tar.1*


[3.] ext3 filesystem large file

[4.] Linux version 2.4.29 (root@promise.jabramson.com) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP Wed Jan 19 16:51:32 EST 2005

[5.] No oops. Just a complete system freeze. No keyboard keys work. Nothing
on screen. CAPS LOCK,etc. fail to change keyboard LEDs. Nothing in 
/var/log/dmesg or /var/log/messages after rebooting in single user mode.

[6.]
I have attached the backup scripts since they are a little bit long at the 
end of the E-Mail.

[7.] Environment
Summary
- Linux system on a PIV 2.8GHz system with Hyper-threading (SMP)
- Intel S875WP1-LX Motherboard. No cards on Motherboard.
- 1GB RAM
- 1 Internal PATA IDE hard-drive. 
- 4 internal SATA hard-drives connected to Promise on-board
  PDC20319 RAID controller.
- on-board VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).


[7.1] ver_linux

Linux promise.jabramson.com 2.4.29 #1 SMP Wed Jan 19 16:51:32 EST 2005 i686 i686 i386 GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         parport_pc lp parport e100 usb-storage keybdev mousedev hid usb-uhci ehci-hcd usbcore ft3xx

[7.2] cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping	: 9
cpu MHz		: 2793.064
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 5570.56

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping	: 9
cpu MHz		: 2793.064
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 5583.66

[7.3] cat /proc/modules
parport_pc             16708   1 (autoclean)
lp                      7424   0 (autoclean)
parport                24512   1 (autoclean) [parport_pc lp]
e100                   58480   1
usb-storage            27736   0
keybdev                 2784   0 (unused)
mousedev                5400   1
hid                    24452   1
usb-uhci               26796   0 (unused)
ehci-hcd               21032   0 (unused)
usbcore                80832   1 [usb-storage hid usb-uhci ehci-hcd]
ft3xx                 241376  14

[7.4] cat /proc/ioports, proc/iomem

cat /proc/ioports

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
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #02
  9c00-9c1f : PCI device 8086:1019 (Intel Corp.)
ac00-ac3f : PCI device 8086:1050 (Intel Corp.)
  ac00-ac3f : e100
b000-b07f : PCI device 105a:3319 (Promise Technology, Inc.)
  b000-b07f : ft3xx2
b400-b40f : PCI device 105a:3319 (Promise Technology, Inc.)
  b400-b40f : ft3xx1
b800-b8ff : ATI Technologies Inc Rage XL
bc00-bc3f : PCI device 105a:3319 (Promise Technology, Inc.)
  bc00-bc3f : ft3xx0
c800-c81f : Intel Corp. 82801EB SMBus Controller
cc00-cc1f : Intel Corp. 82801EB USB
  cc00-cc1f : usb-uhci
d000-d01f : Intel Corp. 82801EB USB
  d000-d01f : usb-uhci
d400-d41f : Intel Corp. 82801EB USB
  d400-d41f : usb-uhci
d800-d81f : Intel Corp. 82801EB USB
  d800-d81f : usb-uhci
dc00-dc0f : Intel Corp. 82801EB Ultra ATA Storage Controller
e000-e003 : Intel Corp. 82801EB Ultra ATA Storage Controller
e400-e407 : Intel Corp. 82801EB Ultra ATA Storage Controller
e800-e803 : Intel Corp. 82801EB Ultra ATA Storage Controller
ec00-ec07 : Intel Corp. 82801EB Ultra ATA Storage Controller
ffa0-ffaf : Intel Corp. 82801EB Ultra ATA Storage Controller
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

cat /proc/iomem

000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3fe2ffff : System RAM
  00100000-002a6d57 : Kernel code
  002a6d58-00340b63 : Kernel data
3fe30000-3fe4149f : ACPI Non-volatile Storage
3fe414a0-3ff2ffff : System RAM
3ff30000-3ff3ffff : ACPI Tables
3ff40000-3ffeffff : ACPI Non-volatile Storage
3fff0000-3fffffff : reserved
40000000-400003ff : Intel Corp. 82801EB Ultra ATA Storage Controller
f8000000-fbffffff : Intel Corp. 82875P Memory Controller Hub
fc900000-fc9fffff : PCI Bus #02
  fc9e0000-fc9fffff : PCI device 8086:1019 (Intel Corp.)
fd000000-fdffffff : ATI Technologies Inc Rage XL
feaa0000-feabffff : PCI device 105a:3319 (Promise Technology, Inc.)
feafd000-feafdfff : PCI device 8086:1050 (Intel Corp.)
  feafd000-feafdfff : e100
feafe000-feafefff : PCI device 105a:3319 (Promise Technology, Inc.)
feaff000-feafffff : ATI Technologies Inc Rage XL
febffc00-febfffff : Intel Corp. 82801EB USB2
  febffc00-febfffff : ehci_hcd
fecf0000-fecf0fff : reserved
fed20000-fed9ffff : reserved

[7.5] PCI information ('lspci -vvv' as root)



00:00.0 Host bridge: Intel Corp.: Unknown device 2578 (rev 02)
	Subsystem: Intel Corp.: Unknown device 2578
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp.: Unknown device 2579 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:03.0 PCI bridge: Intel Corp.: Unknown device 257b (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: fc900000-fc9fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801EB USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at cc00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at d000 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB USB (Hub #3) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at d400 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB USB EHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at d800 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB USB EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801EB ICH5 IDE (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at ec00 [size=8]
	Region 1: I/O ports at e800 [size=4]
	Region 2: I/O ports at e400 [size=8]
	Region 3: I/O ports at e000 [size=4]
	Region 4: I/O ports at dc00 [size=16]

00:1f.3 SMBus: Intel Corp. 82801EB SMBus (rev 02)
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at c800 [size=32]

02:01.0 Ethernet controller: Intel Corp.: Unknown device 1019
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63750ns min), cache line size 10
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fc9e0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 9c00 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at b800 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:07.0 RAID bus controller: Promise Technology, Inc.: Unknown device 3319 (rev 02)
	Subsystem: Intel Corp.: Unknown device 3428
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 (1000ns min, 4500ns max), cache line size 90
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at bc00 [size=64]
	Region 1: I/O ports at b400 [size=16]
	Region 2: I/O ports at b000 [size=128]
	Region 3: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at feaa0000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:08.0 Ethernet controller: Intel Corp. 82801EB (ICH5) PRO/100 VE Ethernet Controller (rev 01)

[7.6] cat /proc/scsi/scsi

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Promise  Model: 2X2 Mirror/RAID1 Rev: 1.10
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Maxtor   Model: OneTouch II      Rev: 023d
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7] Misc.

# cat /proc/filesystems 
nodev	rootfs
nodev	bdev
nodev	proc
nodev	sockfs
nodev	tmpfs
nodev	shm
nodev	pipefs
nodev	binfmt_misc
	ext3
	ext2
nodev	ramfs
	msdos
	vfat
	iso9660
nodev	nfs
nodev	smbfs
nodev	autofs
nodev	devpts
nodev	usbdevfs
nodev	usbfs

# df -h (when backups are running)
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda1            1012M  206M  755M  22% /
none                  504M     0  504M   0% /dev/shm
/dev/sda6             1.9G   33M  1.8G   2% /tmp
/dev/sda5             9.9G  5.2G  4.3G  55% /usr
/dev/sda2             2.0G  301M  1.6G  16% /var
/dev/sda7             4.6G  227M  4.2G   6% /home
/dev/sda12            4.6G  903M  3.5G  21% /local
/dev/sda11            4.6G  2.1G  2.4G  47% /srcbuild
/dev/sda10            4.6G  607M  3.8G  14% /MyDocuments
/dev/sda13            9.2G  2.6G  6.2G  30% /exe
/dev/sda14            4.6G  1.2G  3.3G  27% /src
/dev/sda8              28G  4.0G   23G  16% /Pictures
/dev/sda9              28G   12G   15G  45% /Videos [<=== filesystem reading]
/dev/sda15             28G  1.7G   25G   7% /Audio
/dev/hda9             163G   26G  130G  17% /Archive  [<== filesystem written]
/dev/hda6              30G  3.6G   27G  12% /Archive/MyDocuments
/dev/hda7              14G  2.5G   12G  18% /Archive/exe
/dev/hda8             9.4G  1.1G  8.3G  12% /Archive/src


cat /proc/scsi/ft3xx/0
PROMISE FastTrak TX4000/376/378/S150 TX Series Linux Driver Version 1.00.0.19 
Adapter1  - FastTrak S150 TX4
Array     - Array[1] : 2X2 Mirror/Stripe (OK-Gigabyte Boundary)
Drive     - 
  1 : HDS722516VLSA80       IDE1/Master 164696MB IRQ(17) UDMA5 Array[1]
  3 : HDS722516VLSA80       IDE2/Master 164696MB IRQ(17) UDMA5 Array[1]
  5 : HDS722516VLSA80       IDE3/Master 164696MB IRQ(17) UDMA5 Array[1]
  7 : HDS722516VLSA80       IDE4/Master 164696MB IRQ(17) UDMA5 Array[1]

# cat /proc/ide/hda/model
HDS722525VLAT80

# cat /proc/ide/hda/driver
ide-disk version 1.17

# cat /proc/hde/hda/settings
# cat settings
name			value		min		max		mode
----			-----		---		---		----
acoustic                0               0               254             rw
address                 1               0               2               rw
bios_cyl                30401           0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        8               0               255             rw
bswap                   0               0               1               r
current_speed           69              0               70              rw
failures                0               0               65535           rw
file_readahead          124             0               16384           rw
init_speed              69              0               70              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      128             1               255             rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw
wcache                  0               0               1               rw

# cat /proc/ide/drivers
ide-cdrom version 4.59-ac1
ide-disk version 1.17
ide-default version 0.9.newide

# cat /proc/ide/piix
#cat piix

Controller: 0

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              yes               no 
UDMA enabled:   yes              no              yes               no 
UDMA enabled:   5                X               2                 X
UDMA
DMA
PIO
# 


# relevent .config infor
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUM4=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_ACPI_BOOT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_PROMISE=m
CONFIG_SCSI_SYM53C8XX=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_E100=m
CONFIG_E1000=m
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_ATI=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_AUTOFS4_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_UNIX=y
CONFIG_ZISOFS_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_UTF8=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI=m
CONFIG_USB_OHCI=m
CONFIG_USB_SL811HS_ALT=m
CONFIG_USB_STORAGE=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y

-------------------------------------------------------------------------------
backup_systems (Master backup script, run by cron as: backup_systems /Archive)
-------------------------------------------------------------------------------

#/bin/bash
###############################################################################
#
#
echo "                           Performing Nightly System Backups"
echo "                           ========== ======= ====== ======="
echo "================================================================================"

###############################################################################

#
# Store correct time in hardware clock
#
echo "Saving time in hardware clock"
date
/sbin/hwclock --systohc
echo "--------------------------------------------------------------------------------"


#
# Archive filesystem (defaults to internal hard-drive
#
ARCHIVEROOT=$1
if [ "$ARCHIVEROOT" = "" ]; then
	ARCHIVEROOT=/Archive
fi

###############################################################################
echo "Mounting Filesytems"
/usr/local/sbin/mountall $ARCHIVEROOT $ARCHIVEROOT/MyDocuments $ARCHIVEROOT/exe $ARCHIVEROOT/src
if [ ! -d $ARCHIVEROOT/lost+found ]; then
	echo "$ARCHIVEROOT cannot be mounted successfully!! Aborting!!"
	exit 1
fi


/usr/local/sbin/mountall /mnt/novell /mnt/novell/usr /mnt/novell/var /mnt/novell/home /mnt/intel /mnt/intel/var /mnt/intel/usr /mnt/intel/home /mnt/intel/Pictures

echo "-------------------------- ALL MOUNTED FILESYSTEMS -------------------------"
df -h
echo "----------------------------------------------------------------------------"

echo
###############################################################################


###############################################################################
#
# Let's save off fdisk and df for each system in both archives
#
###############################################################################
echo "--------------------------------------------------------------------------------"
date
echo -n "Archiving disk information ... "

###############################################################################
/bin/df -h >$ARCHIVEROOT/promise/promiseDF.txt 2>&1
/sbin/fdisk -l /dev/hda /dev/sda /dev/sdb >$ARCHIVEROOT/promise/promiseFDISK.txt 2>&1
cp /usr/local/sbin/backup* $ARCHIVEROOT/promise


###############################################################################
/usr/bin/rsh novell /bin/df -h >$ARCHIVEROOT/novell/novellDF.txt 2>&1
/usr/bin/rsh novell /sbin/fdisk -l /dev/hda >$ARCHIVEROOT/novell/novellFDISK.txt 2>&1

###############################################################################
/usr/bin/rsh intel /bin/df -h >$ARCHIVEROOT/intel/intelDF.txt 2>&1
/usr/bin/rsh intel /sbin/fdisk -l /dev/hd[abcef] >$ARCHIVEROOT/intel/intelFDISK.txt 2>&1

date

###############################################################################
#
# Now we make a separate backup of MyDocuments (with N days of backup history)
#
###############################################################################
/usr/local/sbin/backup_docs $ARCHIVEROOT

###############################################################################
#
# Backup daily Mail and IMAP folders
#
###############################################################################
/usr/local/sbin/backup_mail $ARCHIVEROOT

###############################################################################
# Now we backup some intel filesystems
###############################################################################

/usr/local/sbin/backup_cpio promise / $ARCHIVEROOT
#/usr/local/sbin/backup_tar promise /tmp $ARCHIVEROOT
/usr/local/sbin/backup_tar promise /usr $ARCHIVEROOT
/usr/local/sbin/backup_tar promise /var $ARCHIVEROOT
/usr/local/sbin/backup_tar promise /home $ARCHIVEROOT
/usr/local/sbin/backup_tar promise /local $ARCHIVEROOT
/usr/local/sbin/backup_tar promise /srcbuild $ARCHIVEROOT

#
# exe
#
echo "================================================================================"
echo -n "Backing up /exe ... "
cd /exe
chown -R jerry .
chgrp -R abramson .
chmod -R o-rwx .
cp -a * $ARCHIVEROOT/exe
echo "Done."
date
#echo -n "Sleeping for 1 minute to give disk a rest ..."
#sleep 60
#echo "done."



#
# src
#
echo "================================================================================"
echo -n "Backing up /src ..."
cd /src
chown -R jerry .
chgrp -R abramson .
chmod -R o-rwx .
cp -a * $ARCHIVEROOT/src
echo "Done."
date
#echo -n "Sleeping for 1 minute to give disk a rest ..."
#sleep 60
#echo "done."

cd /

# Copy Pictures to website
#
if [ -d /mnt/intel/Pictures/lost+found ]; then
    echo "================================================================================"
    echo -n "Copying /Pictures to intel ..."
    cd /Pictures
    cp -a * /mnt/intel/Pictures
    cd /
    echo "done."
fi

#
# Only backup high-volume filesystems to internal hard-drive
#
if [ "$ARCHIVEROOT" = "/Archive" ]; then
    # No compression
    /usr/local/sbin/backup_tar promise /Pictures $ARCHIVEROOT 0
    /usr/local/sbin/backup_tar promise /Videos $ARCHIVEROOT 0
    /usr/local/sbin/backup_tar promise /Audio $ARCHIVEROOT 0
fi

###############################################################################
# backup remote systems
###############################################################################

#
# Next the remote access server (intel)
#
/usr/local/sbin/backup_cpio intel /mnt/intel $ARCHIVEROOT
/usr/local/sbin/backup_tar intel /mnt/intel/var $ARCHIVEROOT
/usr/local/sbin/backup_tar intel /mnt/intel/usr $ARCHIVEROOT
/usr/local/sbin/backup_tar intel /mnt/intel/home $ARCHIVEROOT

#
# Next the E-mails server
#
/usr/local/sbin/backup_cpio novell /mnt/novell $ARCHIVEROOT
/usr/local/sbin/backup_tar novell /mnt/novell/home $ARCHIVEROOT
/usr/local/sbin/backup_tar novell /mnt/novell/usr $ARCHIVEROOT
/usr/local/sbin/backup_tar novell /mnt/novell/var $ARCHIVEROOT


###############################################################################
echo "================================================================================"
date
cd $ARCHIVEROOT
for i in exe src MyDocuments
do
    echo -n "Tallying total disk space for  $ARCHIVEROOT/$i ..."
    cd $ARCHIVEROOT/$i;/usr/local/bin/dusm >du.txt
    echo "done."
done

date
echo -n "Tallying total disk space for all filesystems ..."
cd /
/usr/local/bin/dusm >du.txt
echo "done."

#
# We're done with VFAT filesystems on $ARCHIVEROOT, so let unmount and tally
# just $ARCHIVEROOT
#
cd /
/usr/local/sbin/umountall $ARCHIVEROOT/MyDocuments $ARCHIVEROOT/exe $ARCHIVEROOT/src

cd $ARCHIVEROOT
echo -n "Tallying totoal disk space for $ARCHIVEROOT ... "
/usr/local/bin/dusm >du.txt
echo "done."


    echo "================================================================================"
cd /
# 

###############################################################################
echo "--------------------------------------------------------------------------------"
date
echo "Initializing swap for IDE drive (/dev/hda2)"
/sbin/mkswap /dev/hda2
RET=$?
if [ "$RET" != 0 ]; then
       echo "mkswap failed: $RET"
fi

echo "--------------------------------------------------------------------------------"
date
echo "recreating filesystem for /mnt/root (/dev/hda1)"
/sbin/mkfs.ext3 -L ALTROOT /dev/hda1
RET=$?
date
if [ "$RET" != 0 ]; then
       echo "mkfs.ext3 /dev/hda1 FAILED :$RET: !!"
else
       /usr/local/sbin/mountall /mnt/root
       RET=$?
       if [ "$RET" != 0 ]; then
               echo "mountall /mnt/root FAILED :$RET: !!"
       else
	       echo -n "mirrorring / on /dev/hda1 ... "
	       mkdir /mnt/root/Archive /mnt/root/Archive2
	       cd /mnt/root
	       /bin/zcat $ARCHIVEROOT/promise/promiseROOT.cpio | /bin/cpio -icdmu
	       cd /
	       cp /etc/fstab.HDA1 /mnt/root/etc/fstab
	       cp /etc/lilo.conf.HDA1 /mnt/root/etc/lilo.conf
	       cp /etc/inittab.HDA1 /mnt/root/etc/inittab
	       cp $ARCHIVEROOT/*/*DF* $ARCHIVEROOT/*/*FDISK* /mnt/root/Archive
	       cp $ARCHIVEROOT/*/*DF* $ARCHIVEROOT/*/*FDISK* /mnt/root/Archive2
	       /sbin/lilo -r /mnt/root
               sync
	       echo "done."
   	       date
	fi
fi

echo "--------------------------------------------------------------------------------"

date
echo "recreating filesystem for  /mnt/root/var (/dev/hda3)"
/sbin/mkfs.ext3 -L ALTVAR /dev/hda3
RET=$?
if [ "$RET" != 0 ]; then
       echo "mkfs.ext3 /dev/hda3 FAILED :$RET: !!"
else
       /usr/local/sbin/mountall /mnt/root/var
       RET=$?
       if [ "$RET" != 0 ]; then
               echo "mountall /mnt/root/var FAILED :$RET: !!"
       else
	   echo -n "mirrorring /var on /dev/hda3 ... "
	   cd /var
           cp -a * /mnt/root/var
           sync
	   echo "done."
	   cd /
   	   date
	fi
fi

echo "--------------------------------------------------------------------------------"
date
echo "recreating filesystem for  /mnt/root/usr (/dev/hda5)"
/sbin/mkfs.ext3 -L ALTUSR /dev/hda5
RET=$?
if [ "$RET" != 0 ]; then
       echo "mkfs.ext3 /dev/hda5 FAILED :$RET: !!"
else
       /usr/local/sbin/mountall /mnt/root/usr
       RET=$?
       if [ "$RET" != 0 ]; then
               echo "mountall /mnt/root/usr FAILED :$RET: !!"
       else
	   echo -n "mirrorring /usr on /dev/hda5 ... "
	   cd /usr
           cp -a * /mnt/root/usr	
	   echo "done."
	   echo -n "copying /usr/local/sbin ..."
	   rm -f /mnt/root/usr/local
	   mkdir -p /mnt/root/usr/local/sbin
	   cd /usr/local/sbin
	   cp -a * /mnt/root/usr/local/sbin
           sync
	   echo "done."
	   cd /
   	   date
	fi
fi


echo "-------------------------- Internal Hard Drive -------------------------"
df -h /mnt/root /mnt/root/var /mnt/root/usr
echo "------------------------------------------------------------------------"

echo "--------------------------------------------------------------------------------"
/usr/local/sbin/umountall /mnt/root/usr /mnt/root/var /mnt/root

###############################################################################
echo "--------------------------------------------------------------------------------"
echo -n "Syncing disks ... "
cd /
sync
echo "done."

echo "--------------------------------------------------------------------------------"
echo "Unmounting filesystems"
/usr/local/sbin/umountall  /mnt/novell/var /mnt/novell/usr /mnt/novell/home /mnt/novell /mnt/intel/var /mnt/intel/usr /mnt/intel/home /mnt/intel/Pictures /mnt/intel

/usr/local/sbin/umountall $ARCHIVEROOT

echo "-------------------------- ALL MOUNTED FILESYSTEMS -------------------------"
df -h
echo "----------------------------------------------------------------------------"


echo "================================================================================"
echo "Nightly system backup script complete"
echo "================================================================================"


date


-------------------------------------------------------------------------------
backup_tar
-------------------------------------------------------------------------------

#!/bin/sh
#
PATH=/bin:/usr/bin:/etc:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin/X11


echo "================================================================================"
date

HOST=$1
FILESYSTEM=$2 
ARCHIVEROOT=$3
COMP_LEVEL=$4

if [ "$ARCHIVEROOT" = "" ]; then
	ARCHIVEROOT=/Archive
fi

#
# /Archive is now local to intel
#
REMOTE=
#if [ "$ARCHIVEROOT" = "/Archive" ]; then
#	REMOTE=novell
#else
#	REMOTE=
#fi
	

if [ "$FILESYSTEM" = "" ]; then
    echo "usage: backup_tar HOST FILESYSTEM [ARCHIVEROOT]"
    exit 1
fi

if [ ! -d "$FILESYSTEM" ]; then
    echo "No Such Filesystem: $FILESYSTEM"
    exit 1
fi

if [ ! -d "$FILESYSTEM/lost+found" ]; then
    echo "Filesystem Not mounted: $FILESYSTEM"
    exit 1
fi


if [ ! -d "$ARCHIVEROOT" -a ! -f "$ARCHIVEROOT" ]; then
    echo "No Such Archive Root: $ARCHIVEROOT"
    exit 1
fi

if [ "$COMP_LEVEL" = "" ]; then
    COMP_LEVEL="3"
fi
echo "Compression Level: $COMP_LEVEL"

#
# We now assume filesystem and Archive are mounted already
#
#mount $FILESYSTEM >/dev/null 2>&1
#mount $ARCHIVEROOT >/dev/null 2>&1

#
# Setup Base Variables (fs, uppercase fs, Arch, Zarch)
#
BASE=`basename "$FILESYSTEM"`
UBASE=`echo "$BASE" | awk -- '{printf("%s",toupper($0))}'`
UBASENAME=${HOST}${UBASE}
TARUBASENAME=${UBASENAME}.tar
TOCUBASENAME=${UBASENAME}.toc
DUTXTBASENAME=${UBASENAME}_DU.txt
ZBASENAME=${TARUBASENAME}.gz
ZTOCBASENAME=${TOCUBASENAME}.gz
ARCHIVE=$ARCHIVEROOT/$HOST/${TARUBASENAME}
TOC=$ARCHIVEROOT/$HOST/${TOCUBASENAME}
DUTXT=$ARCHIVEROOT/$HOST/${DUTXTBASENAME}
ZARCHIVE=${ARCHIVE}.gz
ZTOC=${TOC}.gz

#
# Go to head of filesystem
#
cd $FILESYSTEM

#
# Attempt to insure a backup exists even on failure
#
#if [ "false" = "true" ]; then

if [ "$COMP_LEVEL" = "0" ]; then
  BAKFILE=$ARCHIVE
else
  BAKFILE=$ZARCHIVE
fi

if [ -f "$BAKFILE" ]; then
    if [ -L $BAKFILE.1 ]; then
	rm $BAKFILE.1
    fi
    if [ -f $BAKFILE.1 ]; then
	echo "Prior backup $BAKFILE.1 already exists, no backup made!"
    else
       echo -n "Insuring prior Backup ($BAKFILE.1)... "
       mv $BAKFILE $BAKFILE.1
       echo "Done."
    fi
fi

rm -f $ZARCHIVE $ARCHIVE >/dev/null 2>&1
if [ "$COMP_LEVEL" = "0" ]; then
   echo -n "TAR'ring PROMISE: $ARCHIVE ... "
else
   echo -n "TAR'ring/GZipping PROMISE: $ZARCHIVE ... "
fi

if [ "$HOST" = "microsoft" ]; then
	echo "recycler" >/tmp/exclude_tar$$
	flags="cXlf /tmp/exclude_tar$$"
elif [ "$HOST" = "intel" -a "$FILESYSTEM" = "/usr" ]; then
        echo "SCRATCH" >/tmp/exclude_tar$$
	flags="cXlf /tmp/exclude_tar$$"
elif [ "$HOST" = "intel" -a "$FILESYSTEM" = "/home" ]; then
        echo "MyDocuments" >/tmp/exclude_tar$$
	flags="cXlf /tmp/exclude_tar$$"
else
	flags="clf"
fi

if [ "$REMOTE" = "novell" ]; then
	tar $flags - . | gzip -${COMP_LEVEL} | rsh novell dd of=$ZARCHIVE >/tmp/backup$$ 2>&1
else
   if [ "$COMP_LEVEL" = "0" ]; then
	tar $flags $ARCHIVE . 2>/tmp/backup$$
   else 
	tar $flags - . | gzip -${COMP_LEVEL} >$ZARCHIVE 2>/tmp/backup$$
   fi
fi
RC=$?
rm -f /tmp/exclude_tar$$
grep -v 'records [io][nu]' /tmp/backup$$
rm -f /tmp/backup$$ >/dev/null 2>&1

if [ "$RC" = 0 ]; then
   rm -f $BAKFILE.1
   echo "Done."
   echo -n "Creating GZipped Table of Contents & du.txt... "
   /usr/local/bin/dusm >$DUTXT 
   cp $DUTXT du.txt
   if [ "$REMOTE" = "novell" ]; then
	sleep 10
   fi
   if [ "$COMP_LEVEL" = "0" ]; then
	tar tvf $ARCHIVE | gzip -1 >$ZTOC
   else
   	zcat $ZARCHIVE | tar tvf - | gzip -${COMP_LEVEL} >$ZTOC
   fi
   RC=$?
   if [ "$RC" = 0 ]; then
	echo "Done."
   else
	echo "FAILED!"
   fi
else
   echo "Failure!!"
   if [ -f $ZARCHIVE.1 ]; then
       echo "Last good backup in $ZARCHIVE.1"
   else
       echo "No Prior backup available!"
   fi
fi
echo -n "Syncing disks ... "
sync
echo "done."
date

#echo -n "Sleeping for 1 minute to give disk a rest ..."
#sleep 60
#echo "done."

echo



-------------------------------------------------------------------------------
backup_cpio
-------------------------------------------------------------------------------
#!/bin/sh
#
PATH=/bin:/usr/bin:/etc:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin/X11

echo "================================================================================"
date


HOST=$1
FILESYSTEM=$2
ARCHIVEROOT=$3

if [ "$ARCHIVEROOT" = "" ]; then
        ARCHIVEROOT=/Archive
fi

if [ "$FILESYSTEM" = "" ]; then
    echo "usage: backup_cpio FILESYSTEM"
    exit 1
fi

if [ ! -d "$FILESYSTEM" ]; then
    echo "No Such Filesystem: $FILESYSTEM"
    exit 1
fi

if [ ! -d "$FILESYSTEM/lost+found" ]; then
    echo "Filesystem Not mounted: $FILESYSTEM"
    exit 1
fi

#
# Root filesystem of local host?
#
BASE=`basename $FILESYSTEM`
if [ "$BASE" = "" -o "$BASE" = "/" ]; then
    BASE=root
fi

#
# Root filesystem of remote host?
#
if [ "$BASE" = "$HOST" ] ; then
    BASE=root
fi

UBASE=`echo $BASE | awk -- '{printf("%s\n",toupper($0))}'`
ARCHIVE=${ARCHIVEROOT}/${HOST}/${HOST}${UBASE}.cpio
TOC=${ARCHIVEROOT}/${HOST}/${HOST}${UBASE}.toc_cpio
ZARCHIVE=${ARCHIVE}.gz
ZTOC=${TOC}.gz
UBASENAME=${HOST}${UBASE}
DUTXTBASENAME=${UBASENAME}_DU.txt
DUTXT=$ARCHIVEROOT/$HOST/${DUTXTBASENAME}

echo -n "Insuring prior Backup ($ZARCHIVE.1)... "
mv -f $ZARCHIVE $ZARCHIVE.1 2>/dev/null
echo "Done."

cd $FILESYSTEM
echo -n "PROMISE: cpio >$ZARCHIVE ... "
find . -mount -print | cpio -oc | gzip >$ZARCHIVE
RC=$?
# cpio outputs block count indicating operation finished

if [ "$RC" = 0 ]; then
	rm -f $ZARCHIVE.1 2>/dev/null
	zcat $ZARCHIVE | cpio -ictv 2>/dev/null | gzip -9 >$ZTOC
else
	echo
	echo "filesystem '$FILESYSTEM' CPIO FAILED. Prior Backup in $ZARCHIVE.1"
fi

echo
echo -n "Syncing disks ... "
sync
echo "done."
date

#echo -n "Sleeping for 1 minute to give disk a rest ..."
#sleep 60
#echo "done."


exit 0


-------------------------------------------------------------------------------
backup_mail
-------------------------------------------------------------------------------
#!/bin/bash

MAILROOT=/mnt/novell # For Novell

# MAILROOT= # For Intel

#
# Archive filesystem (defaults to internal hard-drive
#
ARCHIVEROOT=$1
if [ "$ARCHIVEROOT" = "" ]; then
	ARCHIVEROOT=/Archive
fi

echo "================================================================================"
date
echo "Backup UP E-Mail Folders and INBOXes"
echo

# Backup INBOX and IMAP folders
###############################
#
# Let's put users INBOX from var into imap directory for backup
#
for i in jerry janet jessica jacob; do
  if [ -d $MAILROOT/home/$i/MAIL ]; then
      cd $MAILROOT/home/$i/MAIL
      if [ -f $MAILROOT/var/spool/mail/$i ]; then
         cp $MAILROOT/var/spool/mail/$i INBOX
      else
         echo "No Inbox in $MAILROOT/var/spool/mail/$i, skipping Inbox."
      fi
      mfile=MAIL$i.tar.gz
      mtoc=MAIL$i.toc.gz
      date
      echo -n "Backing up $i's E-Mail INBOX and IMAP folders ... "
      tar clf - . | gzip -5 >$ARCHIVEROOT/email/$mfile
      zcat $ARCHIVEROOT/email/$mfile | tar tvf - | gzip -5 >$ARCHIVEROOT/email/$mtoc
      rm -f INBOX
      echo "Done."
   else
      echo "No MAIL Folder for $i, skipping entirely."
   fi
done


-------------------------------------------------------------------------------
backup_docs
-------------------------------------------------------------------------------

#!/bin/sh
#
PATH=/usr/local/bin:$PATH
echo "================================================================================"
date

#
# Archive filesystem (defaults to internal hard-drive
#
ARCHIVEROOT=$1
if [ "$ARCHIVEROOT" = "" ]; then
	ARCHIVEROOT=/Archive
fi

TARFILE="$ARCHIVEROOT/MyDocuments/docs.tar.gz"
TARFILETOC="$ARCHIVEROOT/MyDocuments/docs.toc.gz"
TARFILEDU="$ARCHIVEROOT/MyDocuments/docs_du.txt"
echo -n "Backing up MyDocuments ($TARFILE) ... "
    cd /MyDocuments
    if [ $? = 0 ]; then
	dusm >$TARFILEDU
    chown jerry $TARFILEDU
    chgrp abramson $TARFILEDU
    rm -f du.txt
	/bin/tar --preserve -czf $TARFILE.0 *
	RC=$?
	echo "Done."
	if [ $RC = 0 ]; then
	    echo -n "Making daily backups ... "
	    mv -f $TARFILE.50 $TARFILE.51 2>/dev/null
	    mv -f $TARFILE.49 $TARFILE.50 2>/dev/null
	    mv -f $TARFILE.48 $TARFILE.49 2>/dev/null
	    mv -f $TARFILE.47 $TARFILE.48 2>/dev/null
	    mv -f $TARFILE.46 $TARFILE.47 2>/dev/null
	    mv -f $TARFILE.45 $TARFILE.46 2>/dev/null
	    mv -f $TARFILE.44 $TARFILE.45 2>/dev/null
	    mv -f $TARFILE.43 $TARFILE.44 2>/dev/null
	    mv -f $TARFILE.42 $TARFILE.43 2>/dev/null
	    mv -f $TARFILE.41 $TARFILE.42 2>/dev/null
	    mv -f $TARFILE.40 $TARFILE.41 2>/dev/null
	    mv -f $TARFILE.39 $TARFILE.40 2>/dev/null
	    mv -f $TARFILE.38 $TARFILE.39 2>/dev/null
	    mv -f $TARFILE.37 $TARFILE.38 2>/dev/null
	    mv -f $TARFILE.36 $TARFILE.37 2>/dev/null
	    mv -f $TARFILE.35 $TARFILE.36 2>/dev/null
	    mv -f $TARFILE.34 $TARFILE.35 2>/dev/null
	    mv -f $TARFILE.33 $TARFILE.34 2>/dev/null
	    mv -f $TARFILE.32 $TARFILE.33 2>/dev/null
	    mv -f $TARFILE.31 $TARFILE.32 2>/dev/null
	    mv -f $TARFILE.30 $TARFILE.31 2>/dev/null
	    mv -f $TARFILE.29 $TARFILE.30 2>/dev/null
	    mv -f $TARFILE.28 $TARFILE.29 2>/dev/null
	    mv -f $TARFILE.27 $TARFILE.28 2>/dev/null
	    mv -f $TARFILE.26 $TARFILE.27 2>/dev/null
	    mv -f $TARFILE.25 $TARFILE.26 2>/dev/null
	    mv -f $TARFILE.24 $TARFILE.25 2>/dev/null
	    mv -f $TARFILE.23 $TARFILE.24 2>/dev/null
	    mv -f $TARFILE.22 $TARFILE.23 2>/dev/null
	    mv -f $TARFILE.21 $TARFILE.22 2>/dev/null
	    mv -f $TARFILE.20 $TARFILE.21 2>/dev/null
	    mv -f $TARFILE.19 $TARFILE.20 2>/dev/null
	    mv -f $TARFILE.18 $TARFILE.19 2>/dev/null
	    mv -f $TARFILE.17 $TARFILE.18 2>/dev/null
	    mv -f $TARFILE.16 $TARFILE.17 2>/dev/null
	    mv -f $TARFILE.15 $TARFILE.16 2>/dev/null
	    mv -f $TARFILE.14 $TARFILE.15 2>/dev/null
	    mv -f $TARFILE.13 $TARFILE.14 2>/dev/null
	    mv -f $TARFILE.12 $TARFILE.13 2>/dev/null
	    mv -f $TARFILE.11 $TARFILE.12 2>/dev/null
	    mv -f $TARFILE.10 $TARFILE.11 2>/dev/null
	    mv -f $TARFILE.9  $TARFILE.10 2>/dev/null
	    mv -f $TARFILE.8  $TARFILE.9  2>/dev/null
	    mv -f $TARFILE.7  $TARFILE.8  2>/dev/null
	    mv -f $TARFILE.6  $TARFILE.7  2>/dev/null
	    mv -f $TARFILE.5  $TARFILE.6  2>/dev/null
	    mv -f $TARFILE.4  $TARFILE.5  2>/dev/null
	    mv -f $TARFILE.3  $TARFILE.4  2>/dev/null
	    mv -f $TARFILE.2  $TARFILE.3  2>/dev/null
	    mv -f $TARFILE.1  $TARFILE.2  2>/dev/null
	    mv -f $TARFILE    $TARFILE.1  2>/dev/null
	    mv -f $TARFILE.0  $TARFILE
	    echo "Done."
        echo -n "Creating GZipped Table of Contents ... "
        tar tzvf $TARFILE | gzip >$TARFILETOC
        echo "done."
	echo -n "Copying for Windows XP access ..."
        rm -rf $ARCHIVEROOT/MyDocuments/expanded.1
        mv -f $ARCHIVEROOT/MyDocuments/expanded $ARCHIVEROOT/MyDocuments/expanded.1 2>/dev/null
	mkdir $ARCHIVEROOT/MyDocuments/expanded
	cd /MyDocuments
	cp -a * $ARCHIVEROOT/MyDocuments/expanded
	echo "done."
        echo -n "Syncing disks ... "
        sync
        echo "done."
    else
	    echo "An error occurred during tarfile creation !!"
	fi
fi

date

echo



-- 
_________________________________________________________

           _/_/_/_/ _/_/_/   _/_/_/   Jerold A. Abramson
              _/  _/    _/ _/    _/   
        _/   _/  _/_/_/_/ _/_/_/_/    
        _/  _/  _/    _/ _/    _/     
        _/_/   _/    _/ _/    _/      jerry@jabramson.com
                                      
_________________________________________________________




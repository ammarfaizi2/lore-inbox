Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136934AbREJVOx>; Thu, 10 May 2001 17:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136933AbREJVOg>; Thu, 10 May 2001 17:14:36 -0400
Received: from B104f.pppool.de ([213.7.16.79]:32262 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id <S136931AbREJVOY>;
	Thu, 10 May 2001 17:14:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: [2.4.4ac4] Kernel crash while unmounting CD
Date: Thu, 10 May 2001 23:13:23 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01051022310100.00484@athlon>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Kernel panic when trying to unmount a ide-scsi cdrom.

[2.] Full description of the problem/report:

With Kernel 2.4.4 ac4 I got a kernelpanic while trying to unmount an 
ide-scsi-device.

 What I did:
1. Burning the cdrom (647 MB raw data; medium 700 MB) with cdrecord 1.10, 
compiled on this system with this kernel.
2. Burning ended successfully with no errors and no warnings.
3. After burning, the cd was ejected automatically.
4. Closing the tray with the new burned CD and mounting the CD.
5. the mounting takes a lot of time, but finally, the CD has been mounted. A 
ls -l on the root of the CD takes a lot of time again. But finally, the 
output of ls -l appeared.
6. umount of the CD. This took a lot of time until the Kernel crashed:

<0> Kernel panic. Attempt to kill the idle task. In idle task not syncing.
<1> unable to handle NULL pointer dereference at virtual address ... [I 
hoped, the oops had been logged in messages - nope; is there any way to save 
the output of this kernel oops?]


Before the oops, you can read the following in /var/log/messages:
May  9 17:24:47 athlon kernel: SCSI subsystem driver Revision: 1.00
May  9 17:24:47 athlon kernel: scsi0 : SCSI host adapter emulation for IDE 
ATAPI devices
May  9 17:24:47 athlon kernel:   Vendor:           Model: ATAPI CDROM.48X   
Rev: 120Y
May  9 17:24:47 athlon kernel:   Type:   CD-ROM                             
ANSI SCSI revision: 02
May  9 17:24:47 athlon kernel:   Vendor: PHILIPS   Model: CDD3610 CD-R/RW   
Rev: 3.01
May  9 17:24:47 athlon kernel:   Type:   CD-ROM                             
ANSI SCSI revision: 02
[...]
May  9 18:09:33 athlon kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
May  9 18:09:33 athlon kernel: ISO 9660 Extensions: RRIP_1991A
May  9 18:10:07 athlon kernel: scsi : aborting command due to timeout : pid 
0, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 00 00 26 00 00 01 00
May  9 18:10:07 athlon kernel: hdd: timeout waiting for DMA
May  9 18:10:07 athlon kernel: ide_dmaproc: chipset supported ide_dma_timeout 
func only: 14
May  9 18:10:07 athlon kernel: hdd: irq timeout: status=0xd0 { Busy }
May  9 18:10:07 athlon kernel: hdd: DMA disabled
May  9 18:10:09 athlon kernel: hdd: ATAPI reset complete
May  9 18:10:09 athlon kernel: hdd: irq timeout: status=0xd0 { Busy }
May  9 18:10:12 athlon kernel: hdd: ATAPI reset complete
May  9 18:10:12 athlon kernel: hdd: irq timeout: status=0xd0 { Busy }
May  9 18:10:12 athlon kernel: scsi0 channel 0 : resetting for second half of 
retries.
May  9 18:10:12 athlon kernel: SCSI bus is being reset for host 0 channel 0.
May  9 18:10:12 athlon kernel: hdd: status timeout: status=0xd0 { Busy }
May  9 18:10:12 athlon kernel: hdd: drive not ready for command
May  9 18:10:20 athlon kernel: hdd: ATAPI reset complete
May  9 18:10:20 athlon kernel: SCSI cdrom error : host 0 channel 0 id 1 lun 0 
return code = 27000002
May  9 18:10:20 athlon kernel:  I/O error: dev 0b:01, sector 152
May  9 18:10:21 athlon kernel: scsi0 : channel 0 target 1 lun 0 request sense 
failed, performing reset.
May  9 18:10:21 athlon kernel: SCSI bus is being reset for host 0 channel 0.
May  9 18:10:21 athlon kernel: SCSI cdrom error : host 0 channel 0 id 1 lun 0 
return code = 18000002
May  9 18:10:21 athlon kernel: sd0b:01: old sense key None
May  9 18:10:21 athlon kernel: Non-extended sense class 0 code 0x0
May  9 18:10:21 athlon kernel:  I/O error: dev 0b:01, sector 152
May  9 18:10:41 athlon kernel: scsi0 : channel 0 target 1 lun 0 request sense 
failed, performing reset.
May  9 18:10:41 athlon kernel: SCSI bus is being reset for host 0 channel 0.
May  9 18:10:41 athlon kernel: SCSI cdrom error : host 0 channel 0 id 1 lun 0 
return code = 18000002
May  9 18:10:41 athlon kernel: sd0b:01: old sense key None
May  9 18:10:41 athlon kernel: Non-extended sense class 0 code 0x0
May  9 18:10:41 athlon kernel:  I/O error: dev 0b:01, sector 152
May  9 18:10:41 athlon kernel: scsi0 : channel 0 target 1 lun 0 request sense 
failed, performing reset.
May  9 18:10:41 athlon kernel: SCSI bus is being reset for host 0 channel 0.
May  9 18:10:41 athlon kernel: SCSI cdrom error : host 0 channel 0 id 1 lun 0 
return code = 18000002
May  9 18:10:41 athlon kernel: sd0b:01: old sense key None
May  9 18:10:41 athlon kernel: Non-extended sense class 0 code 0x0
May  9 18:10:41 athlon kernel:  I/O error: dev 0b:01, sector 152
May  9 18:10:48 athlon kernel: scsi0 : channel 0 target 1 lun 0 request sense 
failed, performing reset.
May  9 18:10:48 athlon kernel: SCSI bus is being reset for host 0 channel 0.
May  9 18:10:50 athlon kernel: scsi0 : channel 0 target 1 lun 0 request sense 
failed, performing reset.



7. Reboot. I couldn't mount any more this CD with my burning device Philips 
CDD 3610 (ATAPI-burner). The following log appears:

May  9 18:18:02 athlon kernel: SCSI subsystem driver Revision: 1.00
May  9 18:18:02 athlon kernel: scsi0 : SCSI host adapter emulation for IDE 
ATAPI devices
May  9 18:18:02 athlon kernel:   Vendor:           Model: ATAPI CDROM.48X   
Rev: 120Y
May  9 18:18:02 athlon kernel:   Type:   CD-ROM                             
ANSI SCSI revision: 02
May  9 18:18:02 athlon kernel:   Vendor: PHILIPS   Model: CDD3610 CD-R/RW   
Rev: 3.01
May  9 18:18:02 athlon kernel:   Type:   CD-ROM                             
ANSI SCSI revision: 02
May  9 18:18:02 athlon kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, 
id 0, lun 0
May  9 18:18:02 athlon kernel: Attached scsi CD-ROM sr1 at scsi0, channel 0, 
id 1, lun 0
May  9 18:18:02 athlon kernel: sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 
cdda tray
May  9 18:18:02 athlon kernel: Uniform CD-ROM driver Revision: 3.12
May  9 18:18:02 athlon kernel: sr1: scsi3-mmc drive: 2x/6x writer cd/rw 
xa/form2 cdda tray
May  9 18:18:02 athlon kernel: VFS: Disk change detected on device sr(11,1)
May  9 18:18:02 athlon kernel: attempt to access beyond end of device
May  9 18:18:02 athlon kernel: 0b:01: rw=0, want=1657690660, limit=2
May  9 18:18:02 athlon kernel: isofs_read_super: bread failed, dev=0b:01, 
iso_blknum=1902587153, block=1902587153
May  9 18:18:24 athlon kernel: sr1: CDROM (ioctl) error, command: Test Unit 
Ready 00 00 00 00 00
May  9 18:18:24 athlon kernel: Info fld=0x0, Current sr00:00: sense key 
Medium Error
May  9 18:18:24 athlon kernel: Additional sense indicates Unable to recover 
table-of-contents
May  9 18:18:37 athlon kernel: sr1: CDROM (ioctl) error, command: Start/Stop 
Unit 00 00 00 03 00
May  9 18:18:37 athlon kernel: Info fld=0x0, Current sr00:00: sense key 
Medium Error
May  9 18:18:37 athlon kernel: Additional sense indicates Unable to recover 
table-of-contents
May  9 18:18:37 athlon kernel: cdrom: open failed.
May  9 18:20:43 athlon kernel: VFS: Disk change detected on device sr(11,0)
May  9 18:20:43 athlon kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
May  9 18:20:43 athlon kernel: ISO 9660 Extensions: RRIP_1991A
May  9 18:22:14 athlon kernel: sr1: CDROM (ioctl) error, command: Test Unit 
Ready 00 00 00 00 00
May  9 18:22:14 athlon kernel: Info fld=0x0, Current sr00:00: sense key 
Medium Error
May  9 18:22:14 athlon kernel: Additional sense indicates Unable to recover 
table-of-contents
May  9 18:22:27 athlon kernel: sr1: CDROM (ioctl) error, command: Start/Stop 
Unit 00 00 00 03 00
May  9 18:22:27 athlon kernel: Info fld=0x0, Current sr00:00: sense key 
Medium Error
May  9 18:22:27 athlon kernel: Additional sense indicates Unable to recover 
table-of-contents
May  9 18:22:27 athlon kernel: cdrom: open failed.


8. Mounting of this CD with my cdrom-device is no problem and works very fast.
9. I burned another CD (627 MB Data on 700 MB CD-R). The burning was 
errrorfree, mounting with CD-device with no problems, but cdrecorder tells in 
/var/log/messages:

May  9 19:13:08 athlon kernel: sr1: CDROM (ioctl) error, command: Test Unit 
Ready 00 00 00 00 00
May  9 19:13:08 athlon kernel: Info fld=0x0, Current sr00:00: sense key 
Medium Error
May  9 19:13:08 athlon kernel: Additional sense indicates Unable to recover 
table-of-contents
May  9 19:13:14 athlon kernel: VFS: Disk change detected on device sr(11,1)
May  9 19:13:15 athlon kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
May  9 19:13:15 athlon kernel: ISO 9660 Extensions: RRIP_1991A

With this CD, I've no further problems while reading with the cdrecorder.


[3.] Keywords (i.e., modules, networking, kernel):

ide-scsi, kernel panic, mount

[4.] Kernel version (from /proc/version):

Linux version 2.4.4-ac4 (root@athlon) (gcc version 2.95.3 20010315 (release)) 
#2 Sam Mai 5 01:38:39 CEST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

<0> Kernel panic. Attempt to kill the idle task. In idle task not syncing.
<1> unable to handle NULL pointer dereference at virtual address ... [I 
hoped, the oops had been logged in messages - nope; is there any way to save 
the output of this kernel oops?]


[6.] A small shell script or example program which triggers the
     problem (if possible)

umount /cdrom

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

 Linux athlon 2.4.4-ac4 #2 Sam Mai 5 01:38:39 CEST 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.76.1
binutils               2.9.5.0.12
util-linux             2.10s
mount                  2.10s
modutils               2.4.5
e2fsprogs              1.19
PPP                    2.4.0b1
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.2
Net-tools              1.56
Kbd                    0.96
Sh-utils               2.0g
Modules Loaded         ide-scsi sr_mod scsi_mod cdrom isofs via82cxxx_audio 
ac97_codec r128 agpgart nfs lockd sunrpc 8139too sis900 parport_pc parport 
unix

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 801.845
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1599.07


[7.3.] Module information (from /proc/modules):

ide-scsi                7536   0 (autoclean)
sr_mod                 11232   0 (autoclean) (unused)
scsi_mod               78432   2 (autoclean) [ide-scsi sr_mod]
cdrom                  27392   0 (autoclean) [sr_mod]
isofs                  17328   0 (autoclean)
via82cxxx_audio        16736   0 (autoclean) (unused)
ac97_codec              8496   0 (autoclean) [via82cxxx_audio]
r128                   84048   1 (autoclean)
agpgart                12496   3
nfs                    43648   1 (autoclean)
lockd                  38224   1 (autoclean) [nfs]
sunrpc                 57216   1 (autoclean) [nfs lockd]
8139too                10720   1 (autoclean)
sis900                 11008   1 (autoclean)
parport_pc             18960   0 (autoclean)
parport                26240   0 (autoclean) [parport_pc]
unix                   13984 126 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

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
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc Rage 128 PF
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. UHCI USB
dc00-dcff : VIA Technologies, Inc. AC97 Audio Controller
  dc00-dcff : via82cxxx
e000-e003 : VIA Technologies, Inc. AC97 Audio Controller
e400-e403 : VIA Technologies, Inc. AC97 Audio Controller
e800-e8ff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  e800-e8ff : sis900
ec00-ecff : Realtek Semiconductor Co., Ltd. RTL-8139
  ec00-ecff : 8139too


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-001ca37b : Kernel code
  001ca37c-001ff1b7 : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d3ffffff : PCI Bus #01
  d0000000-d3ffffff : ATI Technologies Inc Rage 128 PF
d4000000-d5ffffff : PCI Bus #01
  d5000000-d5003fff : ATI Technologies Inc Rage 128 PF
d6000000-d7ffffff : VIA Technologies, Inc. VT8371 [KX133]
d9000000-d9000fff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  d9000000-d9000fff : sis900
d9001000-d90010ff : Realtek Semiconductor Co., Ltd. RTL-8139
  d9001000-d90010ff : 8139too
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d6000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [PCI-PCI Bridge] (prog-if 
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d4000000-d5ffffff
        Prefetchable memory behind bridge: d0000000-d3ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) 
(prog-if 8a [Master SecP PriP])
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

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo 
Super AC97/Audio] (rev 20)
        Subsystem: VIA Technologies, Inc.: Unknown device 4511
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=4]
        Region 2: I/O ports at e400 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 02)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet 
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at d9000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at d9001000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 
00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at d5000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model: ATAPI CDROM.48X  Rev: 120Y
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: PHILIPS  Model: CDD3610 CD-R/RW  Rev: 3.01
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Please ask, if you want to know some more things!


[X.] Other notes, patches, fixes, workarounds:

dito.

Regards,
Andreas Hartmann

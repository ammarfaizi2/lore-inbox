Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263941AbTDNU0C (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbTDNU0C (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:26:02 -0400
Received: from corb.mc.mpls.visi.com ([208.42.156.1]:10163 "EHLO
	corb.mc.mpls.visi.com") by vger.kernel.org with ESMTP
	id S263941AbTDNUZo (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 16:25:44 -0400
Subject: PROBLEM: ioctl() I_SETSIG S_INPUT option fails on a FIFO
To: linux-kernel@vger.kernel.org
Date: Mon, 14 Apr 2003 15:37:33 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM74489641-11271-0_
Content-Transfer-Encoding: 7bit
Message-Id: <20030414203733.F21A576CA2@isis.visi.com>
From: jlb@visi.com (Joel L. Breazeale)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I would appreciate it if personal replies would be sent to jlb@visi.com.]

--ELM74489641-11271-0_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


[1.] One line summary of the problem: 
ioctl() I_SETSIG S_INPUT option fails on a FIFO

[2.] Full description of the problem/report: 
I have created a FIFO, attempted to create a signal handler for SIGPOLL, then do an I_SETSIG ioctl() call with the S_INPUT option to causing the signal handler to be called when a data is ready on the given file descriptor.  The ioctl() fails with an error 22. 

[3.] Keywords (i.e., modules, networking, kernel): 
kernel, fifo

[4.] Kernel version (from /proc/version):
Linux version 2.4.18-3 (bhcompile@daffy.perf.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 Thu Apr 18 07:37:53 EDT 2002 

[5.] Output of Oops.. message (if applicable) with symbolic information resolved (see Documentation/oops-tracing.txt) 
Using my test application (attached): ioctl call failed for I_SETSIG startup: Invalid argument

[6.] A small shell script or example program which triggers the problem (if possible) 
See sender.c and receiver.c in the attached file testapp.tar.Z.  Compile sender.c and receiver.c.  Run sender first.  Run receiver in a separate shell.  You should see the error.

[7.] Environment 

[7.1.] Software (add the output of the ver_linux script here) 
Linux jbreazealeli 2.4.18-3 #1 Thu Apr 18 07:37:53 EDT 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         nls_iso8859-1 sr_mod i810_audio ac97_codec soundcore agpgart binfmt_misc autofs nfs lockd sunrpc eepro100 ide-scsi scsi_mod ide-cd cdrom usb-uhci usbcore ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo): 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 996.782
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1985.74

[7.3.] Module information (from /proc/modules): 
nls_iso8859-1           3488   1 (autoclean)
sr_mod                 16920   2 (autoclean)
i810_audio             23008   0 (autoclean)
ac97_codec             11904   0 (autoclean) [i810_audio]
soundcore               6692   2 (autoclean) [i810_audio]
agpgart                39488   4 (autoclean)
binfmt_misc             7556   1
autofs                 12164   0 (autoclean) (unused)
nfs                    86108   5 (autoclean)
lockd                  56736   1 (autoclean) [nfs]
sunrpc                 75764   1 (autoclean) [nfs lockd]
eepro100               20336   1
ide-scsi                9664   1
scsi_mod              108608   2 [sr_mod ide-scsi]
ide-cd                 30272   0
cdrom                  32192   0 [sr_mod ide-cd]
usb-uhci               24484   0 (unused)
usbcore                73152   1 [usb-uhci]
ext3                   67136   4
jbd                    49400   4 [ext3]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem) 
/proc/ioports:
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #01
  df00-df3f : Intel Corp. 82820 (ICH2) Chipset Ethernet Controller
    df00-df3f : eepro100
e800-e8ff : Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Audio Controller
  e800-e8ff : Intel ICH2
ef00-ef3f : Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Audio Controller
  ef00-ef3f : Intel ICH2
ef40-ef5f : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A)
  ef40-ef5f : usb-uhci
ef80-ef9f : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B)
  ef80-ef9f : usb-uhci
efa0-efaf : Intel Corp. 82820 820 (Camino 2) Chipset SMBus
ffa0-ffaf : Intel Corp. 82820 820 (Camino 2) Chipset IDE U100
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0febffff : System RAM
  00100000-00217cb0 : Kernel code
  00217cb1-002d9b3f : Kernel data
0fec0000-0fef7fff : ACPI Tables
0fef8000-0fefffff : ACPI Non-volatile Storage
f6a00000-f6afffff : PCI Bus #01
f8000000-fbffffff : Intel Corp. 82815 CGC [Chipset Graphics Controller]
ff800000-ff8fffff : PCI Bus #01
  ff8ff000-ff8fffff : Intel Corp. 82820 (ICH2) Chipset Ethernet Controller
    ff8ff000-ff8fffff : eepro100
ffa80000-ffafffff : Intel Corp. 82815 CGC [Chipset Graphics Controller]
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root) 
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [88] #09 [f104]

00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics Controller] (rev 02) (prog-if 00 [VGA])
        Subsystem: Intel Corp.: Unknown device 4541
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at ffa80000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff800000-ff8fffff
        Prefetchable memory behind bridge: f6a00000-f6afffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 02) (prog-if 80 [Master])
        Subsystem: Intel Corp.: Unknown device 4541
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4541
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at ef40 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 02)
        Subsystem: Intel Corp.: Unknown device 4541
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at efa0 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4541
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at ef80 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 02)
        Subsystem: Intel Corp.: Unknown device 4541
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at e800 [size=256]
        Region 1: I/O ports at ef00 [size=64]

01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller (rev 01)
        Subsystem: Intel Corp.: Unknown device 3013
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ff8ff000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at df00 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] SCSI information (from /proc/scsi/scsi) 
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TEAC     Model: CD-540E          Rev: 1.0A
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem (please look in /proc and include all information that you think to be relevant): 
None.

[X.] Other notes, patches, fixes, workarounds: 
I have tried this on RedHat 9.0 (kernel version 2.4.20-9) and still see the problem.

--ELM74489641-11271-0_
Content-Type: application/x-compress
Content-Disposition: attachment; filename=testapp.tar.Z
Content-Description: testapp.tar.Z
Content-Transfer-Encoding: base64

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

--ELM74489641-11271-0_--

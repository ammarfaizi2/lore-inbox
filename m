Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265753AbUADQLy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUADQLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:11:54 -0500
Received: from [4.5.117.126] ([4.5.117.126]:2432 "EHLO ventus.caztech.com")
	by vger.kernel.org with ESMTP id S265753AbUADQKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:10:40 -0500
From: Caz Yokoyama <caz@caztech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16376.15042.668588.675054@ventus.caztech.com>
Date: Sun, 4 Jan 2004 08:09:38 -0800
To: linux-kernel@vger.kernel.org
Cc: caz@caztech.com
Subject: dmfe is slow because of "eth1: Tx timeout - resetting"
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] dmfe is slow because of "eth1: Tx timeout - resetting"

[2.] 
When my PC has Davicom DM9102/DM9102A/DM9102A+DM9801/DM9102A+DM9802
NIC(PCI, driver is dmfe) and Hawking UF100(USB, driver is pegasus),
DM9102 is reset frequently(like every 20 second). Therefore,
communication is very slow. The message I got from DM9102 is
Jan  4 06:59:27 tragi kernel: eth1: Tx timeout - resetting
This message appears every time it is reset.

Sometimes I got the message from pegasus driver which comes from
		info("intr status %d", urb->status);
in static void intr_callback(struct urb *urb). The status is -84.

[3.] networking, dmfe, pegasus, resetting

[4.]
Linux version 2.4.23 (root@tragi) (gcc version 2.95.4 20011002 (Debian prereleas
e)) #8 Sun Dec 28 06:55:30 PST 2003

[5.]
Jan  4 07:05:16 tragi kernel: eth1: Tx timeout - resetting

[6.]
When ping to the eth1(DM9102), several icmp_seq in about 200 of icmp
packets are skipped when it is reset. The communication on pegasus
seems OK.

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
# sh ./scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux tragi 2.4.23 #8 Sun Dec 28 06:55:30 PST 2003 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
reiserfsprogs          3.x.1b
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         rtc orinoco_tmd orinoco hermes dmfe crc32 pegasus isofs vfat fat nfs lockd sunrpc ipt_LOG ipt_state iptable_mangle iptable_filter ipt_MASQUERADE iptable_nat ip_conntrack ip_tables lp parport_pc parport ext3 jbd usb-ohci usbcore

[7.2.] Processor information (from /proc/cpuinfo):
$ cat cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 501.137
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 999.42

[7.3.] Module information (from /proc/modules):
# cat /proc/modules
rtc                     5756   0 (autoclean)
orinoco_tmd             1952   1 (autoclean)
orinoco                30720   0 (autoclean) [orinoco_tmd]
hermes                  5216   0 (autoclean) [orinoco_tmd orinoco]
dmfe                   11836   1 (autoclean)
crc32                   2832   0 (autoclean) [dmfe]
pegasus                13984   1 (autoclean)
isofs                  17152   0 (unused)
vfat                    9308   0 (unused)
fat                    29368   0 [vfat]
nfs                    63196   0 (unused)
lockd                  47296   0 [nfs]
sunrpc                 61492   0 [nfs lockd]
ipt_LOG                 3264  10
ipt_state                608   2
iptable_mangle          2208   0 (unused)
iptable_filter          1728   1
ipt_MASQUERADE          1312   2
iptable_nat            14900   1 [ipt_MASQUERADE]
ip_conntrack           18132   2 [ipt_state ipt_MASQUERADE iptable_nat]
ip_tables              10912   8 [ipt_LOG ipt_state iptable_mangle iptable_filter ipt_MASQUERADE iptable_nat]
lp                      5568   0 (unused)
parport_pc             11844   1
parport                13856   1 [lp parport_pc]
ext3                   57152   2
jbd                    36232   2 [ext3]
usb-ohci               16192   0 (unused)
usbcore                34528   0 [pegasus usb-ohci]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
$ cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #01
  bc00-bc7f : PCI device 1039:6306
d600-d6ff : PCI device 13f6:0111
d800-d83f : PCI device 13f6:0211
da00-da7f : PCI device 1282:9102
  da00-da7f : dmfe
dc00-dc3f : PCI device 15e8:0131
  dc00-dc3f : orinoco_tmd
de00-de0f : PCI device 15e8:0131
ffa0-ffaf : PCI device 1039:5513
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Extension ROM
000f0000-000fffff : System ROM
00100000-077effff : System RAM
  00100000-001ca3d5 : Kernel code
  001ca3d6-001fe8ff : Kernel data
077f0000-077f7fff : ACPI Tables
077f8000-077fffff : ACPI Non-volatile Storage
e6c00000-e7cfffff : PCI Bus #01
  e7000000-e77fffff : PCI device 1039:6306
e7e00000-e7efffff : PCI Bus #01
  e7ef0000-e7efffff : PCI device 1039:6306
e8000000-ebffffff : PCI device 1039:0620
efffaf80-efffafff : PCI device 1282:9102
  efffaf80-efffafff : dmfe
efffb000-efffbfff : PCI device 1039:7001
  efffb000-efffbfff : usb-ohci
ffef0000-ffefffff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
# lspci -vvv
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 620 Host (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ffa0 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev b3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 11) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at efffb000 (32-bit, non-prefetchable) [size=4K]

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: e7e00000-e7efffff
        Prefetchable memory behind bridge: e6c00000-e7cfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:09.0 Network controller: National Datacomm Corp: Unknown device 0131 (rev 01)
        Subsystem: National Datacomm Corp: Unknown device 0131
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 1: I/O ports at de00 [size=16]
        Region 2: I/O ports at dc00 [size=64]

00:0b.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 10)
        Subsystem: Unknown device 0291:8212
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (5000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at da00 [size=128]
        Region 1: Memory at efffaf80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at eff80000 [disabled] [size=256K]
        Capabilities: [50] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d600 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 Communication controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CM8738
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 12
        Region 0: I/O ports at d800 [size=64]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk+ DSI- D1- D2+ AuxCurrent=55mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D3 PME-Enable+ DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306 3D-AGP (rev 2a) (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS] SiS530,620 GUI Accelerator+3D
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min)
        Region 0: Memory at e7000000 (32-bit, prefetchable) [size=8M]
        Region 1: Memory at e7ef0000 (32-bit, non-prefetchable) [size=64K]
        Region 2: I/O ports at bc00 [size=128]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 1.0
                Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)
# cat /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
# cd /proc
# ls
1     1481  1627  456  5    523      cpuinfo      iomem    misc        swaps
109   1482  1628  461  500  524      devices      ioports  modules     sys
127   1499  1699  465  503  528      dma          irq      mounts      sysvipc
1319  1500  2     470  506  529      driver       kcore    net         tty
132   1551  2054  48   510  6        execdomains  kmsg     partitions  uptime
1320  1580  3     483  513  82       filesystems  ksyms    pci         version
1321  1581  3933  492  517  83       fs           loadavg  self
1322  1595  4     494  521  bus      ide          locks    slabinfo
1323  1601  453   498  522  cmdline  interrupts   meminfo  stat

[X.] Other notes, patches, fixes, workarounds:
dmfe without pegasus works fine. I haven't check the pegasus alone.

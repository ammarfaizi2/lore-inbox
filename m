Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUAPWEy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbUAPWEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:04:54 -0500
Received: from mailwasher.lanl.gov ([192.16.0.25]:17491 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S265764AbUAPVn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:43:29 -0500
Subject: AIC7xxx kernel problem with 2.4.2[234] kernels
From: Stephen Smoogen <smoogen@lanl.gov>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: CCN-2 ESM/SSC
Message-Id: <1074289406.5752.5.camel@smoogen2.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 16 Jan 2004 14:43:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this is in the correct mode and I am sending it to the correct
list :). Please let me know what other information I need to supply.


[1.] One line summary of the problem:

Booting problems with aic7xxx with stock kernel 2.4.24.

[2.] Full description of the problem/report:

I think I am seeing the same problem that was reported to the list from
Moal Tanguy on 2003-09-08. Our oem systems use an older SuperMicro
motherboard with a built on aic7xxx Adaptec aic7892 Ultra160 SCSI
adapter. Most of the systems have a forward mounted 'removable' 18
gigabyte scsi disk drive (different manufacturers). When running any Red
Hat kernel we have no problems booting the system. When using 2.4.22,
2.4.23, or 2.4.24 kernels, the system loads in the aic7xxx module from
the initrd and probes the interfaces. In systems with multiple disks, it
reaches the first drive (the removable disk) and errors out with a slow
progression of


Unexpected busfree while idle
SEQ 0x01

After 10 or so of these, it will then go merrily onto the next disk
without reporting any errors, and then 'crashes' because it was unable
to find the root directory to continue.

Interestinglyu, after this has happened using the hardware reset will
cause the system to not be able to find the SCSI ID0 disk to boot
from. A complete power cycle is needed for the SCSI controller to find
the disk again.

Patched 2.4.24 kernel with latest items from Justin Gibbs website, and
problem occurs in same form. From what I could google, I am expecting it
is hardware related in some issue, but would love to know what.

[3.] Keywords (i.e., modules, networking, kernel):

kernel | drivers | scsi | aic7xxx

[4.] Kernel version (from /proc/version):

Linux version 2.4.24 (smoogen@rh73dev.ds.lanl.gov) (gcc version 2.96
20000731 (Red Hat Linux 7.3 2.96-113)) #1 Mon Jan 12 14:44:21 MST 2004

CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

None

[6.] A small shell script or example program which triggers the
     problem (if possible)

Not Applicaple

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

This is from the machine that was used to build the kernel.

# sh ./scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux rh73dev.ds.lanl.gov 2.4.20-19.7 #1 Tue Jul 15 13:44:14 EDT 2003
i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.18
e2fsprogs              1.27
quota-tools            3.06.
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         autofs nfs lockd sunrpc eepro100 mii ipv6
usb-ohci usbcore ext3 jbd aic7xxx sd_mod scsi_mod


[7.2.] Processor information (from /proc/cpuinfo):


# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 866.277
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1730.15

[7.3.] Module information (from /proc/modules):

[All info below is from running Red Hat kernel 2.4.20-28.7 as it works.]

# cat /proc/modules
ide-cd                 32256   0 (autoclean)
cdrom                  32128   0 (autoclean) [ide-cd]
loop                   10736   0 (unused)
eepro100               21068   1 (autoclean)
mii                     3976   0 (autoclean) [eepro100]
usb-ohci               20544   0 (unused)
usbcore                73792   1 [usb-ohci]
aic7xxx               133248   6
sd_mod                 12828  12
scsi_mod              107548   2 [aic7xxx sd_mod]


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

[All info below is from running Red Hat kernel 2.4.20-28.7 as it works.]

# cat /proc/ioports
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
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
d800-d83f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  d800-d83f : eepro100
e400-e4ff : Adaptec AIC-7892P U160/m
e800-e8ff : ATI Technologies Inc Rage XL
ffa0-ffaf : ServerWorks OSB4 IDE Controller
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000cc800-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-00225f42 : Kernel code
  00225f43-0031caff : Kernel data
3fff0000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
fc900000-fc9fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
fcafe000-fcafefff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fcafe000-fcafefff : eepro100
fcaff000-fcafffff : ServerWorks OSB4/CSB5 OHCI USB Controller
  fcaff000-fcafffff : usb-ohci
fd000000-fdffffff : ATI Technologies Inc Rage XL
febfe000-febfefff : Adaptec AIC-7892P U160/m
  febfe000-febfefff : aic7xxx
febff000-febfffff : ATI Technologies Inc Rage XL
fec00000-fec01fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

# lspci -vvv
00:00.0 Host bridge: ServerWorks CNB20LE (rev 06)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32, cache line size 08
                                                                                                                                          
00:00.1 Host bridge: ServerWorks CNB20LE (rev 06)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16, cache line size 08
                                                                                                                                          
00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: Intel Corporation 82559 Fast Ethernet LAN on
Motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at fcafe000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at d800 [size=64]
        Region 2: Memory at fc900000 (32-bit, non-prefetchable)
[size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
                                                                                                                                          
00:0f.0 ISA bridge: ServerWorks OSB4 (rev 50)
        Subsystem: ServerWorks OSB4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
                                                                                                                                          
00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a
[Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at ffa0 [size=16]
                                                                                                                                          
00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04)
(prog-if 10 [OHCI])
        Subsystem: ServerWorks: Unknown device 0220
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fcaff000 (32-bit, non-prefetchable)
[size=4K]
                                                                                                                                          
01:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: I/O ports at e800 [size=256]
        Region 2: Memory at febff000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at febc0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:03.0 SCSI storage controller: Adaptec 7892P (rev 02)
        Subsystem: Super Micro Computer Inc: Unknown device 9005
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: I/O ports at e400 [disabled] [size=256]
        Region 1: Memory at febfe000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at feba0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 

[7.6.] SCSI information (from /proc/scsi/scsi)

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S9YB
  Type:   Direct-Access                    ANSI SCSI revision: 03


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:


-- 
Stephen John Smoogen		smoogen@lanl.gov
Los Alamos National Lab  CCN-5 Sched 5/40  PH: 4-0645
Ta-03 SM-1498 MailStop B255 DP 10S  Los Alamos, NM 87545
-- So shines a good deed in a weary world. = Willy Wonka --


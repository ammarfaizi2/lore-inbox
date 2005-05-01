Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVEAQ4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVEAQ4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 12:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVEAQ4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 12:56:25 -0400
Received: from samba.lucas.lu.se ([130.235.92.6]:23815 "EHLO samba.lucas.lu.se")
	by vger.kernel.org with ESMTP id S261695AbVEAQ4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 12:56:08 -0400
Message-ID: <42750A98.6040601@fysik.lu.se>
Date: Sun, 01 May 2005 18:58:00 +0200
From: Gabriele Kalus <gabriele.kalus@fysik.lu.se>
Reply-To: gabriele.kalus@fysik.lu.se
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug report 2.4.21-280-athlon
Content-Type: multipart/mixed;
 boundary="------------020701000006000203020200"
X-BitDefender-SpamStamp: 1.1.3  044000040111AAAAAACAAAAAAAAAAAAAAAI
X-BitDefender-Scanner: Clean, Agent: BitDefender Qmail 1.6.2 on
 samba.lucas.lu.se
X-BitDefender-Spam: No (0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020701000006000203020200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I don't really know which person to send this bug report to so the list 
suggested I send it to this address. Attached is the information about 
the problem.

Regards

Gabriele Kalus

-- 
Gabriele Kalus, Ph.D.
System Administrator
Lund University, Physics Department
Box 118 SE-22100 Lund, SWEDEN
Phone:	+46-462229675
Mobil:	0702-901227
Fax:	+46-462224709

--------------020701000006000203020200
Content-Type: text/plain;
 name="kernelbug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernelbug.txt"

1. Repeated msg of kernel: drive_stat_acct: cmd not R/W? in kernel log

2. On a SuSE 9.0 the kernel was updated from kernel version 2.4.21-273-athlon to 2.4.21-280-athlon on the 4th of March.
The box act as a mailserver for approximately 500 users. The box has three Western Digital disks, one WDC WD400EB-00CPF0 
and two WDC WD800BB-00BSA0. The two WDC WD800BB-00BSA0 disks are attached to a promise controllercard PDC20265 and are in raid1. 
The mail are stored on the raid1. The message "kernel: drive_stat_acct: cmd not R/W?" only occurs when the raid is mounted. 
On April the 29th the following happened 
"Apr 29 06:01:33 samba kernel: PDC202XX: Primary channel reset.
Apr 29 06:01:33 samba kernel: PDC202XX: Secondary channel reset.
Apr 29 06:01:33 samba kernel: hde: timeout waiting for DMA
Apr 29 06:01:53 samba kernel: hde: dma_timer_expiry: dma status == 0x21
Apr 29 06:02:03 samba kernel: hde: timeout waiting for DMA
...
Apr 29 06:02:53 samba kernel: hdg: dma_timer_expiry: dma status == 0x21
Apr 29 06:03:03 samba kernel: hdg: timeout waiting for DMA
Apr 29 06:03:03 samba kernel: PDC202XX: Secondary channel reset.
Apr 29 06:03:03 samba kernel: PDC202XX: Primary channel reset.
Apr 29 06:03:03 samba kernel: hdg: timeout waiting for DMA
Apr 29 06:03:03 samba kernel: blk: queue c03ec17c, I/O limit 4095Mb (mask 0xffffffff)
..."
After further investigation it was noticed that the DMA mode was no longer activated at startup on the raid 
disks, they were set in pio mode. At the 29th the system time also started to lag from usually -10 seconds per
day to +500 seconds per day.

Today the 1st of May the kernel was downgraded from 2.4.21-280 to the old version 2.4.21-273 and the error messages
are gone.

7.1 Output from scripts/ver_linux.output

Linux samba 2.4.21-273-athlon #1 Mon Jan 17 13:03:46 UTC 2005 i686 athlon i386 GNU/Linux
 
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.34
jfsutils               1.1.2
Linux C Library        x    1 root     root      1461208 Sep 24  2003 /lib/i686/libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.1.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         isa-pnp thermal processor fan button af_packet battery ac ipt_TCPMSS 
ipt_LOG ipt_TOS ipt_state eepro100 mii ip6t_LOG ip6t_REJECT ip6table_mangle ipt_REJECT 
iptable_mangle iptable_filter ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables 
ip6table_filter ip6_tables ipv6 key lvm-mod raid1 ext3 jbd

7.2 
/proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1009.055
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1982.46

7.3
/proc/modules
isa-pnp                32712   0 (unused)
thermal                 6180   0 (unused)
processor               8312   0 [thermal]
fan                     1472   0 (unused)
button                  2380   0 (unused)
af_packet              13192   1 (autoclean)
battery                 5600   0 (unused)
ac                      1696   0 (unused)
ipt_TCPMSS              2392   1 (autoclean)
ipt_LOG                 3384   1 (autoclean)
ipt_TOS                 1048   9 (autoclean)
ipt_state                568  56 (autoclean)
eepro100               19860   1
mii                     2640   0 [eepro100]
ip6t_LOG                3704   0 (autoclean)
ip6t_REJECT             1528   3 (autoclean)
ip6table_mangle         2744   0 (autoclean) (unused)
ipt_REJECT              3288   3 (autoclean)
iptable_mangle          2168   1 (autoclean)
iptable_filter          1708   1 (autoclean)
ip_nat_ftp              2992   0 (unused)
iptable_nat            16366   1 [ip_nat_ftp]
ip_conntrack_ftp        3920   1
ip_conntrack           18084   3 [ipt_state ip_nat_ftp iptable_nat ip_conntrack_ftp]
ip_tables              11328  10 [ipt_TCPMSS ipt_LOG ipt_TOS ipt_state ipt_REJECT iptable_mangle iptable_filter iptable_nat]
ip6table_filter         1804   1 (autoclean)
ip6_tables             12224   4 [ip6t_LOG ip6t_REJECT ip6table_mangle ip6table_filter]
ipv6                  227456  -1 (autoclean) [ip6t_REJECT]
key                    70456   0 (autoclean) [ipv6]
lvm-mod                65508   0 (autoclean)
raid1                  13744   1 (autoclean)
ext3                   88552   2
jbd                    52480   2 [ext3]

7.4
/proc/ioports
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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
8800-883f : Promise Technology, Inc. 20265
  8800-8807 : ide2
  8808-880f : ide3
  8810-883f : PDC20265
9000-9003 : Promise Technology, Inc. 20265
  9002-9002 : ide3
9400-9407 : Promise Technology, Inc. 20265
  9400-9407 : ide3
9800-9803 : Promise Technology, Inc. 20265
  9802-9802 : ide2
a000-a007 : Promise Technology, Inc. 20265
  a000-a007 : ide2
a400-a43f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  a400-a43f : eepro100
d000-d01f : VIA Technologies, Inc. USB (#2)
d400-d41f : VIA Technologies, Inc. USB
d800-d80f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e200-e27f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

/proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000ce7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffebfff : System RAM
  00100000-002b1099 : Kernel code
  002b109a-00348943 : Kernel data
3ffec000-3ffeefff : ACPI Tables
3ffef000-3fffefff : reserved
3ffff000-3fffffff : ACPI Non-volatile Storage
d4800000-d481ffff : Promise Technology, Inc. 20265
d5000000-d501ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
d5800000-d5800fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  d5800000-d5800fff : eepro100
d6000000-d7dfffff : PCI Bus #01
  d6000000-d6ffffff : nVidia Corporation NV11 [GeForce2 MX]
d7f00000-e5ffffff : PCI Bus #01
  d8000000-dfffffff : nVidia Corporation NV11 [GeForce2 MX]
    d8000000-d9ffffff : vesafb
e6000000-e7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved

7.5 
lspci -vvv

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e6000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: d6000000-d7dfffff
        Prefetchable memory behind bridge: d7f00000-e5ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d5800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at a400 [size=64]
        Region 2: Memory at d5000000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at a000 [size=8]
        Region 1: I/O ports at 9800 [size=4]
        Region 2: I/O ports at 9400 [size=8]
        Region 3: I/O ports at 9000 [size=4]
        Region 4: I/O ports at 8800 [size=64]
        Region 5: Memory at d4800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev a1) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at d7ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
                
We downgraded to 2.4.21-273-athlon which seems to show that there is a problem with the SuSE 9.0 2.4.21-280-athlon kernel.
--------------020701000006000203020200--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUITTu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUITTu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUITTu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:50:27 -0400
Received: from mars38.magicalworks.com ([81.3.20.113]:26530 "EHLO
	mars38.magicalworks.com") by vger.kernel.org with ESMTP
	id S267285AbUITTsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:48:30 -0400
Subject: PROBLEM: Kernel Panic removing pcmcia card
From: Benjamin Voetterle <benjamin@voetterle.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1095709701.1647.19.camel@voetzi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 20 Sep 2004 21:48:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

here my 'Bug Report', I hope this is the right list and the rightway to
report a bug (i'm not sure it is one or it is a failure on my side).

[1.] One line summary of the problem:
    Kernel Panic removing pcmcia card

[2.] Full description of the problem/report:
I've the following problem, when i'm inserting my 3com Wlan card (3CRWE154G72),
 i get the following Kernel Output:

 PCI: 0000:01:00.0: class 1 doesn't match header type 01. Ignoring class. 
Unable to handle kernel NULL pointer dereference at virtual address
00000008 
  printing eip: 
c0191fbb 
*pde = 00000000 
Oops: 0000 [#1] 
PREEMPT 
Modules linked in: ipv6 ds apm af_packet yenta_socket pcmcia_core tsdev
mousedev evdev lbtouch sermouse ide_cd cdrom rtc unix 
CPU:    0 
EIP:    0060:[sysfs_add_file+27/176]    Not tainted 
EIP is at sysfs_add_file+0x1b/0xb0 
eax: 00000000   ebx: cbc5c920   ecx: c03ed208   edx: cbc5c960 
esi: cbc5c8e0   edi: 00000000   ebp: c03b51dc   esp: cb4b7ebc 
ds: 007b   es: 007b   ss: 0068 
Process pccardd (pid: 822, threadinfo=cb4b6000 task=cba8f220) 
: Stack: cbc5c9a8 c020aee9 cbc5c960 cbc5c920 cbc5c8e0 cbfdee40 00000000
c020aa53 
        00000000 c03b51dc c01c69f3 cbc5c958 c03b51dc 00000000 00000000
cb11b400 
        00000000 00000001 00000000 c01c6c98 cbfdee40 cb11b400 00000000
00000001 
Call Trace: 
  [class_device_add+281/304] class_device_add+0x119/0x130 
  [class_device_create_file+35/48] class_device_create_file+0x23/0x30 
  [pci_alloc_child_bus+147/224] pci_alloc_child_bus+0x93/0xe0 
  [pci_scan_bridge+520/592] pci_scan_bridge+0x208/0x250 
  [__crc_atapi_output_bytes+623555/2523336] cb_alloc+0xd6/0xe0
[pcmcia_core] 
  [__crc_atapi_output_bytes+611238/2523336] socket_insert+0xa9/0x150
[pcmcia_core] 
  [__crc_atapi_output_bytes+611997/2523336]
socket_detect_change+0x60/0x90 [pcmcia_core] 
[__crc_atapi_output_bytes+612499/2523336] pccardd+0x1c6/0x230
[pcmcia_core] 
[default_wake_function+0/32] default_wake_function+0x0/0x20 
  [ret_from_fork+6/20] ret_from_fork+0x6/0x14 
  [default_wake_function+0/32] default_wake_function+0x0/0x20 
  [__crc_atapi_output_bytes+612045/2523336] pccardd+0x0/0x230
[pcmcia_core] 
  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18 
Sep 10 14:00:01 localhost kernel: Code: 8b 47 08 8d 48 68 ff 48 68 0f 88
a0 01 00 00 8b 45 00 89 3c 


When i then remove the card from the pcmcia slot, i get the following
kernel panic:

Code: Bad EIP value. 
<0>Kernel panic: Fatal Exception in interrupt 
In interrupt handle - net syncing



[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
Linux version 2.6.8.1 (root@lfb2131) (gcc-Version 3.3.4 (Debian 1:3.3.4-6sarge1)) #1 Thu Sep 9 12:37:45 CEST 2004


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment

i686

[7.1.] Software (add the output of the ver_linux script here)

Linux lfb2131 2.6.8.1 #1 Thu Sep 9 12:37:45 CEST 2004 i686 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre5
e2fsprogs              1.35
pcmcia-cs              3.2.5
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         ipv6 ds apm af_packet yenta_socket pcmcia_core edd vsxxxaa tsdev mousedev evdev lbtouch ide_cd cdrom rtc unix

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 3
cpu MHz         : 398.293
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 786.43


[7.3.] Module information (from /proc/modules):
ipv6 265316 10 - Live 0xccb90000
ds 18756 2 - Live 0xccb13000
apm 21100 1 - Live 0xccb35000
af_packet 22600 2 - Live 0xccb3d000
yenta_socket 21728 0 - Live 0xccb19000
pcmcia_core 64204 2 ds,yenta_socket, Live 0xccb24000
edd 10428 0 - Live 0xccaf0000
vsxxxaa 6432 0 - Live 0xccb0e000
tsdev 7392 0 - Live 0xccaf4000
mousedev 10476 0 - Live 0xccab3000
evdev 9600 0 - Live 0xccaec000
lbtouch 8804 0 - Live 0xccab7000
ide_cd 42308 0 - Live 0xccb02000
cdrom 40736 1 ide_cd, Live 0xccaf7000
rtc 12760 0 - Live 0xccae5000
unix 28688 342 - Live 0xccabc000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports

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
02e8-02ef : serial
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:00.1
  1000-10ff : Intel 440MX - AC'97
1400-143f : 0000:00:00.1
  1400-143f : Intel 440MX - Controller
1440-147f : 0000:00:10.0
  1440-147f : eepro100
1480-148f : 0000:00:07.1
  1480-1487 : ide0
1490-1497 : 0000:00:11.0
14a0-14bf : 0000:00:07.2
  14a0-14bf : uhci_hcd
1800-18ff : 0000:00:11.0
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01

/proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-0bfdffff : System RAM
  00100000-00349972 : Kernel code
  00349973-004398ff : Kernel data
0bfe0000-0bfefbff : ACPI Tables
0bfefc00-0bfeffff : ACPI Non-volatile Storage
0bff0000-0bff0fff : reserved
0bff1000-0bffffff : System RAM
10000000-10000fff : 0000:00:13.0
  10000000-10000fff : yenta_socket
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
fe000000-fe0fffff : 0000:00:10.0
fe100000-fe100fff : 0000:00:10.0
  fe100000-fe100fff : eepro100
fe101000-fe1010ff : 0000:00:11.0
fe120000-fe13ffff : 0000:00:14.0
  fe120000-fe13ffff : tridentfb
fe400000-fe7fffff : 0000:00:14.0
fe800000-febfffff : 0000:00:14.0
  fe800000-fea7ffff : tridentfb
fff00000-ffffffff : reser
[7.5.] PCI information ('lspci -vvv' as root)

0000:00:00.0 Host bridge: Intel Corp. 82440MX Host Bridge (rev 01)
        Subsystem: Fujitsu Limited.: Unknown device 107f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64

0000:00:00.1 Multimedia audio controller: Intel Corp. 82440MX AC'97 Audio Controller
        Subsystem: Fujitsu Limited. QSound_SigmaTel Stac97 PCI Audio
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 1000 [size=256]
        Region 1: I/O ports at 1400 [size=64]

0000:00:07.0 Bridge: Intel Corp. 82440MX ISA Bridge (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:07.1 IDE interface: Intel Corp. 82440MX EIDE Controller (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1480 [size=16]

0000:00:07.2 USB Controller: Intel Corp. 82440MX USB Universal Host Controller (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at 14a0 [size=32]

0000:00:07.3 Bridge: Intel Corp. 82440MX Power Management Controller
        Control: I/O+ Mem+ BusMaster- SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:10.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Fujitsu Limited.: Unknown device 1070
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe100000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 1440 [size=64]
        Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:00:11.0 Communication controller: Lucent Microelectronics F-1156IV WinModem (V90, 56KFlex) (rev 01)
        Subsystem: Fujitsu Limited. LB Global LT Modem
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe101000 (32-bit, non-prefetchable) [disabled] [size=256]
        Region 1: I/O ports at 1490 [disabled] [size=8]
        Region 2: I/O ports at 1800 [disabled] [size=256]
        Capabilities: [f8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:13.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
        Subsystem: Fujitsu Limited.: Unknown device 10c6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

0000:00:14.0 VGA compatible controller: Trident Microsystems Cyber 9525 (rev 49) (prog-if 00 [VGA])
        Subsystem: Fujitsu Limited. Lifebook C6155
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
        Region 1: Memory at fe120000 (32-bit, non-prefetchable) [size=128K]
        Region 2: Memory at fe400000 (32-bit, non-prefetchable) [size=4M]
        Capabilities: [80] AGP version 1.0
                Status: RQ=33 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [90] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
/proc/interrupts
  0:    6681657          XT-PIC  timer
  1:       3174          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
 10:       1866          XT-PIC  uhci_hcd, Intel 440MX, yenta, eth0
 12:         25          XT-PIC  i8042
 14:      12465          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0



I hope this ok, so far.

Bye
Benjamin Voetterle


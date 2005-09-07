Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVIGM1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVIGM1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVIGM1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:27:09 -0400
Received: from [193.192.52.2] ([193.192.52.2]:58706 "EHLO mikesnet.ro")
	by vger.kernel.org with ESMTP id S932129AbVIGM1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:27:08 -0400
Message-ID: <431EDC8A.8040508@mikesnet.ro>
Date: Wed, 07 Sep 2005 15:26:50 +0300
From: Ady Deac <ady@mikesnet.ro>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Badness in dst_release at include/net/dst.h:154
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:   
I am using linux and quagga (latest release) for a small network. It 
does load-balancing between 3 providers.

[2.] Full description of the problem/report:
If I only make a default route (the hard way - route add default gw 
xxx.xxx.xxx.xxx) everything is more then OK, but AFAIK this is not the 
way to handle routes in BGP. So I did registered the three gateways in 
zebra as default routes. After a couple of minutes, the kernel oopses:
I have googled the problem and showed up only one article:
https://www.redhat.com/archives/fedora-test-list/2005-May/msg00373.html

Maybe, if we find out the problem, we can let the poor guy know ;)

[3.] Keywords (i.e., modules, networking, kernel):
kernel, networking

[4.] Kernel version (from /proc/version):
Linux version 2.6.13 (root@router.mikesnet.ro) (gcc version 3.4.4) #1 
Sun Sep 4 03:34:46 EEST 2005

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
...
Sep  7 12:57:40 router.mikesnet.ro kernel: Badness in dst_release at 
include/net/dst.h:154
Sep  7 12:57:41 router.mikesnet.ro kernel:  [<c03f2fcd>] 
__kfree_skb+0x16d/0x180
Sep  7 12:57:41 router.mikesnet.ro kernel:  [<c0457e2d>] 
arp_process+0x8d/0x570
Sep  7 12:57:41 router.mikesnet.ro kernel:  [<c0458404>] arp_rcv+0xf4/0x180
Sep  7 12:57:41 router.mikesnet.ro kernel:   [<c0457da0> arp_process.t ] 
arp_process+0x0/0x570
Sep  7 12:57:41 router.mikesnet.ro kernel:  [<c03f906b>] 
netif_receive_skb+0x2db/0x360
Sep  7 12:57:41 router.mikesnet.ro kernel:  [<e090a1f0>] 
e100_poll+0x420/0x780 [e100]
Sep  7 12:57:41 router.mikesnet.ro kernel:  [<c03fe03a>] 
neigh_periodic_timer+0xea/0x1c0
Sep  7 12:57:41 router.mikesnet.ro kernel:  [<c03f931f>] 
net_rx_action+0x12f/0x1c0
Sep  7 12:57:41 router.mikesnet.ro kernel:  [<c0127621>] 
__do_softirq+0x41/0xa0
Sep  7 12:57:41 router.mikesnet.ro kernel:  [<c01276a6>] 
do_softirq+0x26/0x30
Sep  7 12:57:42 router.mikesnet.ro kernel:  [<c0127765>] irq_exit+0x35/0x40
Sep  7 12:57:42 router.mikesnet.ro kernel:  [<c010580e>] do_IRQ+0x1e/0x30
Sep  7 12:57:42 router.mikesnet.ro kernel:  [<c0103c1a>] 
common_interrupt+0x1a/0x20
Sep  7 12:57:42 router.mikesnet.ro kernel:  [<c030cc55>] 
acpi_processor_idle+0xff/0x27f
Sep  7 12:57:42 router.mikesnet.ro kernel:  [<c01010e2>] cpu_idle+0x42/0x60
Sep  7 12:57:42 router.mikesnet.ro kernel:  [<c060e87d>] 
start_kernel+0x18d/0x1d0
Sep  7 12:57:42 router.mikesnet.ro kernel:   [<c060e3b0> 
unknown_bootoption.t ] unknown_bootoption+0x0/0x1f0
...
and this part is repeatting over and over again. What could be the problem?

[6.] A small shell script or example program which triggers the
     problem (if possible)
//-- zebra.conf [part]
ip route 0.0.0.0/0 85.186.56.129
ip route 0.0.0.0/0 194.105.21.65
ip route 0.0.0.0/0 212.146.86.161
//-- END

[7.] Environment
declare -x EDITOR="nano"
declare -x HOME="/root"
declare -x INPUTRC="/etc/inputrc"
declare -x LOGNAME="root"
declare -x 
LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:"
declare -x OLDPWD="/root"
declare -x 
PATH="/opt/gcc/current/bin:/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin:/usr/games:/usr/local/games:/usr/bin/X11:/root/bin:.:/usr/busybox"
declare -x 
PS1="\\[\\033[0m\\][\\[\\033[0;32m\\]\\u@\\[\\033[1;32m\\]\\H\\[\\033[0m\\]][\\[\\033[0;33m\\]\\w\\[\\033[0m\\]]# 
"
declare -x PWD="/etc/quagga"
declare -x SHELL="/bin/bash"
declare -x SHLVL="1"
declare -x TERM="xterm"
declare -x USER="root"

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux router.mikesnet.ro 2.6.13 #1 Sun Sep 4 03:34:46 EEST 2005 i686 
unknown unknown GNU/Linux
 
Gnu C                  3.4.4
Gnu make               3.80
binutils               2.15
util-linux             2.12q
mount                  2.12q
module-init-tools      3.1
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           line
xfsprogs               2.6.36
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   068
Modules Loaded         ohci_hcd ehci_hcd e100 i2c_piix4 i2c_core 
uhci_hcd usbcore

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.332
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1103.55

[7.3.] Module information (from /proc/modules):
dummy 2308 0 - Live 0xe0934000
ohci_hcd 33796 0 - Live 0xe094e000
ehci_hcd 44552 0 - Live 0xe0942000
e100 35712 0 - Live 0xe0907000
i2c_piix4 7824 0 - Live 0xe08f1000
i2c_core 17552 1 i2c_piix4, Live 0xe0901000
uhci_hcd 32524 0 - Live 0xe08f8000
usbcore 120060 4 ohci_hcd,ehci_hcd,uhci_hcd, Live 0xe0911000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0778-077a : parport0
0cf8-0cff : PCI conf1
a000-a03f : 0000:00:0d.0
  a000-a03f : e100
a400-a43f : 0000:00:0b.0
  a400-a43f : e100
a800-a83f : 0000:00:0a.0
  a800-a83f : e100
b000-b03f : 0000:00:09.0
  b000-b03f : e100
b400-b41f : 0000:00:04.2
  b400-b41f : uhci_hcd
b800-b80f : 0000:00:04.1
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : 0000:01:00.0
e400-e43f : 0000:00:04.3
  e400-e43f : motherboard
    e400-e403 : PM1a_EVT_BLK
    e404-e405 : PM1a_CNT_BLK
    e408-e40b : PM_TMR
    e40c-e40f : GPE0_BLK
    e410-e415 : ACPI CPU throttle
e800-e81f : 0000:00:04.3
  e800-e80f : motherboard
    e800-e80f : pnp 00:02
      e800-e807 : piix4-smbus

# cat /proc/iomem  
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Adapter ROM
000cc000-000ccfff : Adapter ROM
000d0000-000d0fff : Adapter ROM
000d4000-000d57ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-004a9e9a : Kernel code
  004a9e9b-0060a4a7 : Kernel data
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
20000000-200fffff : 0000:00:09.0
20100000-201fffff : 0000:00:0a.0
20200000-202fffff : 0000:00:0b.0
20300000-203fffff : 0000:00:0d.0
de000000-de0fffff : 0000:00:0d.0
  de000000-de0fffff : e100
de800000-de800fff : 0000:00:0d.0
  de800000-de800fff : e100
df000000-df0fffff : 0000:00:0b.0
  df000000-df0fffff : e100
df800000-df800fff : 0000:00:0b.0
  df800000-df800fff : e100
e0000000-e00fffff : 0000:00:0a.0
  e0000000-e00fffff : e100
e0800000-e0800fff : 0000:00:0a.0
  e0800000-e0800fff : e100
e1000000-e10fffff : 0000:00:09.0
  e1000000-e10fffff : e100
e1800000-e1800fff : 0000:00:09.0
  e1800000-e1800fff : e100
e2000000-e2afffff : PCI Bus #01
  e2000000-e2000fff : 0000:01:00.0
e2f00000-e3ffffff : PCI Bus #01
  e2f00000-e2f1ffff : 0000:01:00.0
  e3000000-e3ffffff : 0000:01:00.0
e4000000-e7ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 8024
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e2000000-e2afffff
        Prefetchable memory behind bridge: e2f00000-e3ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at b800 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 5
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at b400 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
        Subsystem: IBM 10/100 EtherJet Adapter with Alert on LAN
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e1800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at b000 [size=64]
        Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at 20000000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at e0800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at a800 [size=64]
        Region 2: Memory at e0000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at 20100000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at df800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at a400 [size=64]
        Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at 20200000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter 
with Alert On LAN*
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at de800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at a000 [size=64]
        Region 2: Memory at de000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at 20300000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP 
(rev 7a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e3000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at e2000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at e2f00000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
please ask anything that you think it will be usefull, and I will 
gladlly provide it to you.

Thank you,

-- 
Deac Mihai-Adrian
MiKe software&network SRL
Deva, B-dul DECEBAL, bl C, sc C, ap 83, jud Hunedoara
tel: +40-745-256364, fax: +40-354-401232
e-mail: ady@mikesnet.ro


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVAHO3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVAHO3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 09:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVAHO3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 09:29:50 -0500
Received: from wasp.net.au ([203.190.192.17]:31622 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261179AbVAHO1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 09:27:43 -0500
Message-ID: <41DFEDA8.7030805@wasp.net.au>
Date: Sat, 08 Jan 2005 18:26:48 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_wasp.net.au-2956-1105194459-0001-2"
To: lkml <linux-kernel@vger.kernel.org>
Subject: kernel BUG at net/ipv4/tcpoutput.c:922 2.6.10-bk7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_wasp.net.au-2956-1105194459-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Warning
This oops is hand transcribed

This machine is set up for a serial console, but of course one is never there when you actually need 
it. It would be handy to perhaps loop the oops once every 60 seconds or so, then you could always 
connect up a serial console when you get home and capture it.
There was no I  connected at oops time, so no magic-sysrq would work.
Any interest in such a thing? Perhaps I could have a go at knocking something up.

Regards,
Brad

[1.] One line summary of the problem:

Machine oopsed.

[2.] Full description of the problem/report:

Machine was under light load, a couple of p2 clients running only.
Ports eth0 and eth1 would have been practically unused (they use the sk98lin driver)
eth2 would have been under traffic of a 512/128 ADSL at full noise. 8139too driver.

[3.] Keywords (i.e., modules, networking, kernel):

networking.

[4.] Kernel version (from /proc/version):

Linux version 2.6.10 (brad@srv) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #3 Wed Jan 5 21:14:04 GST 2005

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

invalid operand: 0000 [#1]
Modules linked in: ehci_hcd uhci_hcd usbcore 8139too mii it87 i2c_sensor i2c_isa ohci1394 ieee1394 
sk98lin
CPU:	0
EIP:	0060:[<c02fdab9>]	Not tainted VLI
EFLAGS:	00010202	(2.6.10)
EIP is at tcp_retrans_try_collapse+0x339/0x350
eax:  db392440	ebx:  f52257e0	ecx:  00000000	edx:  000005b4
esi:  fffffff5	edi:  dd1c71d0  ebp:  f63d7240  esp:  c0467ea4
Process swapper (pic:  0, threadinfo=c0466000 task=c03abb20)
Stack:  f7ab8800 c2c2c100 c02e9ccd 00000394 00000218 00107000 00000218 dd1c71d0
	dd1c7000 dd1c71d0 fffffff5 f52257e0 dd1c7000 c02fdf0f dd1c7000 f52257e0
	000005b4 c02f6056 000005b4 dd1c7000 dd1c71d0 dd1c7054 c0467f64 c02ffbfb
Call Trace:
  [<c02e9ccd>]  ip_rcv+0x2dd.0x410
  [<c02fdf0f>]  tcp_retransmit_skb+0x2af/0x320
  [<c02f6056>]  tcp_enter_loss+0x66/0x230
  [<c02ffbfb>]  tcp_retransmit_timer+0xdb/0x3f0
  [<c011dc96>]  update_process_times+0x46/0x60
  [<c02fffab>]  tcp_write_timer+0x0/0xe0
  [<c0106fbe>]  timer_interrupt+0x4e/0x100
  [<c02fff10>]  tcp_write_timer+0x0/0xe0
  [<c011dd80>]  run_timer_softirq+0xb0/0x170
  [<c0119ffd>]  __do_softirq+0x7d/0x90
  [<c011a036>]  do_softirq+0x26/0x30
  [<c01048de>]  do_IRQ+0x1e/0x30
  [<c0102f72>]  common_interrupt+0x1a/0x20
  [<c0100613>]  default_idle+0x23/0x30
  [<c0100698>]  cpu_idle+0x48/0x60
  [<c0468791>]  start_kernel+0x141/0x160
  [<c0468380>]  unknown_bootoption+0x0/0x1b0
Code: e9 55 fe ff ff c7 44 24 08 9b da 2f c0 89 54 54 04 89 1c 24 e8 19 48 fd ff e9 0c fe ff ff 0f 
0b cb 02 59 2e 37 c0 e9 de fd ff ff <0f> 0b 9a 03 ff 2b 39 c0 e9 96 fd ff ff 31 c0 e9 5b fd ff ff 8d


[6.] A small shell script or example program which triggers the
      problem (if possible)

Unreproducible easily. Took 3 days to manifest.

[7.] Environment

About 22 Degrees C and 45% RH

BASH=/bin/bash
BASH_VERSINFO=([0]="2" [1]="05b" [2]="0" [3]="1" [4]="release" [5]="i386-pc-linux-gnu")
BASH_VERSION='2.05b.0(1)-release'
COLUMNS=221
CVS_RSH=ssh
DIRSTACK=()
DISPLAY=:0.0
EUID=1000
GNUSTEP_USER_ROOT=/home/brad/GNUstep
GROUPS=()
HISTFILE=/home/brad/.bash_history
HISTFILESIZE=500
HISTSIZE=500
HOME=/home/brad
HOSTNAME=bklaptop
HOSTTYPE=i386
HUSHLOGIN=FALSE
HZ=100
IFS=$' \t\n'
LINES=78
LOGNAME=brad
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;35:*.avi=01;35:*.gl=01;35:*.dl=01;35:'
LS_OPTIONS=--color=auto
MACHTYPE=i386-pc-linux-gnu
MAIL=/var/mail/brad
MAILCHECK=60
OLDPWD=/home/brad
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PATH=/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games:/usr/sbin:/sbin:/usr/local/sbin:.:/usr/local/programs:/usr/local/bin
PIPESTATUS=([0]="0")
PPID=28540
PS1='\h:\w>'
PS2='> '
PS4='+ '
PWD=/usr/src/linux
SHELL=/bin/bash
SHELLOPTS=braceexpand:emacs:hashall:histexpand:history:interactive-comments:monitor
SHLVL=4
TERM=xterm
UID=1000
USER=brad
WINDOWID=23068686
WMAKER_BIN_NAME=/usr/bin/WindowMaker
WRASTER_COLOR_RESOLUTION0=4
XAUTHORITY=/home/brad/.Xauthority
_=REPORTING-BUGS

[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux srv 2.6.10 #3 Wed Jan 5 21:14:04 GST 2005 i686 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre6
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         ehci_hcd uhci_hcd usbcore 8139too mii it87 i2c_sensor i2c_isa ohci1394 
ieee1394 sk98lin

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(TM) XP 2600+
stepping        : 0
cpu MHz         : 1916.506
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr 
sse pni syscall mmxext 3dnowext 3dnow
bogomips        : 3827.30

[7.3.] Module information (from /proc/modules):

ehci_hcd 39876 0 - Live 0xf890e000
uhci_hcd 30476 0 - Live 0xf8919000
usbcore 116408 3 ehci_hcd,uhci_hcd, Live 0xf898e000
8139too 20288 0 - Live 0xf88fc000
mii 3968 1 8139too, Live 0xf88e8000
it87 21284 0 - Live 0xf88ed000
i2c_sensor 2880 1 it87, Live 0xf888c000
i2c_isa 1664 0 - Live 0xf88b8000
ohci1394 30852 0 - Live 0xf88a7000
ieee1394 303220 1 ohci1394, Live 0xf8942000
sk98lin 165288 2 - Live 0xf88bb000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)


MemTotal:      1554536 kB
MemFree:       1422876 kB
Buffers:         46068 kB
Cached:          25960 kB
SwapCached:          0 kB
Active:          76580 kB
Inactive:        22204 kB
HighTotal:      655340 kB
HighFree:       600960 kB
LowTotal:       899196 kB
LowFree:        821916 kB
SwapTotal:      987988 kB
SwapFree:       987988 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          35596 kB
Slab:            13100 kB
CommitLimit:   1765256 kB
Committed_AS:    56476 kB
PageTables:        936 kB
VmallocTotal:   114680 kB
VmallocUsed:      1588 kB
VmallocChunk:   112968 kB

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
01f0-01f7 : ide0
0290-0297 :
02f8-02ff : serial
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
4000-407f : 0000:00:13.0
   4000-407f : sata_promise
4400-440f : 0000:00:13.0
   4400-440f : sata_promise
4800-483f : 0000:00:13.0
   4800-483f : sata_promise
5000-501f : 0000:00:10.3
   5000-501f : uhci_hcd
5400-541f : 0000:00:10.2
   5400-541f : uhci_hcd
5800-581f : 0000:00:10.1
   5800-581f : uhci_hcd
6000-601f : 0000:00:10.0
   6000-601f : uhci_hcd
6400-640f : 0000:00:0f.1
   6400-6407 : ide0
6800-68ff : 0000:00:0f.0
   6800-68ff : sata_via
7000-700f : 0000:00:0f.0
   7000-700f : sata_via
7400-7403 : 0000:00:0f.0
   7400-7403 : sata_via
7800-7807 : 0000:00:0f.0
   7800-7807 : sata_via
8000-8003 : 0000:00:0f.0
   8000-8003 : sata_via
8400-8407 : 0000:00:0f.0
   8400-8407 : sata_via
8800-887f : 0000:00:0e.0
   8800-887f : sata_promise
9000-900f : 0000:00:0e.0
   9000-900f : sata_promise
9400-943f : 0000:00:0e.0
   9400-943f : sata_promise
9800-98ff : 0000:00:0d.0
   9800-98ff : SysKonnect SK-98xx
a000-a07f : 0000:00:0c.0
a400-a47f : 0000:00:0b.0
   a400-a47f : sata_promise
a800-a80f : 0000:00:0b.0
   a800-a80f : sata_promise
b000-b03f : 0000:00:0b.0
   b000-b03f : sata_promise
b400-b4ff : 0000:00:0a.0
   b400-b4ff : 8139too
b800-b8ff : 0000:00:09.0
   b800-b8ff : SysKonnect SK-98xx
d000-dfff : PCI Bus #01
   d800-d87f : 0000:01:00.0
e400-e47f : motherboard
   e400-e403 : PM1a_EVT_BLK
   e404-e405 : PM1a_CNT_BLK
   e408-e40b : PM_TMR
   e420-e423 : GPE0_BLK
e800-e81f : motherboard

00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000d0000-000d33ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-5fffafff : System RAM
   00100000-0033abe9 : Kernel code
   0033abea-004652ff : Kernel data
5fffb000-5fffefff : ACPI Tables
5ffff000-5fffffff : ACPI Non-volatile Storage
d9800000-d981ffff : 0000:00:13.0
   d9800000-d981ffff : sata_promise
da000000-da000fff : 0000:00:13.0
   da000000-da000fff : sata_promise
da800000-da8000ff : 0000:00:10.4
   da800000-da8000ff : ehci_hcd
db000000-db01ffff : 0000:00:0e.0
   db000000-db01ffff : sata_promise
db800000-db800fff : 0000:00:0e.0
   db800000-db800fff : sata_promise
dc000000-dc003fff : 0000:00:0d.0
   dc000000-dc003fff : SysKonnect SK-98xx
dc800000-dc8007ff : 0000:00:0c.0
   dc800000-dc8007ff : ohci1394
dd000000-dd01ffff : 0000:00:0b.0
   dd000000-dd01ffff : sata_promise
dd800000-dd800fff : 0000:00:0b.0
   dd800000-dd800fff : sata_promise
de000000-de0000ff : 0000:00:0a.0
   de000000-de0000ff : 8139too
de800000-de803fff : 0000:00:09.0
   de800000-de803fff : SysKonnect SK-98xx
df000000-dfdfffff : PCI Bus #01
   df000000-df03ffff : 0000:01:00.0
dff00000-f7ffffff : PCI Bus #01
   e0000000-efffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
         Subsystem: Asustek Computer, Inc. A7V8X motherboard
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- 
<PERR-
         Latency: 0
         Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [80] AGP version 3.5
                 Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- 
Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- 
<PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: df000000-dfdfffff
         Prefetchable memory behind bridge: dff00000-f7ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (5750ns min, 7750ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at de800000 (32-bit, non-prefetchable) [size=16K]
         Region 1: I/O ports at b800 [size=256]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data

0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 16
         Region 0: I/O ports at b400 [size=256]
         Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 0x90 (576 bytes)
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at b000 [size=64]
         Region 1: I/O ports at a800 [size=16]
         Region 2: I/O ports at a400 [size=128]
         Region 3: Memory at dd800000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at dd000000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) 
(prog-if 10 [OHCI])
         Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (8000ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 19
         Region 0: Memory at dc800000 (32-bit, non-prefetchable) [size=2K]
         Region 1: I/O ports at a000 [size=128]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0d.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 
10/100/1000Base-T Adapter (rev 12)
         Subsystem: Standard Microsystems Corp [SMC]: Unknown device b452
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (5750ns min, 7750ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16K]
         Region 1: I/O ports at 9800 [size=256]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data

0000:00:0e.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 0x90 (576 bytes)
         Interrupt: pin A routed to IRQ 17
         Region 0: I/O ports at 9400 [size=64]
         Region 1: I/O ports at 9000 [size=16]
         Region 2: I/O ports at 8800 [size=128]
         Region 3: Memory at db800000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at db000000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32
         Interrupt: pin B routed to IRQ 20
         Region 0: I/O ports at 8400 [size=8]
         Region 1: I/O ports at 8000 [size=4]
         Region 2: I/O ports at 7800 [size=8]
         Region 3: I/O ports at 7400 [size=4]
         Region 4: I/O ports at 7000 [size=16]
         Region 5: I/O ports at 6800 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 20
         Region 4: I/O ports at 6400 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 21
         Region 4: I/O ports at 6000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 21
         Region 4: I/O ports at 5800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin B routed to IRQ 21
         Region 4: I/O ports at 5400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin B routed to IRQ 21
         Region 4: I/O ports at 5000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32, Cache Line Size: 0x10 (64 bytes)
         Interrupt: pin C routed to IRQ 21
         Region 0: Memory at da800000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:13.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at 4800 [size=64]
         Region 1: I/O ports at 4400 [size=16]
         Region 2: I/O ports at 4000 [size=128]
         Region 3: Memory at da000000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at d9800000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 315PRO PCI/AGP VGA Display 
Adapter (prog-if 00 [VGA])
         Subsystem: Silicon Integrated Systems [SiS] 315PRO PCI/AGP VGA Display Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 71 (750ns min, 4000ns max)
         BIST result: 00
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=256K]
         Region 2: I/O ports at d800 [size=128]
         Expansion ROM at dfff0000 [disabled] [size=64K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] AGP version 2.0
                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- 
Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi7 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi8 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi9 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi10 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi11 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi13 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD2500BB-00D Rev: 15.0
   Type:   Direct-Access                    ANSI SCSI revision: 05



--=_wasp.net.au-2956-1105194459-0001-2
Content-Type: text/plain; name=config; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_PROMISE=y
CONFIG_SCSI_SATA_VIA=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID5=y
CONFIG_MD_RAID6=y
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_TCPDIAG=y
CONFIG_BRIDGE=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_NET_PCI=y
CONFIG_8139TOO=m
CONFIG_SK98LIN=m
CONFIG_TIGON3=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_RTC=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ISA=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_IT87=m
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_DNOTIFY=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_DES=y
CONFIG_CRC32=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--=_wasp.net.au-2956-1105194459-0001-2--

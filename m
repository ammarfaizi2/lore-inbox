Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbUEKLca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUEKLca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 07:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUEKLca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 07:32:30 -0400
Received: from weird-brew.cisco.com ([144.254.15.118]:4008 "EHLO
	strange-brew.cisco.com") by vger.kernel.org with ESMTP
	id S262910AbUEKLbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 07:31:44 -0400
Subject: PROBLEM: Kernel crash in apparent race conditions
From: Frederic Detienne <fd@cisco.com>
Reply-To: fd@cisco.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-EoKNQ2w+MPoOzWv7iy+d"
Organization: Cisco Systems
Message-Id: <1084275056.21472.4.camel@metal.cisco.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 May 2004 13:30:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EoKNQ2w+MPoOzWv7iy+d
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I just experienced a severe crash on my SMP system. Here are the logs; I
hope they are useful. Feel free to ask questions; I can even give remote
access if needed.

thank you and best regards,

	frederic

[1.] One line summary of the problem:    

Kernel crashed unexpectedly on apparent race conditions after
random user action

[2.] Full description of the problem/report:

The kernel crashed completely after a sequence of Oopses.

I was busy misconfiguring my Gnome configs when the following happened:
1) gpilotd (using the visor USB module) ate 100% CPU and a lot of memory
2) I disconnected my Palm from the USB port and killed gpilotd
3) The system kept performing but Nautilus (file manager) had hanged
4) I killed Nautilus and the system went down at the same time
(notice famd is running so killing Nautilus may have cause
events sent to the kernel by famd).

Not sure this is related but this is what happened.

The kernel would not respond to anything:
1) keyboard/mouse not functional
2) I could ping the kernel from an other PC on the LAN but it stopped
responding after about 5-10 seconds.

There are multiple Oopses int the trace. the first ones are general
page allocation faults (could be due to gpilotd eating the memory)
but the last traces show race conditions. This is bad.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, scheduler

[4.] Kernel version (from /proc/version):

Linux version 2.6.6-rc3 (root@Metal) (gcc version 3.3.3 20040412 (Gentoo
Linux 3.3.3-r3, ssp-3.3-7, pie-8.5.3)) #4 SMP Mon May 10 15:48:53 CEST
2004

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

see attachment

[6.] A small shell script or example program which triggers the
     problem (if possible)

first time ever.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.0
Modules Loaded         snd_usb_audio pwcx pwc visor


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 2
cpu MHz         : 451.177
cache size      : 512 KB
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
bogomips        : 888.83
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 2
cpu MHz         : 451.177
cache size      : 512 KB
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
bogomips        : 899.07


[7.3.] Module information (from /proc/modules):

snd_usb_audio 66464 0 - Live 0xe52b6000
pwcx 90752 0 - Live 0xe5288000
pwc 49072 1 pwcx, Live 0xe527b000
visor 15660 0 - Live 0xe5266000

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

/proc/ioport:
-------------
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
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
03c0-03df : vga+
  03c0-03df : matrox
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
b000-b0ff : 0000:00:0b.0
b400-b407 : 0000:00:0a.1
  b400-b407 : emu10k1-gp
b800-b81f : 0000:00:0a.0
  b800-b81f : EMU10K1
d000-d01f : 0000:00:09.0
  d000-d01f : e100
d400-d41f : 0000:00:04.2
  d400-d41f : uhci_hcd
d800-d80f : 0000:00:04.1
  d800-d807 : ide0
  d808-d80f : ide1
e400-e43f : 0000:00:04.3
e800-e81f : 0000:00:04.3

/proc/iomem:
------------

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffcfff : System RAM
  00100000-004c96e9 : Kernel code
  004c96ea-005ff23f : Kernel data
1fffd000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
da800000-da800fff : 0000:00:0b.0
  da800000-da800fff : aic7xxx
db000000-db0fffff : 0000:00:09.0
  db000000-db0fffff : e100
db800000-dcdfffff : PCI Bus #01
  db800000-dbffffff : 0000:01:00.0
  dc000000-dc003fff : 0000:01:00.0
    dc000000-dc003fff : matroxfb MMIO
dd000000-dd000fff : 0000:00:09.0
  dd000000-dd000fff : e100
ddf00000-dfffffff : PCI Bus #01
  de000000-dfffffff : 0000:01:00.0
    de000000-dfffffff : matroxfb FB
e0000000-e7ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
 
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: db800000-dcdfffff
        Prefetchable memory behind bridge: ddf00000-dfffffff
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
        Region 4: I/O ports at d800 [size=16]
 
00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d400 [size=32]
 
00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
 
00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 05)
        Subsystem: Intel Corp. EtherExpress PRO/100+
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dd000000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at d000 [size=32]
        Region 2: Memory at db000000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
        Subsystem: Creative Labs CT4760 SBLive!
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at b800 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at b400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0b.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160N Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: I/O ports at b000 [disabled] [size=256]
        Region 1: Memory at da800000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 Dual Head Max
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at dc000000 (32-bit, non-prefetchable)
[size=16K]
        Region 2: Memory at db800000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at ddff0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
 

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W124TS Rev: 1.05
  Type:   CD-ROM                           ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Nothing special.

[X.] Other notes, patches, fixes, workarounds:

Please note that the kernel is tainted due to the pwcx driver (Philips
toucam)
but the camera was not even plugged it at that time.


--=-EoKNQ2w+MPoOzWv7iy+d
Content-Disposition: attachment; filename=oopses
Content-Type: text/plain; name=oopses; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

May 11 12:40:55 metal kernel: Unable to handle kernel paging request at virtual address 31afbcf4
May 11 12:40:55 metal kernel:  printing eip:
May 11 12:40:55 metal kernel: c041b638
May 11 12:40:55 metal kernel: *pde = 00000000
May 11 12:40:55 metal kernel: Oops: 0000 [#1]
May 11 12:40:55 metal kernel: PREEMPT SMP
May 11 12:40:55 metal kernel: CPU:    1
May 11 12:40:55 metal kernel: EIP:    0060:[<c041b638>]    Tainted: PF
May 11 12:40:55 metal kernel: EFLAGS: 00010212   (2.6.6-rc3)
May 11 12:40:55 metal kernel: EIP is at sock_poll+0x18/0x40
May 11 12:40:55 metal kernel: eax: 00000000   ebx: 00000145   ecx: d33f2a00   edx: 31afbcec
May 11 12:40:55 metal kernel: esi: d8b6c930   edi: d33f2a00   ebp: 00000002   esp: d9b83f20
May 11 12:40:55 metal kernel: ds: 007b   es: 007b   ss: 0068
May 11 12:40:55 metal kernel: Process gnome-vfs-daemo (pid: 11739, threadinfo=d9b82000 task=dee608a0)
May 11 12:40:55 metal kernel: Stack: 00000000 d8b6c930 d33f2820 00000145 c0173185 d33f2a00 00000000 d8b6c918
May 11 12:40:55 metal kernel:        d9b83f64 d9b83f68 7fffffff c01731fa 00000009 d8b6c920 d9b83f64 d9b83f68
May 11 12:40:55 metal kernel:        d9b82000 00000000 00000000 00000000 d8b6c918 000001ff 0807f220 c01733c1
May 11 12:40:55 metal kernel: Call Trace:
May 11 12:40:55 metal kernel:  [<c0173185>] do_pollfd+0x95/0xa0
May 11 12:40:55 metal kernel:  [<c01731fa>] do_poll+0x6a/0xd0
May 11 12:40:55 metal kernel:  [<c01733c1>] sys_poll+0x161/0x240
May 11 12:40:55 metal kernel:  [<c01726c0>] __pollwait+0x0/0xd0
May 11 12:40:55 metal kernel:  [<c010625b>] syscall_call+0x7/0xb
May 11 12:40:55 metal kernel:
May 11 12:40:55 metal kernel: Code: 8b 5a 08 89 44 24 08 89 54 24 04 89 0c 24 ff 53 20 8b 5c 24
May 11 12:40:55 metal kernel:  <1>Unable to handle kernel paging request at virtual address 31afbd34
May 11 12:40:55 metal kernel:  printing eip:
May 11 12:40:55 metal kernel: c017b9c1
May 11 12:40:55 metal kernel: *pde = 00000000
May 11 12:40:55 metal kernel: Oops: 0000 [#2]
May 11 12:40:55 metal kernel: PREEMPT SMP
May 11 12:40:55 metal kernel: CPU:    0
May 11 12:40:55 metal kernel: EIP:    0060:[<c017b9c1>]    Tainted: PF
May 11 12:40:55 metal kernel: EFLAGS: 00010282   (2.6.6-rc3)
May 11 12:40:55 metal kernel: EIP is at dnotify_flush+0x21/0x110
May 11 12:40:55 metal kernel: eax: ccdddd00   ebx: d33f2a00   ecx: d33f2aa0   edx: 00000000
May 11 12:40:55 metal kernel: esi: 31afbd14   edi: dee51720   ebp: d33f2a00   esp: d184be64
May 11 12:40:55 metal kernel: ds: 007b   es: 007b   ss: 0068
May 11 12:40:55 metal kernel: Process gnome-vfs-daemo (pid: 11737, threadinfo=d184a000 task=df209890)
May 11 12:40:55 metal kernel: Stack: d33f2b40 deac24a0 d33f2a00 00000000 dee51720 00000001 c015d206 d33f2a00
May 11 12:40:55 metal kernel:        dee51720 0000001f 0000001b dee51720 c0124ba4 d33f2a00 dee51720 d184a000
May 11 12:40:55 metal kernel:        dee51720 df209890 d184a000 c0125998 df209890 0000002b 00000000 00000000
May 11 12:40:55 metal kernel: Call Trace:
May 11 12:40:55 metal kernel:  [<c015d206>] filp_close+0x46/0x90
May 11 12:40:55 metal kernel:  [<c0124ba4>] put_files_struct+0x64/0xd0
May 11 12:40:55 metal kernel:  [<c0125998>] do_exit+0x198/0x540
May 11 12:40:55 metal kernel:  [<c0125e12>] do_group_exit+0x42/0xe0
May 11 12:40:55 metal kernel:  [<c012f10f>] get_signal_to_deliver+0x2cf/0x3f0
May 11 12:40:55 metal kernel:  [<c0105fb3>] do_signal+0x93/0x120
May 11 12:40:55 metal kernel:  [<c01726b4>] poll_freewait+0x44/0x50
May 11 12:40:55 metal kernel:  [<c017346c>] sys_poll+0x20c/0x240
May 11 12:40:55 metal kernel:  [<c01726c0>] __pollwait+0x0/0xd0
May 11 12:40:55 metal kernel:  [<c0106077>] do_notify_resume+0x37/0x39
May 11 12:40:55 metal kernel:  [<c01062a6>] work_notifysig+0x13/0x15
May 11 12:40:55 metal kernel:
May 11 12:40:55 metal kernel: Code: 0f b7 46 20 25 00 f0 00 00 3d 00 40 00 00 74 14 8b 5c 24 08
May 11 12:41:34 metal kernel:  <1>Unable to handle kernel paging request at virtual address 0ce5f988
May 11 12:41:34 metal kernel:  printing eip:
May 11 12:41:34 metal kernel: c011d5cc
May 11 12:41:34 metal kernel: *pde = 00000000
May 11 12:41:34 metal kernel: Oops: 0000 [#3]
May 11 12:41:34 metal kernel: PREEMPT SMP
May 11 12:41:34 metal kernel: CPU:    1
May 11 12:41:34 metal kernel: EIP:    0060:[<c011d5cc>]    Tainted: PF
May 11 12:41:34 metal kernel: EFLAGS: 00010086   (2.6.6-rc3)
May 11 12:41:34 metal kernel: EIP is at try_to_wake_up+0x2c/0x280
May 11 12:41:34 metal kernel: eax: 53206e61   ebx: c063fc80   ecx: 00000001   edx: dee608a0
May 11 12:41:34 metal kernel: esi: da14c000   edi: c063fc80   ebp: da14dd30   esp: da14dd0c
May 11 12:41:34 metal kernel: ds: 007b   es: 007b   ss: 0068
May 11 12:41:34 metal kernel: Process bonobo-activati (pid: 8104, threadinfo=da14c000 task=dede5970)
May 11 12:41:34 metal kernel: Stack: 00000246 607ee7b1 00002935 c0142d26 00000000 00000096 00000000 ca1751dc
May 11 12:41:34 metal kernel:        00000001 da14dd54 c011ecba dee608a0 00000001 00000000 ca1751dc da14c000
May 11 12:41:34 metal kernel:        ca1751d8 00000296 da14dd78 c011ed2d ca1751d8 00000001 00000001 00000000
May 11 12:41:34 metal kernel: Call Trace:
May 11 12:41:34 metal kernel:  [<c0142d26>] buffered_rmqueue+0x116/0x230
May 11 12:41:34 metal kernel:  [<c011ecba>] __wake_up_common+0x3a/0x70
May 11 12:41:34 metal kernel:  [<c011ed2d>] __wake_up+0x3d/0x70
May 11 12:41:34 metal kernel:  [<c041e4a1>] sock_def_readable+0xb1/0xc0
May 11 12:41:34 metal kernel:  [<c049b25b>] unix_stream_sendmsg+0x2db/0x470
May 11 12:41:34 metal kernel:  [<c041ad68>] sock_sendmsg+0x98/0xd0
May 11 12:41:34 metal kernel:  [<c041ed4f>] __kfree_skb+0x8f/0x120
May 11 12:41:34 metal kernel:  [<c041af18>] sock_aio_read+0xb8/0xd0
May 11 12:41:34 metal kernel:  [<c041b105>] sock_readv_writev+0x75/0xb0
May 11 12:41:34 metal kernel:  [<c041b1ef>] sock_writev+0x4f/0x60
May 11 12:41:34 metal kernel:  [<c015e24c>] do_readv_writev+0x22c/0x280
May 11 12:41:34 metal kernel:  [<c011e65f>] scheduler_tick+0x3f/0x640
May 11 12:41:34 metal kernel:  [<c015e368>] vfs_writev+0x58/0x70
May 11 12:41:34 metal kernel:  [<c015e432>] sys_writev+0x42/0x70
May 11 12:41:34 metal kernel:  [<c010625b>] syscall_call+0x7/0xb
May 11 12:41:34 metal kernel:
May 11 12:41:34 metal kernel: Code: 8b 0c 85 04 40 64 c0 ff 46 14 01 cf 31 c0 86 07 84 c0 0f 8e
May 11 12:41:34 metal kernel:  <6>note: bonobo-activati[8104] exited with preempt_count 2
May 11 12:41:34 metal kernel: Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
May 11 12:41:34 metal kernel: in_atomic():1, irqs_disabled():0
May 11 12:41:34 metal kernel: Call Trace:
May 11 12:41:34 metal kernel:  [<c0120607>] __might_sleep+0xb7/0xe0
May 11 12:41:34 metal kernel:  [<c01258b2>] do_exit+0xb2/0x540
May 11 12:41:34 metal kernel:  [<c011c160>] do_page_fault+0x0/0x553
May 11 12:41:34 metal kernel:  [<c0107399>] die+0x119/0x120
May 11 12:41:34 metal kernel:  [<c011c33e>] do_page_fault+0x1de/0x553
May 11 12:41:34 metal kernel:  [<c0160d53>] __find_get_block+0x73/0x100
May 11 12:41:34 metal kernel:  [<c0160e17>] __getblk+0x37/0x70
May 11 12:41:34 metal kernel:  [<c019f16e>] ext3_getblk+0xae/0x2a0
May 11 12:41:34 metal kernel:  [<c011c160>] do_page_fault+0x0/0x553
May 11 12:41:34 metal kernel:  [<c0106cc5>] error_code+0x2d/0x38
May 11 12:41:34 metal kernel:  [<c011d5cc>] try_to_wake_up+0x2c/0x280
May 11 12:41:34 metal kernel:  [<c0142d26>] buffered_rmqueue+0x116/0x230
May 11 12:41:34 metal kernel:  [<c011ecba>] __wake_up_common+0x3a/0x70
May 11 12:41:34 metal kernel:  [<c011ed2d>] __wake_up+0x3d/0x70
May 11 12:41:34 metal kernel:  [<c041e4a1>] sock_def_readable+0xb1/0xc0
May 11 12:41:34 metal kernel:  [<c049b25b>] unix_stream_sendmsg+0x2db/0x470
May 11 12:41:34 metal kernel:  [<c041ad68>] sock_sendmsg+0x98/0xd0
May 11 12:41:34 metal kernel:  [<c041ed4f>] __kfree_skb+0x8f/0x120
May 11 12:41:34 metal kernel:  [<c041af18>] sock_aio_read+0xb8/0xd0
May 11 12:41:34 metal kernel:  [<c041b105>] sock_readv_writev+0x75/0xb0
May 11 12:41:34 metal kernel:  [<c041b1ef>] sock_writev+0x4f/0x60
May 11 12:41:34 metal kernel:  [<c015e24c>] do_readv_writev+0x22c/0x280
May 11 12:41:34 metal kernel:  [<c011e65f>] scheduler_tick+0x3f/0x640
May 11 12:41:34 metal kernel:  [<c015e368>] vfs_writev+0x58/0x70
May 11 12:41:34 metal kernel:  [<c015e432>] sys_writev+0x42/0x70
May 11 12:41:34 metal kernel:  [<c010625b>] syscall_call+0x7/0xb
May 11 12:41:34 metal kernel:
May 11 12:41:34 metal kernel: bad: scheduling while atomic!
May 11 12:41:34 metal kernel: Call Trace:
May 11 12:41:34 metal kernel:  [<c04c74ef>] schedule+0x6ff/0x710
May 11 12:41:34 metal kernel:  [<c015913f>] swap_free+0x2f/0x50
May 11 12:41:34 metal kernel:  [<c0159335>] remove_exclusive_swap_page+0xa5/0x160
May 11 12:41:34 metal kernel:  [<c01589a1>] free_pages_and_swap_cache+0x71/0xa0
May 11 12:41:34 metal kernel:  [<c014d2d3>] unmap_vmas+0x1f3/0x250
May 11 12:41:34 metal kernel:  [<c01518ef>] exit_mmap+0xef/0x240
May 11 12:41:34 metal kernel:  [<c0120f5c>] mmput+0x6c/0xa0
May 11 12:41:34 metal kernel:  [<c0125948>] do_exit+0x148/0x540
May 11 12:41:34 metal kernel:  [<c011c160>] do_page_fault+0x0/0x553
May 11 12:41:34 metal kernel:  [<c0107399>] die+0x119/0x120
May 11 12:41:34 metal kernel:  [<c011c33e>] do_page_fault+0x1de/0x553
May 11 12:41:34 metal kernel:  [<c0160d53>] __find_get_block+0x73/0x100
May 11 12:41:34 metal kernel:  [<c0160e17>] __getblk+0x37/0x70
May 11 12:41:34 metal kernel:  [<c019f16e>] ext3_getblk+0xae/0x2a0
May 11 12:41:34 metal kernel:  [<c011c160>] do_page_fault+0x0/0x553
May 11 12:41:34 metal kernel:  [<c0106cc5>] error_code+0x2d/0x38
May 11 12:41:34 metal kernel:  [<c011d5cc>] try_to_wake_up+0x2c/0x280
May 11 12:41:34 metal kernel:  [<c0142d26>] buffered_rmqueue+0x116/0x230
May 11 12:41:34 metal kernel:  [<c011ecba>] __wake_up_common+0x3a/0x70
May 11 12:41:34 metal kernel:  [<c011ed2d>] __wake_up+0x3d/0x70
May 11 12:41:34 metal kernel:  [<c041e4a1>] sock_def_readable+0xb1/0xc0
May 11 12:41:34 metal kernel:  [<c049b25b>] unix_stream_sendmsg+0x2db/0x470
May 11 12:41:34 metal kernel:  [<c041ad68>] sock_sendmsg+0x98/0xd0
May 11 12:41:34 metal kernel:  [<c041ed4f>] __kfree_skb+0x8f/0x120
May 11 12:41:34 metal kernel:  [<c041af18>] sock_aio_read+0xb8/0xd0
May 11 12:41:34 metal kernel:  [<c041b105>] sock_readv_writev+0x75/0xb0
May 11 12:41:34 metal kernel:  [<c041b1ef>] sock_writev+0x4f/0x60
May 11 12:41:34 metal kernel:  [<c015e24c>] do_readv_writev+0x22c/0x280
May 11 12:41:34 metal kernel:  [<c011e65f>] scheduler_tick+0x3f/0x640
May 11 12:41:34 metal kernel:  [<c015e368>] vfs_writev+0x58/0x70
May 11 12:41:34 metal kernel:  [<c015e432>] sys_writev+0x42/0x70
May 11 12:41:34 metal kernel:  [<c010625b>] syscall_call+0x7/0xb

<System rebooted (forced) here>

--=-EoKNQ2w+MPoOzWv7iy+d--


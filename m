Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUGIJ3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUGIJ3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUGIJ3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:29:16 -0400
Received: from mail.orange.sk ([213.151.200.4]:13448 "HELO mail.orangemail.sk")
	by vger.kernel.org with SMTP id S264585AbUGIJ2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:28:45 -0400
Subject: Removal of MCI Bluetooth USB dongle causes hci_hcd Ooop and
	unusability of part of USB bus...
From: Marian Stepka <mstepka@orangemail.sk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1089359901.3568.23.camel@imro.intranet.orange.sk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 09 Jul 2004 09:58:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. PROBEL SUMARY
----------------

Removal of MCI Bluetooth USB dongle causes hci_hcd Ooop and unusability
of part of USB bus...

2. PROBLEM DESCRIPTION
----------------------

I experienced problem with MCI Bluetooth pc2pc Transceiving key on HP
laptom compaq nc6000 using generic installation of Fedore Core 2. When I
plug in device it is recognized good and all BlueZ utilities working
with it without problem. Here is part of /var/log/messages after device
plug-in:

imro kernel: Bluetooth: HCI device and connection manager initialized
imro kernel: Bluetooth: HCI socket layer initialized
imro kernel: Bluetooth: HCI USB driver ver 2.5
imro kernel: usbcore: registered new driver hci_usb

After unplugging device I got Ooops. See down output of oops.


3. KEYWORDS
-----------

kernel 2.6, usb, blutooth, msi, dongle

4. KERNEL VERSION
-----------------

Linux version 2.6.5-1.358 (bhcompile@bugs.build.redhat.com) (gcc version
3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Sat May 8 09:04:50 EDT 2004

5. OOPS OUTPUT
--------------

Unable to handle kernel NULL pointer dereference at virtual address
00000068
imro kernel:  printing eip:
imro kernel: 0216b824
imro kernel: *pde = 00000000
imro kernel: Oops: 0002 [#1]
imro kernel: CPU:    0
imro kernel: EIP:    0060:[<0216b824>]    Not tainted
imro kernel: EFLAGS: 00010246   (2.6.5-1.358)
imro kernel: EIP is at sysfs_hash_and_remove+0x1f/0x6f
imro kernel: eax: 00000000   ebx: 00000068   ecx: 00000068   edx:
00000077
imro kernel: esi: 00000000   edi: 022a8be7   ebp: 1d883280   esp:
035c5ef4
imro kernel: ds: 007b   es: 007b   ss: 0068
imro kernel: Process khubd (pid: 5, threadinfo=035c5000 task=21f46030)
imro kernel: Stack: 22a15080 22a15020 13938930 0000000a 021d9ec0
13938800 13938800 15502a64
imro kernel:        22a0e674 15502254 22a203f1 15502a54 22a212a0
022117f5 15502a64 22a212c0
imro kernel:        021d9628 022e28a0 022e28ec 021d9728 15502a64
022daae8 20a388cc 021d8a96
imro kernel: Call Trace:
imro kernel:  [<021d9ec0>] class_device_del+0x81/0xa2
imro kernel:  [<22a0e674>] hci_unregister_dev+0x8/0x5b [bluetooth]
imro kernel:  [<22a203f1>] hci_usb_disconnect+0x30/0x53 [hci_usb]
imro kernel:  [<022117f5>] usb_unbind_interface+0x2c/0x50
imro kernel:  [<021d9628>] device_release_driver+0x3c/0x46
imro kernel:  [<021d9728>] bus_remove_device+0x47/0x80
imro kernel:  [<021d8a96>] device_del+0x66/0x87
imro kernel:  [<021d8abf>] device_unregister+0x8/0x10
imro kernel:  [<02215fe4>] usb_disable_device+0x62/0x8a
imro kernel:  [<0221212a>] usb_disconnect+0x9d/0xd2
imro kernel:  [<0221396f>] hub_port_connect_change+0x4b/0x210
imro kernel:  [<02213c0a>] hub_events+0xd6/0x296
imro kernel:  [<02213de8>] hub_thread+0x1e/0xd0
imro kernel:  [<02115e97>] default_wake_function+0x0/0xc
imro kernel:  [<02213dca>] hub_thread+0x0/0xd0
imro kernel:  [<021041d9>] kernel_thread_helper+0x5/0xb
imro kernel:
imro kernel: Code: ff 4e 68 78 4b 89 fa 89 e8 e8 80 ff ff ff 3d 18 fc ff
ff 89

6. PROBLEM REPLICATION
----------------------

Only what remains to me is have same device and try it plug-in and out.

7. ENVIRONMENT
--------------

HOSTNAME=imro.intranet.orange.sk
SHELL=/bin/bash
TERM=xterm
HISTSIZE=1000
PERL5LIB=/usr/lib/perl5/site_perl/5.8.3/i386-linux-thread-multi:/usr/lib/perl5/site_perl/5.8.3
QTDIR=/usr/lib/qt-3.3
USER=root
LS_COLORS=no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:
KDEDIR=/usr
USERNAME=root
MAIL=/var/spool/mail/root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:/root/bin
INPUTRC=/etc/inputrc
PWD=/root
LANG=en_US.UTF-8
SSH_ASKPASS=/usr/libexec/openssh/gnome-ssh-askpass
SHLVL=1
HOME=/root
BASH_ENV=/root/.bashrc
LOGNAME=root
LESSOPEN=|/usr/bin/lesspipe.sh %s
DISPLAY=:0.0
G_BROKEN_FILENAMES=1
XAUTHORITY=/root/.xauthv9tzum
_=/bin/env

8. SOFTWARE
-----------
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux imro.intranet.orange.sk 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004
i686 i686 i386 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12
mount                  2.12
module-init-tools      2.4.26
e2fsprogs              1.35
jfsutils               1.1.4
pcmcia-cs              3.2.7
quota-tools            3.10.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.0
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         hci_usb bluetooth snd_pcm_oss snd_mixer_oss
snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ds yenta_socket
pcmcia_core tg3 microcode sg sr_mod usb_storage scsi_mod joydev dm_mod
ehci_hcd uhci_hcd button battery asus_acpi ac ipv6 ext3 jbd

9. PROCESSOR
------------

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1500MHz
stepping        : 5
cpu MHz         : 598.153
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mtrr pge mca cmov pat
clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
bogomips        : 1186.20

10. MODULES
------------
hci_usb 9604 0 - Live 0x22a1f000
bluetooth 33636 1 hci_usb, Live 0x22a0d000
snd_pcm_oss 40740 0 - Live 0x22a56000
snd_mixer_oss 13824 1 snd_pcm_oss, Live 0x22a43000
snd_intel8x0 26280 1 - Live 0x22a17000
snd_ac97_codec 50436 1 snd_intel8x0, Live 0x22a35000
snd_pcm 68872 2 snd_pcm_oss,snd_intel8x0, Live 0x22a23000
snd_timer 17156 1 snd_pcm, Live 0x22a07000
snd_page_alloc 7940 2 snd_intel8x0,snd_pcm, Live 0x229ea000
gameport 3328 1 snd_intel8x0, Live 0x229f0000
snd_mpu401_uart 4864 1 snd_intel8x0, Live 0x229ed000
snd_rawmidi 17184 1 snd_mpu401_uart, Live 0x229dc000
snd_seq_device 6152 1 snd_rawmidi, Live 0x229e7000
snd 38372 11
snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0x229f5000
soundcore 6112 1 snd, Live 0x228bb000
ds 12292 6 - Live 0x229e2000
yenta_socket 15104 0 - Live 0x228c1000
pcmcia_core 46792 2 ds,yenta_socket, Live 0x2293b000
tg3 62596 0 - Live 0x229c9000
microcode 4768 0 - Live 0x228be000
sg 27552 0 - Live 0x22884000
sr_mod 13348 0 - Live 0x22894000
usb_storage 55392 1 - Live 0x2292c000
scsi_mod 91344 3 sg,sr_mod,usb_storage, Live 0x228d0000
joydev 6976 0 - Live 0x2286d000
dm_mod 33184 0 - Live 0x228c6000
ehci_hcd 21896 0 - Live 0x228b4000
uhci_hcd 23708 0 - Live 0x2288d000
button 4504 0 - Live 0x2287b000
battery 6924 0 - Live 0x22868000
asus_acpi 8472 0 - Live 0x22880000
ac 3340 0 - Live 0x2286b000
ipv6 184288 6 - Live 0x228ea000
ext3 102376 2 - Live 0x2289a000
jbd 40216 1 ext3, Live 0x22870000

11. LOADED DRIVERS
------------------
[root@imro scripts]# cat /proc/ioports
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
0376-0376 : ide1
03c0-03df : vga+
03e8-03ef : serial
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
1100-113f : 0000:00:1f.0
2000-2fff : PCI Bus #01
  2000-20ff : 0000:01:00.0
3000-30ff : 0000:00:1f.5
3400-34ff : 0000:00:1f.6
3800-387f : 0000:00:1f.6
3880-38bf : 0000:00:1f.5
38c0-38df : 0000:00:1d.0
  38c0-38df : uhci_hcd
38e0-38ff : 0000:00:1d.1
  38e0-38ff : uhci_hcd
3c00-3c1f : 0000:00:1d.2
  3c00-3c1f : uhci_hcd
3c20-3c2f : 0000:00:1f.1
  3c20-3c27 : ide0
  3c28-3c2f : ide1
4000-40ff : PCI CardBus #03
4400-44ff : PCI CardBus #03
4800-48ff : PCI CardBus #07
4c00-4cff : PCI CardBus #07
5000-50ff : PCI CardBus #0b
5400-54ff : PCI CardBus #0b

[root@imro scripts]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffcffff : System RAM
  00100000-00280fff : Kernel code
  00281000-00316bff : Kernel data
1ffd0000-1fff0bff : reserved
1fff0c00-1fffbfff : ACPI Non-volatile Storage
1fffc000-1fffffff : reserved
20000000-200003ff : 0000:00:1f.1
20400000-207fffff : PCI CardBus #03
20800000-20bfffff : PCI CardBus #03
20c00000-20ffffff : PCI CardBus #07
21000000-213fffff : PCI CardBus #07
21400000-217fffff : PCI CardBus #0b
21800000-21bfffff : PCI CardBus #0b
90000000-9000ffff : 0000:02:0e.0
  90000000-9000ffff : tg3
90080000-90080fff : 0000:02:04.0
90100000-90100fff : 0000:02:06.0
  90100000-90100fff : yenta_socket
90180000-90180fff : 0000:02:06.1
  90180000-90180fff : yenta_socket
90200000-90200fff : 0000:02:06.2
90280000-90280fff : 0000:02:06.3
  90280000-90280fff : yenta_socket
90300000-903fffff : PCI Bus #01
  90300000-9030ffff : 0000:01:00.0
98000000-9fffffff : PCI Bus #01
  98000000-9fffffff : 0000:01:00.0
a0000000-a00003ff : 0000:00:1d.7
  a0000000-a00003ff : ehci_hcd
a0100000-a01001ff : 0000:00:1f.5
  a0100000-a01001ff : Intel 82801DB-ICH4 - AC'97
a0180000-a01800ff : 0000:00:1f.5
  a0180000-a01800ff : Intel 82801DB-ICH4 - Controller
b0000000-bfffffff : 0000:00:00.0

12. PCI INFORMATION
-------------------
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller
(rev 03)
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at b0000000 (32-bit, prefetchable)
        Capabilities: [e4] #09 [4104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW+
Rate=x1

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: 90300000-903fffff
        Prefetchable memory behind bridge: 98000000-9fffffff
        Expansion ROM at 00002000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 03)
(prog-if 00 [UHCI])
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at 38c0 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 03)
(prog-if 00 [UHCI])
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 38e0 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 03)
(prog-if 00 [UHCI])
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at 3c00 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
(rev 03) (prog-if 20 [EHCI])
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at a0000000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 90000000-902fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev
03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage
Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 3c20 [size=16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable)
[size=1K]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97
Audio Controller (rev 03)
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 3000
        Region 1: I/O ports at 3880 [size=64]
        Region 2: Memory at a0100000 (32-bit, non-prefetchable)
[size=512]
        Region 3: Memory at a0180000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev
03) (prog-if 00 [Generic])
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 3400
        Region 1: I/O ports at 3800 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility
Radeon 9600 M10] (prog-if 00 [VGA])
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 98000000 (32-bit, prefetchable)
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at 90300000 (32-bit, non-prefetchable)
[size=64K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini
PCI Adapter (rev 04)
        Subsystem: Intel Corp.: Unknown device 2522
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 8500ns max), Cache Line Size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 90080000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:06.0 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus
MultiMediaBay Controller
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 90100000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

02:06.1 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus
MultiMediaBay Controller
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 90180000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

02:06.2 System peripheral: O2 Micro, Inc. OZ711Mx MultiMediaBay
Accelerator
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 90200000 (32-bit, non-prefetchable)
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.3 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus
MultiMediaBay Controller
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 90280000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=0b, subordinate=0e, sec-latency=176
        Memory window 0: 21400000-217ff000 (prefetchable)
        Memory window 1: 21800000-21bff000
        I/O window 0: 00005000-000050ff
        I/O window 1: 00005400-000054ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

02:0e.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705M_2
Gigabit Ethernet (rev 03)
        Subsystem: Hewlett-Packard Company: Unknown device 0890
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), Cache Line Size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 90000000 (64-bit, non-prefetchable)
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
                Address: f7effefffdfffff8  Data: bfff

13. SCSI INFORMATION
--------------------

[root@imro scripts]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: DVD-ROM GDR8082N Rev: 0C11
  Type:   CD-ROM                           ANSI SCSI revision: 02

14. OTHER
---------

None yet.

Marian

-- 
* GEEK BY NATURE LINUX BY CHOICE *
Marian Stepka mailto:mstepka@orangemai.sk


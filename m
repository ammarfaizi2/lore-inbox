Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312737AbSDFTGm>; Sat, 6 Apr 2002 14:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312740AbSDFTGl>; Sat, 6 Apr 2002 14:06:41 -0500
Received: from dsl-64-192-112-201.telocity.com ([64.192.112.201]:1408 "EHLO
	herakleion.purplefrog.com") by vger.kernel.org with ESMTP
	id <S312737AbSDFTGi>; Sat, 6 Apr 2002 14:06:38 -0500
Subject: PROBLEM: my Aviator Webgear 2.4 doesn't work with kernel version 2.4.x
X-Mailer: Sylpheed version 0.7.4claws50 (GTK+ 1.2.10; i686-pc-linux-gnu)
Message-Id: <20020406140631.33856a8f.thoth@purplefrog.com>
From: Bob <thoth@purplefrog.com>
To: linux-kernel@vger.kernel.org
To: corey@world.std.com
Date: Sat, 6 Apr 2002 14:06:31 -0500
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think the raylink wireless modules doesn't work properly under
kernel 2.4.x.  I have tried my Aviator Webgear 2.4GHz WNA with 2.4.7
and 2.4.18 and it never joins the existing network.

  I have 4 of the cards.

A kernel 2.0.36 mini-tower (giza) with the ISA adapter works.  

A kernel 2.2.14 laptop (nile) with PCMCIA works and can talk to the 2.0.36 no
problem.

However, I also have two laptops running 2.4.18 (one Dell Inspiron
8100, and a NEC Versa M/100) and neither one can see giza or nile or
each other.




Here are some /var/log/messages from nile (a working host)

Apr  4 16:20:05 nile cardmgr[91]: initializing socket 1
Apr  4 16:20:05 nile cardmgr[91]: socket 1: RayLink PC Card WLAN Adapter
Apr  4 16:20:05 nile cardmgr[91]: executing: 'insmod /lib/modules/2.2.14/pcmcia/ray_cs.o essid=SCREWYSQUIRREL hop_dwell=128 beacon_period=256 translate=0'
Apr  4 16:20:05 nile cardmgr[91]: executing: './network start eth1'



Here are some /var/log/messages from giza (the other working host)

Jun 26 20:58:32 giza cardmgr[247]: initializing socket 0
Jun 26 20:58:32 giza cardmgr[247]: socket 0: RayLink PC Card WLAN Adapter
Jun 26 20:58:33 giza cardmgr[247]: executing: 'insmod /lib/modules/2.0.36/pcmcia
/ray_cs.o pc_debug=1 essid=SCREWYSQUIRREL hop_dwell=128 beacon_period=256 translate=0'
Jun 26 20:58:33 giza cardmgr[247]: executing: './network start eth1'
Jun 26 20:58:30 giza kernel:   Ricoh RF5C296/396 ISA-to-PCMCIA at port 0x3e0 ofs 0x00
Jun 26 20:58:30 giza kernel:     host opts [0]: none
Jun 26 20:58:30 giza kernel:     ISA irqs (scanned) = 3,4,5 polling interval = 1000 ms
Jun 26 20:58:32 giza kernel: cs: IO port probe 0x1000-0x17ff: excluding 0x1200-0x1207 0x1220-0x122f 0x1300-0x131f 0x1330-0x1337 0x1340-0x135f 0x1388-0x138f 0x16
00-0x1607 0x1620-0x162f 0x1700-0x171f 0x1730-0x1737 0x1740-0x175f 0x1788-0x178f
Jun 26 20:58:32 giza kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x220-0x22f 0x330-0x337 0x340-0x35f 0x378-0x37f 0x388-0x38f 0x4d0-0x4d7
Jun 26 20:58:32 giza kernel: cs: IO port probe 0x0a00-0x0aff: excluding 0xa00-0xa07 0xa20-0xa2f
Jun 26 20:58:32 giza kernel: cs: memory probe 0x0c0000-0x0cbfff: excluding 0xc0000-0xcbfff
Jun 26 20:58:32 giza kernel: cs: memory probe 0x0d0000-0x0dffff: excluding 0xd8000-0xdbfff
Jun 26 20:58:33 giza kernel: ray_cs Detected: WebGear PC Card WLAN Adapter Version 4.88 Jan 1999
Jun 26 20:58:33 giza kernel: eth1: RayLink, irq 5, hw_addr 00:00:8F:48:28:66
Jun 26 20:58:36 giza kernel: ray_cs interrupt network "SCREWYSQUIRREL" started



Here are some /var/log/messages from the 2.4.18 host (the non-working one)



Apr  6 13:43:00 herakleion cardmgr[1056]: initializing socket 0
Apr  6 13:43:00 herakleion cardmgr[1056]: socket 0: RayLink PC Card WLAN Adapter
Apr  6 13:43:00 herakleion kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Apr  6 13:43:00 herakleion cardmgr[1056]: executing: 'modprobe ray_cs essid=SCREWYSQUIRREL hop_dwell=128 beacon_period=256 translate=0 pc_debug=3'
Apr  6 13:43:00 herakleion kernel: Raylink/WebGear wireless LAN - Corey <Thomas corey@world.std.com>
Apr  6 13:43:00 herakleion kernel: raylink init_module register_pcmcia_driver returns 0x0
Apr  6 13:43:00 herakleion kernel: ray_attach()
Apr  6 13:43:00 herakleion kernel: ray_attach link = d4067bd0,  dev = d426fc00,  local = d3698c00, intr = daa71a70
Apr  6 13:43:00 herakleion kernel: ray_cs ray_attach calling ether_setup.)
Apr  6 13:43:00 herakleion kernel: ray_cs ray_attach calling CardServices(RegisterClient...)
Apr  6 13:43:00 herakleion kernel: ray_event(0x000004)
Apr  6 13:43:00 herakleion kernel: ray_config(0xd4067bd0)
Apr  6 13:43:00 herakleion kernel: ray_cs Detected: WebGear PC Card WLAN Adapter Version 5.63 May 1999
Apr  6 13:43:00 herakleion kernel: ray_init(0xd426fc00)
Apr  6 13:43:00 herakleion kernel: ray_init firmware version 5.63 
Apr  6 13:43:00 herakleion kernel: ray_init tib_length = 0x20
Apr  6 13:43:00 herakleion kernel: ray_init ending
Apr  6 13:43:00 herakleion kernel: ray_dev_init(dev=d426fc00)
Apr  6 13:43:00 herakleion kernel: dl_startup_params entered
Apr  6 13:43:00 herakleion cardmgr[1056]: executing: './network start eth1'
Apr  6 13:43:00 herakleion kernel: dl_startup_params start ccsindex = 14
Apr  6 13:43:00 herakleion kernel: interrupt_ecf(local=d3698c00, ccs = 0xe
Apr  6 13:43:00 herakleion kernel: ray_cs dl_startup_params started timer for verify_dl_startup
Apr  6 13:43:00 herakleion kernel: ray_dev_init ending
Apr  6 13:43:00 herakleion kernel: eth1: RayLink, irq 3, hw_addr 00:00:8F:48:E8:26
Apr  6 13:43:00 herakleion kernel: ray_cs ray_attach ending
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b01
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b0b
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b03
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b03
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b05
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b09
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b09
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b2b
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b2b
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b1b
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b15
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b1d
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b1d
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b21
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b23
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b25
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b07
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b2d
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b2d
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b27
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b27
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2fadf5c, cmd = 0x8b29
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b29
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2f99f5c, cmd = 0x8b06
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b06
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2f81f5c, cmd = 0x8b1c
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b1c
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2f81f5c, cmd = 0x8b20
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2f81f5c, cmd = 0x8b0d
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2f81f5c, cmd = 0x8be0
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d2f81f5c, cmd = 0x8b1a
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b1a
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b01
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b0b
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b03
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b03
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b05
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b09
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b09
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b2b
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b2b
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b1b
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b15
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b1d
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b1d
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b21
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b23
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b25
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b07
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b2d
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b2d
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b27
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b27
Apr  6 13:43:00 herakleion kernel: ray_cs IOCTL dev=d426fc00, ifr=d301ff5c, cmd = 0x8b29
Apr  6 13:43:00 herakleion kernel: ray_dev_ioctl cmd = 0x8b29
Apr  6 13:43:00 herakleion kernel: ray_open('eth1')
Apr  6 13:43:00 herakleion kernel: ray_open ending
Apr  6 13:43:00 herakleion kernel: ray_cs set_multicast_list(d426fc00)
Apr  6 13:43:00 herakleion kernel: ray_cs set_multicast_list(d426fc00)
Apr  6 13:43:00 herakleion kernel: interrupt_ecf(local=d3698c00, ccs = 0x0
Apr  6 13:43:00 herakleion kernel:   0  0 53 43 52 45 57 59 53 51 55 49 52 52 45 4c  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0 8f 48 e8 26 7f ff  0 80  1  0  1  7 a3 1d 82 4e 7f ff  4 e2 38 a4  5  8  2  8  0  c bd 32 ff ff  5 ff  1  b 4f  0 3f  0  f  4  8 28 28  7  0  2  2  0  0  0  2  0  0  0  0  0  0  0
Apr  6 13:43:00 herakleion kernel: interrupt_ecf(local=d3698c00, ccs = 0xe
Apr  6 13:43:01 herakleion kernel: ray_cs interrupt tx request failed
Apr  6 13:43:04 herakleion ntpd_initres[975]: couldn't resolve `ntp2.incanta.net', giving up on it
Apr  6 13:43:05 herakleion kernel: interrupt_ecf(local=d3698c00, ccs = 0x0
Apr  6 13:43:05 herakleion kernel: ray_cs interrupt_ecf card not ready for interrupt
Apr  6 13:43:05 herakleion kernel: ray_hw_xmit failed - ECF not ready for intr
Apr  6 13:43:05 herakleion kernel: ray_cs interrupt network "SCREWYSQUIRREL" started
Apr  6 13:43:13 herakleion kernel: interrupt_ecf(local=d3698c00, ccs = 0x0
Apr  6 13:44:00 herakleion last message repeated 2 times
Apr  6 13:44:29 herakleion last message repeated 3 times
Apr  6 13:45:00 herakleion dhcpcd[1654]: timed out waiting for a valid DHCP server response 
Apr  6 13:45:00 herakleion kernel: ray_cs set_multicast_list(d426fc00)
Apr  6 13:45:00 herakleion kernel: ray_dev_close('eth1')







 herakleion:4 $ sh !$
sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux herakleion.purplefrog.com 2.4.18 #8 Sat Apr 6 12:01:19 EST 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         ray_cs agpgart NVdriver ds yenta_socket pcmcia_core autofs 3c59x appletalk ipx ipchains ide-scsi scsi_mod ide-cd cdrom usb-uhci usbcore


[root@herakleion Documentation]# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III Mobile CPU      1000MHz
stepping        : 1
cpu MHz         : 996.693
cache size      : 512 KB
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


[root@herakleion Documentation]# cat /proc/modules 
nfs                    76112   1 (autoclean)
lockd                  50864   0 (autoclean) [nfs]
sunrpc                 64160   1 (autoclean) [nfs lockd]
ray_cs                 28512   1
agpgart                32512   3 (autoclean)
NVdriver              946096  11
ds                      8688   2 [ray_cs]
yenta_socket            9520   2
pcmcia_core            48032   0 [ray_cs ds yenta_socket]
autofs                 10560   3 (autoclean)
3c59x                  26016   1
appletalk              21200   0 (autoclean)
ipx                    16800   0 (autoclean)
ipchains               36832  23
ide-scsi                8256   0
scsi_mod               95152   1 [ide-scsi]
ide-cd                 27680   0
cdrom                  28512   0 [ide-cd]
usb-uhci               22496   0 (unused)
usbcore                53280   1 [usb-uhci]



[root@herakleion Documentation]# cat /proc/ioports 
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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
bfa0-bfaf : Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (-M)
  bfa0-bfa7 : ide0
c000-cfff : PCI Bus #01
dce0-dcff : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A)
  dce0-dcff : usb-uhci
e000-ffff : PCI Bus #02
  e000-e0ff : PCI CardBus #03
  e400-e4ff : PCI device 10b7:1007 (3Com Corporation)
  e800-e8ff : 3Com Corporation 3c556 Hurricane CardBus
    e800-e87f : 02:06.0
  ec00-ecff : ESS Technology ES1983S Maestro-3i PCI Audio Accelerator
  f000-f0ff : PCI CardBus #03
  f400-f4ff : PCI CardBus #07
  f800-f8ff : PCI CardBus #07



[root@herakleion Documentation]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-17fea7ff : System RAM
  00100000-0024a693 : Kernel code
  0024a694-002ab22b : Kernel data
17fea800-17ffffff : reserved
a0000000-a0000fff : card services
a0001000-a0008fff : ray_cs
a0009000-a000cfff : ray_cs
a000d000-a000dfff : ray_cs
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : nVidia Corporation GeForce2 Go
    e0000000-e0ffffff : vesafb
e8000000-ebffffff : Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub
f4000000-fbffffff : PCI Bus #02
  f4000000-f4000fff : Texas Instruments PCI4451 PC card Cardbus Controller
  f4001000-f4001fff : Texas Instruments PCI4451 PC card Cardbus Controller (#2)
  f4400000-f47fffff : PCI CardBus #03
  f4800000-f4bfffff : PCI CardBus #03
  f4c00000-f4ffffff : PCI CardBus #07
  f5000000-f53fffff : PCI CardBus #07
  f8ff8000-f8ffbfff : PCI device 104c:8027 (Texas Instruments)
  f8ffc800-f8ffcfff : PCI device 104c:8027 (Texas Instruments)
  f8ffd000-f8ffd07f : PCI device 10b7:1007 (3Com Corporation)
  f8ffd400-f8ffd4ff : PCI device 10b7:1007 (3Com Corporation)
  f8ffd800-f8ffd87f : 3Com Corporation 3c556 Hurricane CardBus
  f8ffdc00-f8ffdc7f : 3Com Corporation 3c556 Hurricane CardBus
  f8ffe000-f8ffffff : ESS Technology ES1983S Maestro-3i PCI Audio Accelerator
fc000000-fdffffff : PCI Bus #01
  fc000000-fcffffff : nVidia Corporation GeForce2 Go
feea0000-feefffff : reserved
ffb80000-ffffffff : reserved



[root@herakleion Documentation]# lspci -vvv
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [88] #09 [e104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation 82801BA PCI (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=10, sec-latency=32
        I/O behind bridge: 0000e000-0000ffff
        Memory behind bridge: f4000000-fbffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801BAM ISA Bridge (ICH2) (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801BAM IDE U100 (rev 03) (prog-if 80 [Master])
        Subsystem: Intel Corporation: Unknown device 4541
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at bfa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 03) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 4541
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at dce0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0112 (rev b2) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 00e6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=<none>

02:03.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 10)
        Subsystem: Dell Computer Corporation: Unknown device 00e6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at f8ffe000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

02:06.0 Ethernet controller: 3Com Corporation 3c556 Laptop Tornado (rev 10)
        Subsystem: 3Com Corporation: Unknown device 6456
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 1250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at f8ffdc00 (32-bit, non-prefetchable) [size=128]
        Region 2: Memory at f8ffd800 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at f9000000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:06.1 Communication controller: 3Com Corporation: Unknown device 1007 (rev 10)
        Subsystem: 3Com Corporation: Unknown device 615b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 1250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e400 [size=256]
        Region 1: Memory at f8ffd400 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at f8ffd000 (32-bit, non-prefetchable) [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:0f.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
        Subsystem: Dell Computer Corporation: Unknown device 00e6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 04
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: f4400000-f47ff000 (prefetchable)
        Memory window 1: f4800000-f4bff000
        I/O window 0: 0000e000-0000e0ff
        I/O window 1: 0000f000-0000f0ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:0f.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
        Subsystem: Dell Computer Corporation: Unknown device 00e6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 04
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f4001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: f4c00000-f4fff000 (prefetchable)
        Memory window 1: f5000000-f53ff000
        I/O window 0: 0000f400-0000f4ff
        I/O window 1: 0000f800-0000f8ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:0f.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8027 (prog-if 10 [OHCI])
        Subsystem: Dell Computer Corporation: Unknown device 00e6
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f8ffc800 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at f8ff8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



Anyway, do you have any ideas what's wrong?  Have you ever used the
Aviator with a 2.4 kernel and had it work?


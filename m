Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWGVQAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWGVQAF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWGVQAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:00:05 -0400
Received: from inter.mezzo.net ([217.110.105.10]:8884 "EHLO inter.mezzo.net")
	by vger.kernel.org with ESMTP id S1750763AbWGVQAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:00:02 -0400
Date: Sat, 22 Jul 2006 17:59:40 +0200 (CEST)
From: Peter Koellner <peter@asgalon.net>
X-X-Sender: peter@noisydwarf
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: usb storage device not working anymore in 2.6.17.5 and
 2.6.17.6
Message-ID: <Pine.LNX.4.62.0607221735210.6065@noisydwarf>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I noticed a problem with my usb storage device after upgrading
from 2.6.17.4:


problem: After updating the kernel from 2.6.17.4 to .5 and then .6 my 
usb HDD drive does not work anymore. Any ideas?

symptoms: on plugging in the HDD, I get the following outpit in dmesg
with kernel 2.6.17.6:

usb 4-1.4.1: new full speed USB device using ehci_hcd and address 11
usb 4-1.4.1: device descriptor read/64, error -32
usb 4-1.4.1: device descriptor read/64, error -32
usb 4-1.4.1: new full speed USB device using ehci_hcd and address 12
usb 4-1.4.1: device descriptor read/64, error -32
usb 4-1.4.1: device descriptor read/64, error -32
usb 4-1.4.1: new full speed USB device using ehci_hcd and address 13
usb 4-1.4.1: device not accepting address 13, error -32
usb 4-1.4.1: new full speed USB device using ehci_hcd and address 14
usb 4-1.4.1: device not accepting address 14, error -32

the excerpt from kernel 2.6.17.5s kern.log before last update:
Jul 22 13:25:47 noisydwarf kernel: usb 4-1.4.1: new high speed USB device using ehci_hcd and address 7
Jul 22 13:32:47 noisydwarf kernel: usb 4-1.4.1: new high speed USB device using ehci_hcd and address 8
Jul 22 13:32:47 noisydwarf kernel: usb 4-1.4.1: configuration #1 chosen from 1 choice
Jul 22 13:32:52 noisydwarf kernel: usb 4-1.4.1: can't set config #1, error -110
Jul 22 13:55:08 noisydwarf kernel: usb 4-1.4.1: USB disconnect, address 8
Jul 22 13:55:10 noisydwarf kernel: usb 4-1.4.1: new high speed USB device using ehci_hcd and address 9
Jul 22 13:55:10 noisydwarf kernel: usb 4-1.4.1: configuration #1 chosen from 1 choice
Jul 22 13:55:15 noisydwarf kernel: usb 4-1.4.1: can't set config #1, error -110
Jul 22 13:57:02 noisydwarf kernel: usb 4-1.4.1: USB disconnect, address 9
Jul 22 13:57:19 noisydwarf kernel: usb 4-1.4.1: new high speed USB device using ehci_hcd and address 10
Jul 22 14:04:19 noisydwarf kernel: usb 4-1.4.1: new high speed USB device using ehci_hcd and address 11
Jul 22 14:04:19 noisydwarf kernel: usb 4-1.4.1: configuration #1 chosen from 1 choice
Jul 22 14:04:24 noisydwarf kernel: usb 4-1.4.1: can't set config #1, error -110


The "device descriptor read" message is generated in
    drivers/usb/core/hub.c after invoking usb_get_device_descriptor in
    drivers/usb/core/message.c



/proc/version:
  Linux version 2.6.17.6 (root@noisydwarf) (gcc version 4.1.2 20060715
  (prerelease) (Debian 4.1.1-9)) #1 PREEMPT Sat Jul 22 14:36:58 CEST
  2006

/proc/cpuinfo:

  processor	: 0
  vendor_id	: GenuineIntel
  cpu family	: 15
  model		: 2
  model name	: Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz
  stepping	: 9
  cpu MHz		: 1599.960
  cache size	: 512 KB
  fdiv_bug	: no
  hlt_bug		: no
  f00f_bug	: no
  coma_bug	: no
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 2
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe up cid xtpr
  bogomips	: 3192.24


/proc/modules:
  ndiswrapper 145936 0 - Live 0xf8dae000
  radeon 98720 1 - Live 0xf8c3b000
  binfmt_misc 10632 1 - Live 0xf8bd5000
  cpufreq_ondemand 6304 1 - Live 0xf8b97000
  rfcomm 32792 3 - Live 0xf8be0000
  l2cap 21380 5 rfcomm, Live 0xf8bce000
  ipv6 214112 28 - Live 0xf8c05000
  autofs4 19332 1 - Live 0xf8bc0000
  xfrm_user 19712 0 - Live 0xf8bba000
  xfrm4_tunnel 2560 0 - Live 0xf8ba3000
  tunnel4 3332 1 xfrm4_tunnel, Live 0xf8b9a000
  ipcomp 7048 0 - Live 0xf8b80000
  esp4 7936 0 - Live 0xf8b2f000
  ah4 6528 0 - Live 0xf8960000
  deflate 3840 0 - Live 0xf8b2d000
  zlib_deflate 18200 1 deflate, Live 0xf8b9d000
  twofish 43008 0 - Live 0xf8ba7000
  serpent 19200 0 - Live 0xf8b89000
  aes 28096 0 - Live 0xf8b8f000
  blowfish 9216 0 - Live 0xf8b7c000
  des 17408 0 - Live 0xf8b83000
  sha256 11008 0 - Live 0xf8b32000
  sha1 2560 0 - Live 0xf8969000
  md5 3968 0 - Live 0xf8963000
  crypto_null 2560 0 - Live 0xf894d000
  dm_mod 48184 0 - Live 0xf8b4e000
  msr 3460 0 - Live 0xf8881000
  cpuid 3204 0 - Live 0xf883e000
  fat 46108 0 - Live 0xf8b02000
  ntfs 88692 1 - Live 0xf8b37000
  cyberjack 9220 1 - Live 0xf8965000
  hci_usb 14228 2 - Live 0xf8942000
  bluetooth 42084 7 rfcomm,l2cap,hci_usb, Live 0xf8b10000
  usbserial 26984 3 cyberjack, Live 0xf8975000
  usbhid 34400 0 - Live 0xf896b000
  eth1394 17924 0 - Live 0xf8947000
  8250_pci 19840 0 - Live 0xf88e8000
  8250 20564 1 8250_pci, Live 0xf8908000
  serial_core 19072 1 8250, Live 0xf8902000
  snd_intel8x0 30108 1 - Live 0xf88f1000
  ehci_hcd 27912 0 - Live 0xf88fa000
  uhci_hcd 20104 0 - Live 0xf88dd000
  snd_intel8x0m 15884 0 - Live 0xf88e3000
  snd_ac97_codec 82592 2 snd_intel8x0,snd_intel8x0m, Live 0xf88b2000
  snd_ac97_bus 2304 1 snd_ac97_codec, Live 0xf8883000
  joydev 8896 0 - Live 0xf889a000
  evdev 8960 3 - Live 0xf8896000
  snd_pcm 73992 3 snd_intel8x0,snd_intel8x0m,snd_ac97_codec, Live 0xf88c9000
  snd_timer 20740 1 snd_pcm, Live 0xf889e000
  snd 47332 7 snd_intel8x0,snd_intel8x0m,snd_ac97_codec,snd_pcm,snd_timer, Live 0xf88a5000
  snd_page_alloc 9480 3 snd_intel8x0,snd_intel8x0m,snd_pcm, Live 0xf8892000
  ohci1394 30512 0 - Live 0xf8878000
  ieee1394 86072 2 eth1394,ohci1394, Live 0xf8861000

/proc/ioports
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
  0376-0376 : ide1
  03c0-03df : vga+
  03f6-03f6 : ide0
  04d0-04d1 : pnp 00:02
  0800-080f : pnp 00:02
  0900-097f : pnp 00:08
  1000-107f : 0000:00:1f.0
    1000-1005 : motherboard
      1000-1003 : PM1a_EVT_BLK
      1004-1005 : PM1a_CNT_BLK
    1006-1007 : motherboard
      1006-1007 : pnp 00:03
    1008-100f : motherboard
      1008-100b : PM_TMR
    1010-105f : motherboard
      1020-1020 : PM2_CNT_BLK
      1028-102f : GPE0_BLK
    1060-107f : motherboard
      1060-107f : pnp 00:03
  1080-10bf : 0000:00:1f.0
    1080-10bf : motherboard
      1080-10bf : pnp 00:03
  10c0-10df : motherboard
    10c0-10df : pnp 00:03
  10e0-10ff : motherboard
    10e0-10e5 : ACPI CPU throttle
  b080-b0ff : 0000:00:1f.6
    b080-b0ff : Intel 82801DB-ICH4 Modem
  b400-b4ff : 0000:00:1f.6
    b400-b4ff : Intel 82801DB-ICH4 Modem
  b800-b8ff : 0000:00:1f.5
    b800-b8ff : Intel 82801DB-ICH4
  bc40-bc7f : 0000:00:1f.5
    bc40-bc7f : Intel 82801DB-ICH4
  bf20-bf3f : 0000:00:1d.2
    bf20-bf3f : uhci_hcd
  bf40-bf5f : 0000:00:1d.1
    bf40-bf5f : uhci_hcd
  bf80-bf9f : 0000:00:1d.0
    bf80-bf9f : uhci_hcd
  bfa0-bfaf : 0000:00:1f.1
    bfa0-bfa7 : ide0
    bfa8-bfaf : ide1
  c000-cfff : PCI Bus #01
    c000-c0ff : 0000:01:00.0
  d000-efff : PCI Bus #02
    d000-d0ff : PCI CardBus #03
    d400-d4ff : PCI CardBus #03
  f400-f4fe : motherboard
    f400-f4fe : pnp 00:03

/proc/iomem
  00000000-0009efff : System RAM
  0009f000-0009ffff : reserved
  000a0000-000bffff : Video RAM area
  000c0000-000cffff : Video ROM
  000f0000-000fffff : System ROM
  00100000-7ffcf7ff : System RAM
    00100000-0032c10e : Kernel code
    0032c10f-003f2557 : Kernel data
  7ffcf800-7fffffff : reserved
  88000000-89ffffff : PCI Bus #02
    88000000-89ffffff : PCI CardBus #03
  8a000000-8a0003ff : 0000:00:1f.1
  e0000000-e7ffffff : 0000:00:00.0
  e8000000-efffffff : PCI Bus #01
    e8000000-efffffff : 0000:01:00.0
  f4fff400-f4fff4ff : 0000:00:1f.5
    f4fff400-f4fff4ff : Intel 82801DB-ICH4
  f4fff800-f4fff9ff : 0000:00:1f.5
    f4fff800-f4fff9ff : Intel 82801DB-ICH4
  f4fffc00-f4ffffff : 0000:00:1d.7
    f4fffc00-f4ffffff : ehci_hcd
  f6000000-fbffffff : PCI Bus #02
    f6000000-f7ffffff : PCI CardBus #03
    f8000000-f8000fff : 0000:02:04.0
      f8000000-f8000fff : yenta_socket
    faff4000-faff7fff : 0000:02:04.1
    faffb800-faffbfff : 0000:02:04.1
      faffb800-faffbfff : ohci1394
    faffc000-faffdfff : 0000:02:02.0
      faffc000-faffdfff : ndiswrapper
    faffe000-faffffff : 0000:02:01.0
      faffe000-faffffff : b44
  fc000000-fdffffff : PCI Bus #01
    fc000000-fc01ffff : 0000:01:00.0
    fcff0000-fcffffff : 0000:01:00.0
  fec00000-fec1ffff : reserved
  feda0000-fee0ffff : reserved
  ffb00000-ffffffff : reserved


lspci -vvv

  00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
  Processor to I/O Controller (rev 02)
 	 Subsystem: Dell Unknown device 015f
 	 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
 	 ParErr- Stepping- SERR+ FastB2B-
 	 Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
 	 <TAbort- <MAbort+ >SERR- <PERR-
 	 Latency: 0
 	 Region 0: Memory at e0000000 (32-bit, prefetchable)
 	 [size=128M]
 	 Capabilities: [40] Vendor Specific Information
 	 Capabilities: [a0] AGP version 2.0
 		 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
 		 HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
 		 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit-
 		 FW- Rate=x1
  00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
  Processor to I/O Controller (rev 02)
 	 Subsystem: Dell Unknown device 015f
 	 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
 	 ParErr- Stepping- SERR- FastB2B-
 	 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
 	 <TAbort- <MAbort- >SERR- <PERR-
 	 Latency: 0

  00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
  Processor to I/O Controller (rev 02)
 	 Subsystem: Dell Unknown device 015f
 	 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
 	 ParErr- Stepping- SERR- FastB2B-
 	 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
 	 <TAbort- <MAbort- >SERR- <PERR-
 	 Latency: 0

  00:01.0 PCI bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
  Processor to AGP Controller (rev 02) (prog-if 00 [Normal decode])
 	 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
 	 ParErr- Stepping- SERR+ FastB2B-
 	 Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
 	 <TAbort- <MAbort- >SERR- <PERR-
 	 Latency: 32
 	 Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
 	 I/O behind bridge: 0000c000-0000cfff
 	 Memory behind bridge: fc000000-fdffffff
 	 Prefetchable memory behind bridge: e8000000-efffffff
 	 Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium
 	 >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
 	 BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

  00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
  (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01) (prog-if 00
  [UHCI])
 	 Subsystem: Dell Unknown device 015f
 	 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
 	 ParErr- Stepping- SERR- FastB2B-
 	 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
 	 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	 Latency: 0
 	 Interrupt: pin A routed to IRQ 16
 	 Region 4: I/O ports at bf80 [size=32]

  00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
  (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00
  [UHCI])
 	 Subsystem: Dell Unknown device 015f
 	 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
 	 ParErr- Stepping- SERR- FastB2B-
 	 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
 	 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	 Latency: 0
 	 Interrupt: pin B routed to IRQ 18
 	 Region 4: I/O ports at bf40 [size=32]

  00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
  (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01) (prog-if 00
  [UHCI])
 	 Subsystem: Dell Unknown device 015f
 	 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
 	 ParErr- Stepping- SERR- FastB2B-
 	 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
 	 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	 Latency: 0
 	 Interrupt: pin C routed to IRQ 19
 	 Region 4: I/O ports at bf20 [size=32]

  00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
  USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
 	 Subsystem: Dell Unknown device 015f
 	 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
 	 ParErr- Stepping- SERR+ FastB2B-
 	 Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
 	 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	 Latency: 0
 	 Interrupt: pin D routed to IRQ 20
 	 Region 0: Memory at f4fffc00 (32-bit, non-prefetchable)
 	 [size=1K]
 	 Capabilities: [50] Power- <PERR-
 	 Latency: 32 (2000ns min), Cache Line Size: 32 bytes
 	 Interrupt: pin A routed to IRQ 21
 	 Region 0: Memory at e8000000 (32-bit, prefetchable)
 	 [size=128M]
 	 Region 1: I/O ports at c000 [size=256]
 	 Region 2: Memory at fcff0000 (32-bit, non-prefetchable)
 	 [size=64K]


/proc/scsi/scsi
  Attached devices:


/proc/bus/usb/devices

  T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
  B:  Alloc=  0/800 us ( 0%), #Int=  5, #Iso=  0
  D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
  P:  Vendor=0000 ProdID=0000 Rev= 2.06
  S:  Manufacturer=Linux 2.6.17.6 ehci_hcd
  S:  Product=EHCI Host Controller
  S:  SerialNumber=0000:00:1d.7
  C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
  I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
  E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

  T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480 MxCh= 4
  D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
  P:  Vendor=05e3 ProdID=0605 Rev= 6.0b
  S:  Product=USB2.0 Hub
  C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
  I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
  E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms

  T:  Bus=04 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  4 Spd=1.5 MxCh= 0
  D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
  P:  Vendor=046d ProdID=c505 Rev=17.00
  S:  Manufacturer=Logitech
  S:  Product=USB Receiver
  C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 98mA
  I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
  E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
  I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
  E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

  T:  Bus=04 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#=  5 Spd=12  MxCh= 0
  D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=16 #Cfgs=  1
  P:  Vendor=0c4b ProdID=0100 Rev= 1.00
  S:  Manufacturer=Reiner-SCT
  S:  Product=cyberJack e-co
  C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 96mA
  I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=cyberjack
  E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=5ms
  E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
  E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

  T:  Bus=04 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  6 Spd=480 MxCh= 4
  D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
  P:  Vendor=05e3 ProdID=0605 Rev= 6.0b
  S:  Product=USB2.0 Hub
  C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
  I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
  E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms

  T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
  B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
  D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
  P:  Vendor=0000 ProdID=0000 Rev= 2.06
  S:  Manufacturer=Linux 2.6.17.6 uhci_hcd
  S:  Product=UHCI Host Controller
  S:  SerialNumber=0000:00:1d.2
  C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
  I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
  E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

  T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
  B:  Alloc= 27/900 us ( 3%), #Int=  1, #Iso=  2
  D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
  P:  Vendor=0000 ProdID=0000 Rev= 2.06
  S:  Manufacturer=Linux 2.6.17.6 uhci_hcd
  S:  Product=UHCI Host Controller
  S:  SerialNumber=0000:00:1d.1
  C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
  I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
  E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

  T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
  D:  Ver= 1.10 Cls=ff(vend.) Sub=ff Prot=ff MxPS=64 #Cfgs=  1
  P:  Vendor=057c ProdID=3800 Rev=15.00
  S:  Manufacturer=Bluetooth Device
  S:  Product=Bluetooth Device
  S:  SerialNumber=982F890E0400
  C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=200mA
  I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=hci_usb
  E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
  E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
  E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
  I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=hci_usb
  E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
  E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
  I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=hci_usb
  E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
  E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
  I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=hci_usb
  E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
  E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
  I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=hci_usb
  E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
  E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
  I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=hci_usb
  E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
  E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
  I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=hci_usb
  E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
  E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

  T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
  B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
  D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
  P:  Vendor=0000 ProdID=0000 Rev= 2.06
  S:  Manufacturer=Linux 2.6.17.6 uhci_hcd
  S:  Product=UHCI Host Controller
  S:  SerialNumber=0000:00:1d.0
  C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
  I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
  E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

-- 
peter koellner <peter@asgalon.net>

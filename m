Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSJMRV0>; Sun, 13 Oct 2002 13:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbSJMRV0>; Sun, 13 Oct 2002 13:21:26 -0400
Received: from aragon.noos.net ([212.198.2.75]:39724 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S261561AbSJMRVW>;
	Sun, 13 Oct 2002 13:21:22 -0400
Date: Sun, 13 Oct 2002 19:25:57 +0200
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: greg@kroah.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.5.42-ac1, 2.5.42, 2.5.41 boot hang with CONFIG_USB_DEBUG=n
Message-ID: <20021013172557.GA890@rousalka.noos.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me any replies as I'm not on the lists]

Hi

	Since Alan started posting 2.5 -ac patches I decided it was 
time to give 2.5 a try. I was then unpleasantly surprized by a system 
freeze on boot (just after echoing of the message about the AMD 756 
workaround). Now it turns out I didn't do such a piss-poor of 
configuring my 2.5 kernel, since the only option I could find that make 
a difference was CONFIG_USB_DEBUG. When I accept flooding my system 
logs with obscure usb incantations the system boots:(.

	Unfortunately I need usb, I've got a nice brand-new usb 
keyboard last week since my old noname (newmate) ps/2 keyboard was 
giving w2k heart attacks (despite working flawlessly under linux 2.4 
and windows 98). I figured since I had to replace a perfectly working 
device I could as well go the legacy-free way:). (I can test the old 
keyboard with 2.5 if anyone's interested by turbo-key-of-w2k-death 
support btw)

	Can an helpful soul help me bring my system some relief  ? I'd 
really like not to boot in debug mode.

	System is Red Hat Rawhide, I've inserted some logs snippets, 
lspci and lsusb outputs if it can help.

Oct 13 18:31:11 rousalka kernel: Debug: sleeping function called from 
illegal context at include/asm/semaphore.h:119
Oct 13 18:31:11 rousalka kernel: Call Trace:
Oct 13 18:31:11 rousalka kernel:  [<c026bc95>] usb_hub_events+0x75/0x410
Oct 13 18:31:11 rousalka kernel:  [<c026c065>] usb_hub_thread+0x35/0xf0
Oct 13 18:31:11 rousalka kernel:  [<c0116b50>] 
default_wake_function+0x0/0x40
Oct 13 18:31:11 rousalka kernel:  [<c026c030>] usb_hub_thread+0x0/0xf0
Oct 13 18:31:11 rousalka kernel:  [<c0105601>] 
kernel_thread_helper+0x5/0x14


0:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] 
System Controller (rev 25)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32
         Region 0: Memory at dc000000 (32-bit, prefetchable) [size=32M]
         Region 1: Memory at e1001000 (32-bit, prefetchable) [size=4K]
         Region 2: I/O ports at e000 [disabled] [size=4]
         Capabilities: [a0] AGP version 1.0
                 Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP 
Bridge (rev 01) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: d8000000-dbffffff
         Prefetchable memory behind bridge: de000000-dfffffff
         BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA 
(rev 01)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE 
(rev 03) (prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 
03)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] 
USB (rev 06) (prog-if 10 [OHCI])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16 (20000ns max), cache line size 08
         Interrupt: pin D routed to IRQ 7
         Region 0: Memory at e1000000 (32-bit, non-prefetchable) 
[size=4K]

00:08.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 
08)
         Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, 
AudioPCI128
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort+ <MAbort+ >SERR- <PERR-
         Latency: 32 (3000ns min, 32000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at e400 [size=64]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8029(AS)
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at e800 [size=32]
         Expansion ROM at e0000000 [disabled] [size=32K]

01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP 
(rev 04) (prog-if 00 [VGA])
         Subsystem: Matrox Graphics, Inc. Millennium G400 32Mb SGRAM
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (4000ns min, 8000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 3
         Region 0: Memory at de000000 (32-bit, prefetchable) [size=32M]
         Region 1: Memory at d8000000 (32-bit, non-prefetchable) 
[size=16K]
         Region 2: Memory at d9000000 (32-bit, non-prefetchable) 
[size=8M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [f0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=15 SBA+ AGP+ 64bit- FW- Rate=x2


Bus 001 Device 002: ID 046a:0001 Cherry Mikroschalter GmbH My3000 
Keyboard
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.00
   bDeviceClass            0 Interface
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x046a Cherry Mikroschalter GmbH
   idProduct          0x0001 My3000 Keyboard
   bcdDevice            9.08
   iManufacturer           0
   iProduct                0
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           34
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Devices
       bInterfaceSubClass      1 Boot Interface Subclass
       bInterfaceProtocol      1 Keyboard
       iInterface              0
         HID Device Descriptor:
           bLength                 9
           bDescriptorType        33
           bcdHID               1.00
           bCountryCode            0
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength      63
cannot get report descriptor
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               none
         wMaxPacketSize          8
         bInterval              12
   Language IDs: (length=4)
      0009 English(English)

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            9 Hub
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x0000 Virtual
   idProduct          0x0000 Hub
   bcdDevice            2.05
   iManufacturer           3 Linux 2.5.42-ac1-lys9 ohci-hcd
   iProduct                2 Advanced Micro Devices [AMD] AMD-756 
[Viper] USB
   iSerial                 1 00:07.4
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           25
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x40
       Self Powered
     MaxPower                0mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         9 Hub
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               none
         wMaxPacketSize          2
         bInterval             255
   Language IDs: (length=4)
      0409 English(US)

--
Nicolas Mailhot

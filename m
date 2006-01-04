Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWADTxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWADTxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWADTxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:53:41 -0500
Received: from mail.gmx.net ([213.165.64.21]:4062 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932161AbWADTxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:53:40 -0500
X-Authenticated: #271361
Date: Wed, 4 Jan 2006 20:53:47 +0100
From: Edgar Toernig <froese@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15 USB-Audio produces loud noise
Message-Id: <20060104205347.46f62718.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my USB-speakers only work sporadical with 2.6.15.  Sometimes everything's
fine, sometimes they only produces loud noise as if the low and high bytes
are swapped or the samples are not properly aligned.  With 2.6.13 I never
had this problem.

This occures either with alsaplayer or with OSS apps using the kernel
OSS emulation.  Furthermore, it seems to be a startup problem.  If
playback starts correct it stays correct, if it starts wrong it stays
wrong - at least as long as it keeps streaming.  If playback is paused,
the problem may trigger again.

I tried UP, SMP (P4-HT), gcc-2.95, gcc-3.3.5 - no change.  All drivers
build in.

[dmesg, lspci, and lsusb output below]

Any fix known?  I had a short look at the 2.6.13->15 diffs of usbaudio.c
but they are rather big and I don't even know whether it's an USB or an
Alsa problem...

Ciao, ET.


dmesg: (stripped)

ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.0: OHCI Host Controller
drivers/usb/core/inode.c: creating file '002'
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 18, io mem 0xec304000
ohci_hcd 0000:00:13.0: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:13.0: OHCI controller state
ohci_hcd 0000:00:13.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:13.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:13.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:13.0: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:13.0: intrenable 0x8000001a MIE UE RD WDH
ohci_hcd 0000:00:13.0: hcca frame #0005
ohci_hcd 0000:00:13.0: roothub.a 02000203 POTPGT=2 NPS NDP=3(3)
ohci_hcd 0000:00:13.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:13.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:13.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:13.0: roothub.portstatus [0] 0x00010100 CSC PPS
ohci_hcd 0000:00:13.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:13.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:13.0: created debug files
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.15 ohci_hcd
usb usb2: SerialNumber: 0000:00:13.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 4ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 4ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [0] = 0x00100103 PRSC PPS PE
S CCS
usb 2-1: new full speed USB device using ohci_hcd and address 2
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [0] = 0x00100103 PRSC PPS PE
S CCS
usb 2-1: ep0 maxpacket = 8
usb 2-1: skipped 4 descriptors after interface
usb 2-1: skipped 2 descriptors after interface
usb 2-1: skipped 1 descriptor after endpoint
usb 2-1: default language 0x0409
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: Product: USB Audio
usb 2-1: Manufacturer: C-Media INC.
usb 2-1: hotplug
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: hotplug
usb 2-1: adding 2-1:1.1 (config #1, interface 1)
usb 2-1:1.1: hotplug
drivers/usb/core/inode.c: creating file '002'
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07 13:30:21
2005 UTC).
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 17
snd-usb-audio 2-1:1.0: usb_probe_interface
snd-usb-audio 2-1:1.0: usb_probe_interface - got id
usbcore: registered new driver snd-usb-audio
ALSA device list:
  #0: ATI IXP rev 0 with ALC650F at 0xec305000, irq 17
  #1: C-Media INC. USB Audio at usb-0000:00:13.0-1, full speed


lspci:

0000:00:13.0 USB Controller: ATI Technologies Inc OHCI USB Controller #1 (rev 01) (prog-if 10 [OHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device f362
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 20
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at ec304000 (32-bit, non-prefetchable) [size=4K]


lsusb:

Bus 002 Device 002: ID 0d8c:0001 C-Media Electronics, Inc. USB Speaker
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0d8c C-Media Electronics, Inc.
  idProduct          0x0001 USB Speaker
  bcdDevice            0.10
  iManufacturer           1 C-Media INC.
  iProduct                2 USB Audio
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          110
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           40
        bInCollection           1
        baInterfaceNr( 0)       1
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                13
        bSourceID               1
        bControlSize            1
        bmaControls( 0)      0x03
          Mute
          Volume
        bmaControls( 1)      0x00
        bmaControls( 2)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID              13
        iTerminal               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined

EOF

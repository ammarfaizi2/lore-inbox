Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVGJCVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVGJCVk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 22:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVGJCVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 22:21:39 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:64929 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261817AbVGJCVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 22:21:35 -0400
Message-ID: <42D0862E.90700@blueyonder.co.uk>
Date: Sun, 10 Jul 2005 03:21:34 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.12 USB Keypad still not working
References: <42BC7215.3050507@blueyonder.co.uk> <20050624180854.542bb10c.akpm@osdl.org> <42BFFAD2.1080703@blueyonder.co.uk>
In-Reply-To: <42BFFAD2.1080703@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2005 02:22:16.0093 (UTC) FILETIME=[30876CD0:01C584F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest collection of data on this problem with 2.6.13-rc2, no change 
since new device installed under 2.6.12.

barrabas:/home/lancelot # cat /proc/asound/oss/sndstat
Sound Driver:3.8.1a-980706 (ALSA v1.0.9 emulation code)
Kernel: Linux barrabas 2.6.13-rc2 #1 Thu Jul 7 00:44:07 BST 2005 i686
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
NVidia nForce2 with ALC650F at 0xed080000, irq 201
BeyondTel USB Phone at usb-0000:00:02.1-2, full speed

Audio devices:
0: NVidia nForce2 (DUPLEX)
1: USB Audio (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: Realtek ALC650F
1: USB Mixer

# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: CH [NVidia nForce2], device 0: Intel ICH [NVidia nForce2]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: CH [NVidia nForce2], device 2: Intel ICH - IEC958 [NVidia 
nForce2 - IEC958]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: Phone [USB Phone], device 0: USB Audio [USB Audio]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

# arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: CH [NVidia nForce2], device 0: Intel ICH [NVidia nForce2]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: CH [NVidia nForce2], device 1: Intel ICH - MIC ADC [NVidia 
nForce2 - MIC ADC]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: Phone [USB Phone], device 0: USB Audio [USB Audio]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

udevinfo starts with the device the node belongs to and then walks up the
device chain, to print for every device found, all possibly useful 
attributes
in the udev key format.
Only attributes within one device section may be used together in one rule,
to match the device for which the node will be created.

   looking at class device '/sys/bus/usb/devices/usb3/3-2/3-2:1.3':
     SUBSYSTEM="unknown"
     SYSFS{bAlternateSetting}=" 0"
     SYSFS{bInterfaceClass}="03"
     SYSFS{bInterfaceNumber}="03"
     SYSFS{bInterfaceProtocol}="00"
     SYSFS{bInterfaceSubClass}="00"
     SYSFS{bNumEndpoints}="02"
     SYSFS{interface}="Keypad"
     SYSFS{modalias}="usb:v04B4p0303d0100dc00dsc00dp00ic03isc00ip00"

# udevinfo -a -p /sys/bus/usb/devices/usb3/3-2

udevinfo starts with the device the node belongs to and then walks up the
device chain, to print for every device found, all possibly useful 
attributes
in the udev key format.
Only attributes within one device section may be used together in one rule,
to match the device for which the node will be created.

   looking at class device '/sys/bus/usb/devices/usb3/3-2':
     SUBSYSTEM="unknown"
     SYSFS{bConfigurationValue}="1"
     SYSFS{bDeviceClass}="00"
     SYSFS{bDeviceProtocol}="00"
     SYSFS{bDeviceSubClass}="00"
     SYSFS{bMaxPower}="100mA"
     SYSFS{bNumConfigurations}="1"
     SYSFS{bNumInterfaces}=" 4"
     SYSFS{bcdDevice}="0100"
     SYSFS{bmAttributes}="80"
     SYSFS{configuration}="USB Phone"
     SYSFS{devnum}="3"
     SYSFS{idProduct}="0303"
     SYSFS{idVendor}="04b4"
     SYSFS{manufacturer}="BeyondTel"
     SYSFS{maxchild}="0"
     SYSFS{product}="USB Phone"
     SYSFS{serial}="0004"
     SYSFS{speed}="12"
     SYSFS{version}=" 1.00"

barrabas:/ftp/jul05 # cat /proc/bus/input/devices
I: Bus=0003 Vendor=04b4 Product=0303 Version=0100
N: Name="BeyondTel USB Phone"
P: Phys=usb-0000:00:02.1-2/input3
H: Handlers=kbd event0
B: EV=100003
B: KEY=e080ffdf 1cfffff ffffffff fffffffe

Regards
Sid.

Sid Boyce wrote:
> Andrew Morton wrote:
> 
>> Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>>
>>> PhoneSkype USB Phone SK-04.
>>> It gets detected, is registered in /sys/bus/usb as a Keypad. 
>>> Everything else USB works including the phone handset. Nothing is 
>>> detected by showkey when keys are pressed.
>>> # less /sys/bus/usb/devices/usb3/3-2/3-2:1.3/interface
>>> Keypad
>>>
>>> /dev/usb/hiddev? and /dev/input/keyboard say they are not valid 
>>> devices and they are the ones created by the SuSE 9.3 install, not by 
>>> udev.
>>>
>>>  From dmesg
>>>  ----------
>>> usbcore: registered new driver hiddev
>>> drivers/usb/input/hid-core.c: timeout initializing reports
>>>                               =============================
>>> input: USB HID v1.10 Keyboard [BeyondTel USB Phone] on 
>>> usb-0000:00:02.1-2
>>> usbcore: registered new driver usbhid
>>> drivers/usb/input/hid-core.c: v2.01:USB HID core driver
>>> input: USB HID v1.00 Joystick [CH PRODUCTS CH FLIGHT SIM YOKE USB ] 
>>> on usb-0000:00:02.1-1.1
>>> input: USB HID v1.00 Joystick [CH PRODUCTS CH PRO PEDALS USB ] on 
>>> usb-0000:00:02.1-1.4
>>> I am puzzled by the fact that the keypad is recognised, but I cannot 
>>> do anything with it.
>>>
>>> # lsusb
>>> Bus 003 Device 009: ID 04b8:0103 Seiko Epson Corp. Perfection 610
>>> Bus 003 Device 008: ID 067b:3507 Prolific Technology, Inc.
>>> Bus 003 Device 007: ID 068e:00f2 CH Products, Inc. Flight Sim Pedals
>>> Bus 003 Device 006: ID 05e3:0760 Genesys Logic, Inc. Card Reader
>>> Bus 003 Device 005: ID 03f0:0604 Hewlett-Packard DeskJet 840c
>>> Bus 003 Device 004: ID 068e:00ff CH Products, Inc. Flight Sim Yoke
>>> Bus 003 Device 003: ID 04b4:0303 Cypress Semiconductor Corp. <====
>>> Bus 003 Device 002: ID 0451:2077 Texas Instruments, Inc. TUSB2077 Hub
>>> Bus 003 Device 001: ID 0000:0000
>>> Bus 002 Device 001: ID 0000:0000
>>> Bus 001 Device 001: ID 0000:0000
>>>
>>
>>
>> Was this hardware known to work on ealier kernels?  If so, which?
>>
>>
> See below.
> Regards
> Sid.
> 
> 
> ------------------------------------------------------------------------
> 
> After the following change, I get the following, the timeout message is gone, I don't see the keyboard in dmesg, still does not report keystrokes in showkey.
>  
> --- linux-2.6.12-git8/drivers/usb/input/hid-core.c      2005-06-26 20:52:47.000000000 +0100
> +++ linux-2.6.12-git9/drivers/usb/input/hid-core.c      2005-06-27 12:19:53.000000000 +0100
> @@ -1368,6 +1368,7 @@
>  #define USB_VENDOR_ID_CYPRESS          0x04b4
>  #define USB_DEVICE_ID_CYPRESS_MOUSE    0x0001
>  #define USB_DEVICE_ID_CYPRESS_HIDCOM   0x5500
> +#define USB_DEVICE_ID_CYPRESS_USBPhone 0x0303
> 
>  #define USB_VENDOR_ID_BERKSHIRE                0x0c98
>  #define USB_DEVICE_ID_BERKSHIRE_PCWD   0x1140
> @@ -1445,6 +1446,7 @@
>         { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW48, HID_QUIRK_IGNORE },
>         { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW28, HID_QUIRK_IGNORE },
>         { USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM, HID_QUIRK_IGNORE },
> +       { USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_USBPhone, HID_QUIRK_IGNORE },
>         { USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE, HID_QUIRK_IGNORE },
>         { USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20, HID_QUIRK_IGNORE },
>         { USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
> 
> 
> # dmesg|grep -i hid
> usbcore: registered new driver hiddev
> input: USB HID v1.00 Joystick [CH PRODUCTS CH FLIGHT SIM YOKE USB ] on usb-0000:00:02.1-1.1
> input: USB HID v1.00 Joystick [CH PRODUCTS CH PRO PEDALS USB ] on usb-0000:00:02.1-1.4
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.01:USB HID core driver
> 
> Bus 003 Device 003: ID 04b4:0303 Cypress Semiconductor Corp.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x04b4 Cypress Semiconductor Corp.
>   idProduct          0x0303
>   bcdDevice            1.00
>   iManufacturer           1 BeyondTel
>   iProduct                2 USB Phone
>   iSerial                 4 0004
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          206
>     bNumInterfaces          4
>     bConfigurationValue     1
>     iConfiguration          2 USB Phone
>     bmAttributes         0x80
>     MaxPower              100mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      1 Control Device
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioControl Interface Descriptor:
>         bLength                10
>         bDescriptorType        36
>         bDescriptorSubtype      1 (HEADER)
>         bcdADC               1.00
>         wTotalLength           52
>         bInCollection           2
>         baInterfaceNr( 0)       1
>         baInterfaceNr( 1)       2
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             1
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          4
>         bNrChannels             1
>         wChannelConfig     0x0000
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             2
>         wTerminalType      0x0201 Microphone
>         bAssocTerminal          3
>         bNrChannels             1
>         wChannelConfig     0x0000
>         iChannelNames           0
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             3
>         wTerminalType      0x0301 Speaker
>         bAssocTerminal          2
>         bSourceID               1
>         iTerminal               0
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             4
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          1
>         bSourceID               2
>         iTerminal               0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bDelay                  0 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             1
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]         8000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x08  EP 8 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0010  1x 16 bytes
>         bInterval               1
>         bRefresh                0
>         bSynchAddress           0
>         AudioControl Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0 Undefined
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           4
>         bDelay                  0 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             1
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]         8000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x88  EP 8 IN
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0010  1x 16 bytes
>         bInterval               1
>         bRefresh                0
>         bSynchAddress           0
>         AudioControl Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x00
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0 Undefined
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         3 Human Interface Devices
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              3 Keypad
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.10
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      45
>           Report Descriptor: (length is 45)
> ###### The stuff below was never seen before ###############
>             Item(Global): Usage Page, data= [ 0x01 ] 1
>                             Generic Desktop Controls
>             Item(Local ): Usage, data= [ 0x06 ] 6
>                             Keyboard
>             Item(Main  ): Collection, data= [ 0x01 ] 1
>                             Application
>             Item(Global): Usage Page, data= [ 0x07 ] 7
>                             Keyboard
>             Item(Local ): Usage Minimum, data= [ 0xe0 ] 224
>                             Control Left
>             Item(Local ): Usage Maximum, data= [ 0xe7 ] 231
>                             GUI Right
>             Item(Global): Logical Minimum, data= [ 0x00 ] 0
>             Item(Global): Logical Maximum, data= [ 0x01 ] 1
>             Item(Global): Report Size, data= [ 0x01 ] 1
>             Item(Global): Report Count, data= [ 0x08 ] 8
>             Item(Main  ): Input, data= [ 0x02 ] 2
>                             Data Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position Non_Volatile Bitfield
>             Item(Global): Report Count, data= [ 0x01 ] 1
>             Item(Global): Report Size, data= [ 0x08 ] 8
>             Item(Main  ): Input, data= [ 0x03 ] 3
>                             Constant Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position Non_Volatile Bitfield
>             Item(Global): Report Count, data= [ 0x06 ] 6
>             Item(Global): Report Size, data= [ 0x08 ] 8
>             Item(Global): Logical Minimum, data= [ 0x00 ] 0
>             Item(Global): Logical Maximum, data= [ 0x65 ] 101
>             Item(Global): Usage Page, data= [ 0x07 ] 7
>                             Keyboard
>             Item(Local ): Usage Minimum, data= [ 0x00 ] 0
>                             No Event
>             Item(Local ): Usage Maximum, data= [ 0x65 ] 101
>                             Keyboard Application (Windows Key for Win95 or Compose)
>             Item(Main  ): Input, data= [ 0x00 ] 0
>                             Data Array Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position Non_Volatile Bitfield
>             Item(Main  ): End Collection, data=none
> ######################################################################
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               1
> 


-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks

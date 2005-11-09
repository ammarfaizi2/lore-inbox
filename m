Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030760AbVKITll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030760AbVKITll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030763AbVKITll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:41:41 -0500
Received: from pih-relay06.plus.net ([212.159.14.133]:31711 "EHLO
	pih-relay06.plus.net") by vger.kernel.org with ESMTP
	id S1030761AbVKITlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:41:40 -0500
Date: Wed, 9 Nov 2005 19:32:24 +0000
From: James Le Cuirot <chewi@ffaura.com>
To: linux-kernel@vger.kernel.org
Subject: IRQ INTR_SF lossage / mouse stops working
Message-ID: <20051109193224.16efda45@schwartz>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Since upgrading beyond 2.6.9, I've had several new problems on this
Sony Vaio PCG-K195HP. This has included random freezes every few days,
ACPI power stats not working and my USB mouse "disconnecting"
occasionally. I've tried all sorts of things to get to the bottom of it
but I haven't got far and I'm not ever sure if they're related.

I am now addressing the USB mouse problem because since switching to
2.6.14-suspend2 (was previously on 2.6.14-rc5-vanilla) it's happening
every few minutes instead of a couple of times a day. The mouse simply
stops working until I unplug it and plug it back in again. Once it even
happened twice in the space of a minute. It seems pretty random. This
is what appears in dmesg when it happens.

drivers/usb/input/hid-core.c: input irq status -75 received
usb 2-2: USB disconnect, address 9
ohci_hcd 0000:00:0c.0: IRQ INTR_SF lossage

I then plug it back in again.

usb 2-2: new low speed USB device using ohci_hcd and address 10
input: USB HID v1.00 Mouse [0461:4d03] on usb-0000:00:0c.0-2

Here is my /proc/bus/usb/devices...

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.14-suspend2 ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0000:00:0c.1
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
B:  Alloc= 11/900 us ( 1%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.14-suspend2 ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0000:00:0c.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0461 ProdID=4d03 Rev= 4.41
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 5
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.14-suspend2 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:0c.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

And my lspci...

00:00.0 Host bridge: ATI Technologies Inc RS200/RS200M AGP Bridge [IGP 340M] (rev 02)
00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M]
00:03.0 Modem: ALi Corporation M5457 AC'97 Modem Controller
00:04.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
00:06.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:09.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01)
00:0a.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
00:0a.2 FireWire (IEEE 1394): Texas Instruments PCI7x20 1394a-2000 OHCI Two-Port PHY/Link-Layer Controller
00:0a.3 Mass storage controller: <pci_lookup_name: buffer too small>
00:0c.0 USB Controller: NEC Corporation USB (rev 43)
00:0c.1 USB Controller: NEC Corporation USB (rev 43)
00:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 330M/340M/350M

And what the CONFIG_USB* stuff I have turned on in the kernel...

CONFIG_SND_USB_AUDIO=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_AIPTEK=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_CYPRESS_M8=m

I don't think there's anything wrong with the mouse. I'm not 100% sure
but I think I tried a different mouse a few months ago and it happened
with that one too. Could be wrong about that though. Any ideas?

James

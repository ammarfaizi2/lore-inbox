Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTEMSGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTEMSET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:04:19 -0400
Received: from franka.aracnet.com ([216.99.193.44]:32396 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263398AbTEMSDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:03:23 -0400
Date: Tue, 13 May 2003 09:01:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 714] New: HID driver causes slab corruption 
Message-ID: <30160000.1052841699@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: HID driver causes slab corruption
    Kernel Version: 2.5.69
            Status: NEW
          Severity: high
             Owner: greg@kroah.com
         Submitter: ken@krwtech.com


Distribution: custom
Hardware Environment: Athlon MP chipset, ohci chipset (AMD766), APC SmartUPS
1500 w/ USB
Software Environment: gcc 3.2.3, glibc 2.3.2
Problem Description: after probing the UPS, slab corruption occurs.

May 12 12:55:11 death kernel: hub 1-0:0: new USB device on port 1, assigned
address 2
May 12 12:55:11 death kernel: slab error in cache_free_debugcheck(): cache
`size-2048': double free, or memory before ob
ject was overwritten
May 12 12:55:11 death kernel: Call Trace:
May 12 12:55:11 death kernel:  [kfree+263/848] kfree+0x107/0x350
May 12 12:55:11 death kernel:  [hid_free_device+100/112] hid_free_device+0x64/0x70
May 12 12:55:11 death kernel:  [hid_free_device+100/112] hid_free_device+0x64/0x70
May 12 12:55:11 death kernel:  [hid_parse_report+406/480]
hid_parse_report+0x196/0x1e0
May 12 12:55:11 death kernel:  [usb_hid_configure+387/1872]
usb_hid_configure+0x163/0x750
May 12 12:55:11 death kernel:  [hid_probe+51/459] hid_probe+0x13/0x1cb
May 12 12:55:11 death kernel:  [usb_hotplug+561/592] usb_hotplug+0x231/0x250
May 12 12:55:11 death kernel:  [usb_device_probe+119/160] usb_device_probe+0x77/0xa0
May 12 12:55:11 death kernel:  [bus_match+69/128] bus_match+0x45/0x80
May 12 12:55:11 death kernel:  [device_attach+79/144] device_attach+0x4f/0x90
May 12 12:55:11 death kernel:  [bus_add_device+101/176] bus_add_device+0x65/0xb0
May 12 12:55:11 death kernel:  [device_add+210/256] device_add+0xd2/0x100
May 12 12:55:11 death kernel:  [usb_new_device+993/1328] usb_new_device+0x3e1/0x530
May 12 12:55:11 death kernel:  [usb_hub_port_connect_change+449/816]
usb_hub_port_connect_change+0x1c1/0x330
May 12 12:55:11 death kernel:  [usb_hub_events+908/1072] usb_hub_events+0x38c/0x430
May 12 12:55:11 death kernel:  [usb_hub_thread+53/240] usb_hub_thread+0x35/0xf0
May 12 12:55:11 death kernel:  [default_wake_function+0/32]
default_wake_function+0x0/0x20
May 12 12:55:11 death kernel:  [usb_hub_thread+0/240] usb_hub_thread+0x0/0xf0
May 12 12:55:11 death kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18
May 12 12:55:11 death kernel:
May 12 12:55:11 death kernel: slab error in cache_free_debugcheck(): cache
`size-2048': double free, or memory after  ob
ject was overwritten
May 12 12:55:11 death kernel: Call Trace:
May 12 12:55:11 death kernel:  [kfree+307/848] kfree+0x133/0x350
May 12 12:55:11 death kernel:  [hid_free_device+100/112] hid_free_device+0x64/0x70
May 12 12:55:11 death kernel:  [hid_free_device+100/112] hid_free_device+0x64/0x70
May 12 12:55:11 death kernel:  [hid_parse_report+406/480]
hid_parse_report+0x196/0x1e0
May 12 12:55:11 death kernel:  [usb_hid_configure+387/1872]
usb_hid_configure+0x163/0x750
May 12 12:55:11 death kernel:  [hid_probe+51/459] hid_probe+0x13/0x1cb
May 12 12:55:11 death kernel:  [usb_hotplug+561/592] usb_hotplug+0x231/0x250
May 12 12:55:11 death kernel:  [usb_device_probe+119/160] usb_device_probe+0x77/0xa0
May 12 12:55:11 death kernel:  [bus_match+69/128] bus_match+0x45/0x80
May 12 12:55:11 death kernel:  [device_attach+79/144] device_attach+0x4f/0x90
May 12 12:55:11 death kernel:  [bus_add_device+101/176] bus_add_device+0x65/0xb0
May 12 12:55:11 death kernel:  [device_add+210/256] device_add+0xd2/0x100
May 12 12:55:11 death kernel:  [usb_new_device+993/1328] usb_new_device+0x3e1/0x530
May 12 12:55:12 death kernel:  [usb_hub_port_connect_change+449/816]
usb_hub_port_connect_change+0x1c1/0x330
May 12 12:55:12 death kernel:  [usb_hub_events+908/1072] usb_hub_events+0x38c/0x430
May 12 12:55:12 death kernel:  [usb_hub_thread+53/240] usb_hub_thread+0x35/0xf0
May 12 12:55:12 death kernel:  [default_wake_function+0/32]
default_wake_function+0x0/0x20
May 12 12:55:12 death kernel:  [usb_hub_thread+0/240] usb_hub_thread+0x0/0xf0
May 12 12:55:12 death kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18
May 12 12:55:12 death kernel:
May 12 12:55:12 death kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4
status 0x101


here's the full output of /proc/bus/usb/devices (you'll note that despite
claiming itself as a HID device, the UPS doesn't have a driver in use)

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 4
B:  Alloc=  0/900 us ( 0%), #Int=  2, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
S:  Manufacturer=Linux 2.5.69 ohci-hcd
S:  Product=Advanced Micro Devic AMD-766 [ViperPlus]
S:  SerialNumber=00:07.4
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=051d ProdID=0002 Rev= 0.06
S:  Manufacturer=American Power Conversion
S:  Product=Smart-UPS 1500 FW:601.3.D USB FW:1.3
S:  SerialNumber=AS0218230520
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr= 30mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=   6 Ivl=100ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0451 ProdID=2046 Rev= 1.25
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0781 ProdID=0002 Rev= 0.09
S:  Manufacturer=SanDisk Corporation
S:  Product=ImageMate CompactFlash USB
S:  SerialNumber=000000000006
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

T:  Bus=01 Lev=02 Prnt=03 Port=01 Cnt=02 Dev#=  4 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03eb ProdID=3301 Rev= 3.00
S:  Product=Standard USB Hub
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr= 64mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=01 Lev=03 Prnt=04 Port=01 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=16 #Cfgs=  1
P:  Vendor=04e8 ProdID=300c Rev= 1.00
S:  Manufacturer=Samsung Electronics Co., Ltd.
S:  Product=Samsung Laser Printer ML-1200 Series
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=07(print) Sub=01 Prot=02 Driver=usblp
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms


Steps to reproduce:
plug in the UPS USB cable. Happens on boot if plugged in or after boot when
plugging it in. I tried the patch suggestion on linux-usb-devel but that made it
so it wasn't possible to finish booting. Boots cleanly with the cable unplugged


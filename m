Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVEIPIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVEIPIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 11:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVEIPIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 11:08:48 -0400
Received: from bay24-f10.bay24.hotmail.com ([64.4.18.60]:50235 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261403AbVEIPIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 11:08:21 -0400
Message-ID: <BAY24-F107E7535E65C2D54F61640B51E0@phx.gbl>
X-Originating-IP: [84.27.220.149]
X-Originating-Email: [theghostinc@hotmail.com]
From: "The Ghost" <theghostinc@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: USB mouse freezes when connected through USB KVM
Date: Mon, 09 May 2005 15:08:19 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 09 May 2005 15:08:20.0106 (UTC) FILETIME=[EF9AB6A0:01C554A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB mouse freezes when connected through USB KVM


My USB mouse freezes when connected through my USB KVM switch, after a small 
amount of time (minutes, sometimes seconds), the mouse stops responding, a 
switch to a console and back to Xorg restores the functionality. (for a 
limited time again)
But when using GPM, also GPM stops receiving input after a variable amount 
of time, a restart of GPM is necessary to regain functionality (for a 
limited time).
A hardware re-insert also does the trick for Xorg and GPM.
The same mouse bypassing the KVM switch doesn't give any problems, and keeps 
functioning.
In the case of 2 mice the mouse connected to the KVM stops working, the 
other mouse keeps working.

Reproducible... always.
It seems that during high load situations and/or using the keyboard makes 
the situation worse (read: faster, sometimes I can't even move it across the 
screen before a lock)
When a keep the mouse moving across the screen the situation gets better, 
until I stop for a moment, then the mouse freezes.

My setup is using a brand new Aten CS-64U USB KVM Switch (below is an exact 
description included)

I've tested the problem with different kernels (2.6.9, 2.6.11.x) no 
differences.
2 machines give the same result (specs lower included)
Using the latest default Gentoo installation, re-emerged this day.
A winXP machine (laptop) doesn't give this problem

Current kernel:
Linux version 2.6.11-gentoo-r7 (root@cp294907-a) (gcc version 3.3.5-20050130 
(Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #1 Fri May 6 
13:41:32 CEST 2005

Relevant kernel config:
USB device filesystem
UHCI HCD
USB HID support
HID input layer support

Power management disabled and enabled, made no difference

I've tried to output the data from
/dev/input/mice
to a console, this gives a lot of data during mouse movement until a freeze
During a freeze the output stops, because of this I suspect a kernel bug, 
otherwise the output would still come, right?

I've tried to study the USB HID code, but couldn't find the appropriate 
section to output the data of the USB connection. Perhaps someone can tell 
me were I can add some output functions to evaluate the USB functioning?

/proc/bus/usb/devices is included


Description of the KVM device:
ATEN CS-64U USB KVM switch 4 port.
The device has 4 connections, which all have 1 USB, 1 jack (audio) and 1 VGA 
connector.
2 USB input, 1 for keyboard, 1 for mouse. a audio jack and a VGA connector
The thing is keyboard controlled (no onscreen display)
When a pc is *not* selected the mouse is disconnected from that PC,
this is also detected by the OS (linux gives a disconnect)
When a pc is selected the mouse is reconnected and noted by the OS
(Linux gives a connect message and detects the mouse correctly)
The KVM also works as an USB hub, because both a keyboard and mouse are 
connected too 1 USB port per PC. I suspect the problem is located somewhere 
there, maybe the hub doesn't follow specs fully?

Descriptions of the tested systems:
Intel i810, 800Mhz Celeron, 512MB, SATA Fastrak
Intel i850e, 2,66Ghz P4(533fsb), 768MB, SATA Promise TX2, R9700pro
The windows XP pro machine is a centrino laptop.


/proc/bus/usb/devices:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=365/900 us (41%), #Int=  4, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.11-gentoo-r7 uhci_hcd
S:  Product=Intel Corp. 82801AA USB
S:  SerialNumber=0000:00:1f.2
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0557 ProdID=7000 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=200mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c30e Rev= 1.80
S:  Manufacturer=Logitech
S:  Product=HID compliant keyboard
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#= 11 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c00c Rev= 6.b4
S:  Manufacturer=Logitech
S:  Product=USB Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

ver_linux output:


Linux cp294907-a 2.6.11-gentoo-r7 #1 Fri May 6 13:41:32 CEST 2005 i686 
Celeron (Coppermine) GenuineIntel GNU/Linux

Gnu C                  3.3.5-20050130
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.4
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   045
Modules Loaded         i810


Thanks for reading so far,
if I can give more information, please ask.

Jeroen
Ps. I am a native dutch speaker, sorry for any linguistic mistakes.

_________________________________________________________________
On the road to retirement? Check out MSN Life Events for advice on how to 
get there! http://lifeevents.msn.com/category.aspx?cid=Retirement


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284645AbRLEU0s>; Wed, 5 Dec 2001 15:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284662AbRLEU0h>; Wed, 5 Dec 2001 15:26:37 -0500
Received: from smtp3.libero.it ([193.70.192.53]:17132 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S284645AbRLEU0b>;
	Wed, 5 Dec 2001 15:26:31 -0500
Date: Wed, 5 Dec 2001 21:04:20 +0100
From: Emmanuele Bassi <emmanuele.bassi@iol.it>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: PS/2 port on USB Keyboard
Message-ID: <20011205210420.A1581@wolverine.lohacker.net>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Vojtech Pavlik <vojtech@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-OS: Linux 2.4.17-pre2 i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have an USB Keyboard from BTC[1], with an onboard PS/2 mouse port.
When I use one of the mouse' buttons, the kernel complaints (with
a .warn):

keyboard.c: can't emulate rawmode for keycode 27[2-4]

The keycode depends on which mouse button I press (272 for the left,
273 for the right and 274 for the middle one). While I'm using the mouse
under X11, this warning goes straight into the logs, but while I'm
under the console, this warning scramble up everything. A possible
workaround is to disable every kernel.warn directed (via syslog) to the
console, but, for obvious reasons, I'd like to keep this as a "last
resort" option.

While looking inside the source code for the Keyboard HID driver, I've
noticed that only the Mac driver enables mouse button emulation. Since
I'm no kernel hacker, my question is: could someone work on a possible
patch?

TIA & best regards,
 Emmanuele.

+++

wolverine:~# cat /proc/bus/usb/devices
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=217/900 us (24%), #Int=  2, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=6400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046e ProdID=6782 Rev=21.10
S:  Manufacturer=BTC
S:  Product=USB Keyboard and Mouse

wolverine:~# usbmodules --device /proc/bus/usb/001/002
hid


-- 
Emmanuele Bassi (Zefram)               [ http://digilander.iol.it/ebassi ]
GnuPG Key fingerprint = 4DD0 C90D 4070 F071 5738  08BD 8ECC DB8F A432 0FF4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276759AbRJBWro>; Tue, 2 Oct 2001 18:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276762AbRJBWrf>; Tue, 2 Oct 2001 18:47:35 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:12160 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S276759AbRJBWra>; Tue, 2 Oct 2001 18:47:30 -0400
Date: Tue, 2 Oct 2001 18:47:57 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: mhw@wittsend.com
Subject: 2.4.10 and USB Modems...
Message-ID: <20011002184757.A32712@alcove.wittsend.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I just upgraded the kernel on a system which has 4 USB modems
(US Robotics 56K Voice/Fax modems).  The modems were recognized and
worked under 2.4.6 but under 2.4.10 they are not recognized and I get
and error that no driver claims them.  Further testing indicates that
they are recognized under 2.4.9 but broke sometime between then and 2.4.10.

	Here are the syslog USB messages from 2.4.9 (working):

] Oct  2 18:31:06 wittsend kernel: usb-ohci.c: USB OHCI at membase 0xc4846000, IRQ 9
] Oct  2 18:31:06 wittsend kernel: usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] M5237 USB
] Oct  2 18:31:06 wittsend kernel: usb.c: new USB bus registered, assigned bus number 1
] Oct  2 18:31:06 wittsend kernel: hub.c: USB hub found
] Oct  2 18:31:06 wittsend kernel: hub.c: 2 ports detected
] Oct  2 18:31:06 wittsend kernel: usb.c: registered new driver acm
] Oct  2 18:31:06 wittsend kernel: acm.c: v0.18:USB Abstract Control Model driver for USB modems and ISDN adapters
] Oct  2 18:31:06 wittsend kernel: hub.c: USB new device connect on bus1/2, assigned device number 2
] Oct  2 18:31:06 wittsend kernel: hub.c: USB hub found
] Oct  2 18:31:06 wittsend kernel: hub.c: 4 ports detected
] Oct  2 18:31:06 wittsend kernel: hub.c: USB new device connect on bus1/2/1, assigned device number 3
] Oct  2 18:31:06 wittsend kernel: ttyACM0: USB ACM device
] Oct  2 18:31:06 wittsend kernel: hub.c: USB new device connect on bus1/2/2, assigned device number 4
] Oct  2 18:31:06 wittsend kernel: ttyACM1: USB ACM device
] Oct  2 18:31:14 wittsend automount[10461]: starting automounter version 3.1.3, path = /mnt/longhall, maptype = file, mapname = /etc/auto.longhall
] Oct  2 18:31:15 wittsend automount[10461]: using kernel protocol version 3
] Oct  2 18:31:06 wittsend kernel: hub.c: USB new device connect on bus1/2/3, assigned device number 5
] Oct  2 18:31:06 wittsend kernel: ttyACM2: USB ACM device
] Oct  2 18:31:06 wittsend kernel: hub.c: USB new device connect on bus1/2/4, assigned device number 6
] Oct  2 18:31:06 wittsend kernel: ttyACM3: USB ACM device

	Here are the syslog USB messages from 2.4.10 (not working):

] Oct  2 17:53:25 wittsend kernel: usb-ohci.c: USB OHCI at membase 0xc4845000, IRQ 9
] Oct  2 17:53:25 wittsend kernel: usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] M5237 USB
] Oct  2 17:53:25 wittsend kernel: usb.c: new USB bus registered, assigned bus number 1
] Oct  2 17:53:25 wittsend kernel: hub.c: USB hub found
] Oct  2 17:53:25 wittsend kernel: hub.c: 2 ports detected
] Oct  2 17:53:25 wittsend kernel: usb.c: registered new driver acm
] Oct  2 17:53:25 wittsend kernel: acm.c: v0.20:USB Abstract Control Model driver for USB modems and ISDN adapters
] Oct  2 17:53:25 wittsend kernel: hub.c: USB new device connect on bus1/2, assigned device number 2
] Oct  2 17:53:25 wittsend kernel: hub.c: USB hub found
] Oct  2 17:53:25 wittsend kernel: hub.c: 4 ports detected
] Oct  2 17:53:25 wittsend kernel: hub.c: USB new device connect on bus1/2/1, assigned device number 3
] Oct  2 17:53:25 wittsend kernel: usb.c: USB device 3 (vend/prod 0x4c1/0x3021) is not claimed by any active driver.
] Oct  2 17:53:25 wittsend kernel: hub.c: USB new device connect on bus1/2/2, assigned device number 4
] Oct  2 17:53:25 wittsend kernel: usb.c: USB device 4 (vend/prod 0x4c1/0x3021) is not claimed by any active driver.
] Oct  2 17:53:25 wittsend kernel: hub.c: USB new device connect on bus1/2/3, assigned device number 5
] Oct  2 17:53:25 wittsend kernel: usb.c: USB device 5 (vend/prod 0x4c1/0x3021) is not claimed by any active driver.
] Oct  2 17:53:25 wittsend kernel: hub.c: USB new device connect on bus1/2/4, assigned device number 6
] Oct  2 17:53:25 wittsend kernel: usb.c: USB device 6 (vend/prod 0x4c1/0x3021) is not claimed by any active driver.

	More information from 2.4.9:

	/proc/bus/usb/drivers:

         usbdevfs
         hub
         acm

	/proc/bus/usb/devices:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=103/900 us (11%), #Int=  5, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB OHCI Root Hub
S:  SerialNumber=c4846000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 4
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0451 ProdID=1446 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
P:  Vendor=04c1 ProdID=3021 Rev= 0.82
S:  Manufacturer=3Com Inc.
S:  Product=U.S.Robotics 56000 Voice USB Modem
S:  SerialNumber=00560500000000A410131E0F0000
C:  #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=acm
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
C:* #Ifs= 2 Cfg#= 2 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=acm
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=acm
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
P:  Vendor=04c1 ProdID=3021 Rev= 0.82
S:  Manufacturer=3Com Inc.
S:  Product=U.S.Robotics 56000 Voice USB Modem
S:  SerialNumber=00560500000000A410131D090000
C:  #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=acm
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
C:* #Ifs= 2 Cfg#= 2 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=acm
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=acm
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=03 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
P:  Vendor=04c1 ProdID=3021 Rev= 0.82
S:  Manufacturer=3Com Inc.
S:  Product=U.S.Robotics 56000 Voice USB Modem
S:  SerialNumber=005605000000000E100D1A170000
C:  #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=acm
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
C:* #Ifs= 2 Cfg#= 2 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=acm
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=acm
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=04 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
P:  Vendor=04c1 ProdID=3021 Rev= 0.82
S:  Manufacturer=3Com Inc.
S:  Product=U.S.Robotics 56000 Voice USB Modem
S:  SerialNumber=005605000000000E100D1A020000
C:  #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=acm
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
C:* #Ifs= 2 Cfg#= 2 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=acm
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=acm
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms

	lsmod:

Module                  Size  Used by
acm                     5216   4 
usb-ohci               18400   0  (unused)
usbcore                47264   1  [acm usb-ohci]
ipchains               34368   0  (unused)
ip2main                41520   0 

	More information from 2.4.10:

	/proc/bus/usb/drivers:

         usbdevfs
         hub
         acm

	/proc/bus/usb/devices:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 11/900 us ( 1%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB OHCI Root Hub
S:  SerialNumber=c4845000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 4
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0451 ProdID=1446 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
P:  Vendor=04c1 ProdID=3021 Rev= 0.82
S:  Manufacturer=3Com Inc.
S:  Product=U.S.Robotics 56000 Voice USB Modem
S:  SerialNumber=00560500000000A410131E0F0000
C:* #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
C:  #Ifs= 2 Cfg#= 2 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=(none)
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
P:  Vendor=04c1 ProdID=3021 Rev= 0.82
S:  Manufacturer=3Com Inc.
S:  Product=U.S.Robotics 56000 Voice USB Modem
S:  SerialNumber=00560500000000A410131D090000
C:* #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
C:  #Ifs= 2 Cfg#= 2 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=(none)
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=03 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
P:  Vendor=04c1 ProdID=3021 Rev= 0.82
S:  Manufacturer=3Com Inc.
S:  Product=U.S.Robotics 56000 Voice USB Modem
S:  SerialNumber=005605000000000E100D1A170000
C:* #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
C:  #Ifs= 2 Cfg#= 2 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=(none)
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=04 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
P:  Vendor=04c1 ProdID=3021 Rev= 0.82
S:  Manufacturer=3Com Inc.
S:  Product=U.S.Robotics 56000 Voice USB Modem
S:  SerialNumber=005605000000000E100D1A020000
C:* #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
C:  #Ifs= 2 Cfg#= 2 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=(none)
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms

	lsmod:

Module                  Size  Used by
acm                     5024   0  (unused)
usb-ohci               17632   0  (unused)
usbcore                46176   1  [acm usb-ohci]
ipchains               29632   0 
ip2main                41168   0 


	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!


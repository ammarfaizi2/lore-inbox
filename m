Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291194AbSBQWep>; Sun, 17 Feb 2002 17:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291197AbSBQWeg>; Sun, 17 Feb 2002 17:34:36 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:8717 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S291194AbSBQWeV>; Sun, 17 Feb 2002 17:34:21 -0500
Message-ID: <3C702FE3.B914C0D@delusion.de>
Date: Sun, 17 Feb 2002 23:34:11 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5-pre1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Greg Kroah Hartmann <greg@kroah.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: khubd blocking in D state with 2.5.5-pre1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

Since 2.5.5-pre1 I'm using the normal UCHI driver (used the JE one before).

The USB system is as follows:

/proc/bus/usb/devices 
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 11/900 us ( 1%), #Int=  1, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=058f ProdID=9254 Rev= 1.00
S:  Manufacturer=ALCOR
S:  Product=Generic USB Hub
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=ff(vend.) Sub=ff Prot=ff MxPS=64 #Cfgs=  1
P:  Vendor=04b8 ProdID=0110 Rev= 1.10
S:  Manufacturer=EPSON
S:  Product=EPSON Scanner
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=usbscanner
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms

My monitor acts as USB hub. When the monitor is switched off and then back
on the khubd kernel thread blocks in D state:

PID TT       USER     COMMAND  TMOUT   F WCHAN   WCHAN
 12 ?        root     khubd        - 140 down   1075e6

dmesg shows:

hub.c: new USB device on bus 1 path /1, assigned address 2
hub.c: new USB device on bus 1 path /2, assigned address 3
hub.c: USB hub found at /2
hub.c: 5 ports detected
hub.c: new USB device on bus 1 path /2/1, assigned address 4
usb-uhci.c: interrupt, status 2, frame# 1932
usb.c: USB device not responding, giving up (error=-84)
hub.c: new USB device on bus 1 path /2/1, assigned address 5
usb.c: USB device 5 (vend/prod 0x56d/0x2) is not claimed by any active driver.
usb.c: USB disconnect on device 3

Is this a known problem?

Regards,
Udo.

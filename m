Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313336AbSDJQwn>; Wed, 10 Apr 2002 12:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313348AbSDJQwm>; Wed, 10 Apr 2002 12:52:42 -0400
Received: from smtp-out-7.wanadoo.fr ([193.252.19.26]:33769 "EHLO
	mel-rto7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313336AbSDJQwk>; Wed, 10 Apr 2002 12:52:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.5.8-pre3: kernel BUG at usb.c:849! (preempt_count 1)
Date: Wed, 10 Apr 2002 18:51:45 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16vHsQ-0000Jy-00@baldrick> <20020410114144.N8314@sventech.com> <06da01c1e0ae$69106ce0$6800000a@brownell.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>, rml@tech9.net,
        linux-usb-devel@lists.sourceforge.net,
        Johannes Erdfelt <johannes@erdfelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16vLJx-00028n-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 April 2002 6:40 pm, you wrote:
> > > UP x86 K6 system running 2.5.8-pre3 with preemption.
> > > Using usb-uhci.  I got the following bug when powering off:
> > >
> > > usb.c: USB disconnect on device 3
> > > ...
>
> Does the same BUG happen with "uhci"?

I haven't been able to reproduce it yet with usb-uhci...  I will try uhci
also.

> And what usb device driver(s) were supposed to have stopped
> using "device 3"?  I've only noticed such device refcounting bugs
> being caused by the USB device drivers with bad disconnect()
> routines, not usbcore or any of the host controller drivers, but of
> course that can change.

Ha!

$ cat /proc/bus/usb/drivers
         usbfs
         hub

There are no other drivers!  I have a USB webcam and a modem
attached.  I didn't compile the driver for the webcam, and the modem
has a user space driver that works via usbfs.

Duncan.

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=b800
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=ff(vend.) Sub=ff Prot=ff MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=0840 Rev= 1.00
S:  Product=Camera
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=16ms
I:  If#= 0 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=01(Isoc) MxPS=1023 Ivl=1ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=16ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=06b9 ProdID=4061 Rev= 0.00
S:  Manufacturer=ALCATEL
S:  Product=Speed Touch USB 
S:  SerialNumber=0090D02C2C5A
C:* #Ifs= 3 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbfs
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=50ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbfs
I:  If#= 1 Alt= 1 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbfs
E:  Ad=06(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 2 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbfs
E:  Ad=06(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 3 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbfs
E:  Ad=06(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=05(O) Atr=02(Bulk) MxPS=   8 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=   8 Ivl=0ms

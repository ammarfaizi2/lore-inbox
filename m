Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264070AbSIQMRF>; Tue, 17 Sep 2002 08:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264074AbSIQMRF>; Tue, 17 Sep 2002 08:17:05 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:16895 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S264070AbSIQMRE>; Tue, 17 Sep 2002 08:17:04 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Andreas Schuldei <andreas@schuldei.org>, greg@kroah.com
Subject: Re: usb keyboard registering twice
Date: Tue, 17 Sep 2002 22:15:51 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <20020917084303.GC2277@lukas>
In-Reply-To: <20020917084303.GC2277@lukas>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209172215.52034.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 17 Sep 2002 18:43, Andreas Schuldei wrote:
> i have here a usb keyboard which is registering once with the
> usb layer and twice with the input layer. Here is /proc/bus/usb/devices
<hubs snipped>
> T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=1.5 MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=045e ProdID=002b Rev= 1.11
> S:  Product=Microsoft Internet Keyboard Pro
> C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid
> E:  Ad=82(I) Atr=03(Int.) MxPS=   3 Ivl=10ms
This is the main keyboard. Note that it has two interfaces (I: lines), both 
associated with the hid driver. Also note that they are different (see Sub 
changes).

<more stuff snipped>

> and here is /proc/bus/input/devices
<devices snipped>
> I: Bus=0000 Vendor=0000 Product=0000 Version=0000
> N: Name="045e:002b"
> P: Phys=usb1:1.1/input1
> D: Drivers=kbd event1
> B: EV=10000a
> B: KEY=ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
> ffffffff ffffffff ffff0000 38000 39fa d843d7a9 9e0000 0 0 1
> B: ABS=1 0
>
> I: Bus=0000 Vendor=0000 Product=0000 Version=0000
> N: Name="045e:002b"
> P: Phys=usb1:1.1/input0
> D: Drivers=kbd event0
> B: EV=120002
> B: KEY=10000 0 ffe00000 7ff ffbeffdf ffffffff ffffffff fffffffe
> B: LED=7
>
>
> Here you see that the last two entries describe the same device.
Kind of. They actually describe the two interfaces on the device. The Sub on 
HID actually indicates that the keyboard is boot protocol compatible. Those 
multimedia keys on your keyboard can't be represented using boot protocol 
(refer to USB HID spec for details). So they appear as a different interface.
Which keys are on which interface should be obvious from the KEY lines :)

> Is this a bogus keyboard (As you can see it is a Microsoft
> product!), or is it the kernels responsibility to catch that?
It is a normal keyboard design. Logitech is the same.

> Would it be the usb layer or the input layer which is responsible
> to varify that the devices are unique?
Don't kid yourself. USB keyboards are not distinct, except for the physical 
topology. 

> In this case the USB layer cold have caught it, since the it is
> both at usb1:1.1. But why do they have different keys? is that a
> hardware feature like the mac-address in ethernet cards?
The KEY line is a bit mask describing the keys on the interface. The LED line 
and ABS lines are similar bitmasks.

> I am working with 2.4.19-backstreet-ruby, which is a backport of
> greater parts of the usb, input and console work from 2.5 to
> 2.4.19. And i do not expect anyone but me to fix this. I would be
> thankfull for any help regarding HOW it would be fixed, though.
Don't try to fix it. Enjoy it :)

Brad
- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9hxz3W6pHgIdAuOMRAhkRAJ4hv7oQv7ZQpq0/M/YgsRNjQqt73wCeM1vd
EvI3vb466hy82wQMmgI5ZOQ=
=FaYF
-----END PGP SIGNATURE-----


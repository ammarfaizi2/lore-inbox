Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUHCIr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUHCIr2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 04:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUHCIr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 04:47:27 -0400
Received: from smtp02.ya.com ([62.151.11.161]:6065 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S265245AbUHCIrF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 04:47:05 -0400
From: Luis Miguel =?iso-8859-1?q?Garc=EDa_Mancebo?= <ktech@wanadoo.es>
To: Greg KH <greg@kroah.com>
Subject: Re: USB troubles in rc2
Date: Tue, 3 Aug 2004 10:46:57 +0200
User-Agent: KMail/1.6.82
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net
References: <200408022100.54850.ktech@wanadoo.es> <20040803002634.GB26323@kroah.com>
In-Reply-To: <20040803002634.GB26323@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408031046.57137.ktech@wanadoo.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, sorry, here is the info:

I think the problem is with the ohci_hcd:
____________________________________________________________________________________
With 2.6.8-rc2-mm2 (and even with bk-usb.patch reverted), my digital camera 
don't work in usb-storage mode nor ptp mode. My usb tablet don't work either. 
And I get this (even the camera is on, but it don't appear):

root@evanescence / # cat /proc/bus/usb/devices

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.8-rc2-love3 ehci_hcd
S:  Product=nVidia Corporation nForce2 USB Controller
S:  SerialNumber=0000:00:02.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms
___________________________________________________________________________________

With 2.6.7-mm7 don't work either, but I can revert the bk-usb.patch in the 
andrew tree and all works ok. Even the camera:

root@evanescence /home/ktech # cat /proc/bus/usb/devices

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.7-love8-udev2 ehci_hcd
S:  Product=nVidia Corporation nForce2 USB Controller
S:  SerialNumber=0000:00:02.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.7-love8-udev2 ohci_hcd
S:  Product=nVidia Corporation nForce2 USB Controller (#2)
S:  SerialNumber=0000:00:02.1
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.7-love8-udev2 ohci_hcd
S:  Product=nVidia Corporation nForce2 USB Controller
S:  SerialNumber=0000:00:02.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=054c ProdID=0010 Rev= 4.10
S:  Manufacturer=Sony
S:  Product=Sony DSC
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=ff Prot=01 Driver=usb-storage
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=255ms


So I think the changes went mainstream, so I don't have nothing to revert now. 
If any of you want me to try something, please ask me (CC me as I'm not 
subscribed).

Thanks.


El Martes, 3 de Agosto de 2004 02:26, Greg KH escribió:
> On Mon, Aug 02, 2004 at 09:00:54PM +0200, Luis Miguel Garc?a Mancebo wrote:
> > Hello,
> >
> > 	I have a nforce2 motherboard. I have to report that recent changes in
> > usb code make my board don't work at all.
> >
> > 	In 2.6.7-mm7, I just reverted the bk-usb.patch and the things started to
> > work, but now it's on mainstream, so I cannot make it work.
> >
> > 	Do you want for me to do some tests?
>
> Yes please.  What exactly "does not work"?
>
> Also, let's cc: the linux-usb-devel mailing list to try to help out
> here...
>
> thanks,
>
> greg k-h

-- 
Luis Miguel García Mancebo
Universidad de Deusto / Deusto University
Spain

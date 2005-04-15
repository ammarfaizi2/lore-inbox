Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVDOMvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVDOMvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 08:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVDOMvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 08:51:23 -0400
Received: from ext-nj2gw-1.online-age.net ([216.35.73.163]:19655 "EHLO
	ext-nj2gw-1.online-age.net") by vger.kernel.org with ESMTP
	id S261447AbVDOMvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 08:51:13 -0400
Date: Fri, 15 Apr 2005 14:50:48 +0200
From: Karl Kiniger <karl.kiniger@med.ge.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.30 Oops when connecting external USB hard drive
Message-ID: <20050415125048.GA21076@wszip-kinigka.euro.med.ge.com>
References: <20050412173911.GA21311@wszip-kinigka.euro.med.ge.com> <20050414050243.GF7858@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414050243.GF7858@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 07:02:44AM +0200, Willy Tarreau wrote:
> You may try to unload the ehci-hcd driver and load only uhci and check if
> it still happens. I guess from the trace that the problem lies in the ehci
> driver itself.

Your guess is right. With only uhci loaded it works (dog slow of course).
When I then insmod the ehci-hcd driver: instant Oops.

Today I tried with another USB 2.0 enclosure w/o crash - it seems
to dislike especially the Seagate enclosure.

perhaps the output of cat /proc/bus/usb/devices gives some hint?
(BTW: what does the asterisk in the 'C:' lines mean?)

On the two "GE Med. Kretz" USB<>IDE devices there is 
a DVD recorder and a Maxtor HD connected, both are working fine
as long as nobody tries to plug in this particular Seagate.

What to do next? I have no clue about the innards of ehci-hcd....

Regards and thanks for trying to help,

Karl


T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0bc2 ProdID=0500 Rev= 0.00
S:  Manufacturer=Seagate
S:  Product=Seagate Mass Storage 
S:  SerialNumber=3JS461VN0000
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 11/900 us ( 1%), #Int=  1, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 4
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=04b4 ProdID=6560 Rev= 0.08
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=04ce ProdID=0002 Rev= 0.01
S:  Manufacturer=GE Med. Kretz
S:  Product=USB to IDE
S:  SerialNumber=DEF107F12FAB
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=04ce ProdID=0002 Rev= 0.01
S:  Manufacturer=GE Med. Kretz
S:  Product=USB to IDE
S:  SerialNumber=DEF107F12FC6
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms


> 
> Regards,
> willy
> 
> On Tue, Apr 12, 2005 at 07:39:11PM +0200, Kiniger wrote:
> > Pls see the hand-copied decoded backtrace.
[ deleted ]
-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47

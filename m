Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWGCOVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWGCOVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWGCOVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:21:45 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:15311 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751191AbWGCOVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:21:44 -0400
Date: Mon, 03 Jul 2006 10:21:24 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
In-reply-to: <44A8C0AB.3070904@goop.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Roland Dreier <rdreier@cisco.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Ken Brush <kbrush@gmail.com>
Message-id: <1151936484.3285.497.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<adad5cnderb.fsf@cisco.com> <1151872141.3285.486.camel@tahini.andynet.net>
	<44A8C0AB.3070904@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 00:00 -0700, Jeremy Fitzhardinge wrote:
> Andy Gay wrote:
> > BTW - Jeremy suggested that the number of EPs to configure should be
> > determined from the device ID. Makes sense to me, but then many users
> > may have no use for the additional EPs. Alternatively, Greg suggested
> > that maybe this should split into 2 drivers. Any preferences, anyone?
> >   
> I think if the hardware has the EPs, they should be exposed by the 
> driver.  You can tweak usermode as to whether they get device nodes, 
> what they're called, etc.
I tend to agree. I'm thinking for now I should leave it as is, so it
defaults to configuring 3 EPs. Perhaps later I'll try to collect #EP
info for all the supported devices.

> > I don't know which of these devices present multiple EPs though. Can you
> > send me the appropriate section from 'cat /proc/bus/usb/devices'?
> >   
> Phil Karn mentions on http://www.ka9q.net/5220.html:
> 
>     It may help to know what's actually inside the 5220 card. It
>     contains a Qualcomm MSM 5500 mobile station modem chip that
>     implements the actual 1xEV-DO functionality. This chip has a native
>     USB 1.1 interface that emulates two USB serial ports. The first
>     provides a classic serial modem interface that accepts AT commands
>     and PPP data. The second is reserved for diagnostics and is unused.
> 
> For completeness:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1199 ProdID=0218 Rev= 0.01
> S:  Manufacturer=Sierra Wireless
> S:  Product=Sierra Wireless MC5720 Modem
This is curious. I saw that '0218' in Greg's code, and 'corrected' it to
0018, because here's what I get with my MC5720:
P:  Vendor=1199 ProdID=0018 Rev= 0.01
S:  Manufacturer=Sierra Wireless
S:  Product=Sierra Wireless MC5720 Modem

So evidently there are also multiple variants of each modem.

> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 7 Cls=ff(vend.) Sub=ff Prot=ff Driver=airprime
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> 
> 
>     J


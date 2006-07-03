Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWGCRAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWGCRAt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWGCRAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:00:49 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:54221 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750808AbWGCRAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:00:48 -0400
Date: Mon, 03 Jul 2006 13:00:42 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
In-reply-to: <44A9459E.9070303@goop.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Roland Dreier <rdreier@cisco.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Ken Brush <kbrush@gmail.com>
Message-id: <1151946042.3285.537.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<adad5cnderb.fsf@cisco.com> <1151872141.3285.486.camel@tahini.andynet.net>
	<44A8C0AB.3070904@goop.org> <1151936484.3285.497.camel@tahini.andynet.net>
	<44A9459E.9070303@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 09:28 -0700, Jeremy Fitzhardinge wrote:
> Andy Gay wrote:
> >> I think if the hardware has the EPs, they should be exposed by the 
> >> driver.  You can tweak usermode as to whether they get device nodes, 
> >> what they're called, etc.
> >>     
> > I tend to agree. I'm thinking for now I should leave it as is, so it
> > defaults to configuring 3 EPs. Perhaps later I'll try to collect #EP
> > info for all the supported devices.
> >   
> 
> Why not just expose all the EPs the hardware presents?  Is there a 
> chance they might not be a serial connection?
Maybe. I believe it's possible to configure the Sierra kit to present an
NDIS interface. Not at all sure how that works. I'd have thought it
would be another layer on top of ppp, but who knows?

But I'm not sure I know how to do that anyway, without hardware to test
with.
For example, look at the info Roland sent me for his Kyocera:
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=airprime
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=airprime
E:  Ad=84(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

Which is somewhat different from the MC5720 results you and I get.
Notice it appears to show 2 interfaces, with 1 pair of in/out bulk EPs
on each. We see 1 interface with 3 pairs. I don't know if/how that
difference needs to be addressed in the driver.

I wonder if that's why Ken got 6 EPs. Perhaps his 580 card presents 2
interfaces, with 3 EPs each.

Also, I know how to drive the 2nd EP on the MC5720. So I can test that
it actually works. But I have to rely on information I can't disclose to
do that (pesky NDAs). I don't know anything about the 3rd EP. And if
there really are 6 EPs on the 580, how the heck do we test that...

Seems the deeper I dig here, the murkier this all gets. I'm inclined to
keep it simple for now, at least... Really, how many users need those
extra EPs?

> 
> > This is curious. I saw that '0218' in Greg's code, and 'corrected' it to
> > 0018, because here's what I get with my MC5720:
> >   
> 
> Yes, that patch was from me.
> 
> > P:  Vendor=1199 ProdID=0018 Rev= 0.01
> > S:  Manufacturer=Sierra Wireless
> > S:  Product=Sierra Wireless MC5720 Modem
> >
> > So evidently there are also multiple variants of each modem.
> >   
> My came embedded in a Thinkpad X60, and I think it is locked to 
> Verizon.  The product ID might reflect either or both of those states.
> 
>     J


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbUCTSmk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 13:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbUCTSmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 13:42:40 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:48138 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263503AbUCTSmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 13:42:38 -0500
Date: Sat, 20 Mar 2004 19:42:52 +0100
To: Willy Tarreau <willy@w.ods.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, RANDAZZO@ddc-web.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2 nics in the same machine...
Message-ID: <20040320184252.GA2016@hh.idb.hist.no>
References: <89760D3F308BD41183B000508BAFAC4104B17010@DDCNYNTD> <405ABA74.5030409@aitel.hist.no> <20040319223656.GF14537@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319223656.GF14537@alpha.home.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 11:36:56PM +0100, Willy Tarreau wrote:
> Hi,
> 
> On Fri, Mar 19, 2004 at 10:16:36AM +0100, Helge Hafting wrote:
>  
> > If you want to test NICs (or cables & hubs) do this:
> > 
> > 1. Run a packet sniffer on the "listening" NIC.  Run it in
> >   promiscuous mode so it'll even sniff packets not meant for it.
> > 
> > 2. Set a default route to the "sending" NIC.  Or at least a route
> >   to some network that isn't on your machine.
> > 
> > 3. Ping the remote network.  You will not get an answer, but:
> >   The packet will be sent through the "sending" NIC, 
> >   and sniffed by the "listening" NIC.  So you'll verify that
> >   NICs and cable works.  Optionally make a script that reverses
> >   the roles of the two NICs if you want to test both ways.
> 
> Nearly right. He will need to enter static ARP entries for this to
> work because his host will try to resolve the gateway's address first,
> so nothing except ARP will go out.
> 
I didn't think of that.  Of course, capturing an ARP broadcast is probably
good enough for testing cables.  One might want better than that
for testing the NIC driver though.

> DNAT out + SNAT in may be OK. I've used this setup in the past, but didn't
> not go on because of performance problems. Now, Julian Anastasov has written
> a wonderful patch named "send-to-self" which does the trick automagically.
> You can get it on his site ( http://www.ssi.bg/~ja/ IIRC ).
> 
> > If, on the other hand, you're testing apps/protocols, don't worry that 
> > the traffic don't hit the wire.  A test utilizing internal loopback
> > is just as good.
> 
> Right. Except that in some very weird cases, the higher MTU on loopback may
> affect the app's behaviour (less packets, or bigger reads at once, etc...).

ifconfig lo mtu 1500  :-)

Helge Hafting 

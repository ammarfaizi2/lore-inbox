Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUCSW4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbUCSW4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:56:31 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:12563 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263138AbUCSW43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:56:29 -0500
Date: Fri, 19 Mar 2004 23:36:56 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: RANDAZZO@ddc-web.com, linux-kernel@vger.kernel.org
Subject: Re: 2 nics in the same machine...
Message-ID: <20040319223656.GF14537@alpha.home.local>
References: <89760D3F308BD41183B000508BAFAC4104B17010@DDCNYNTD> <405ABA74.5030409@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405ABA74.5030409@aitel.hist.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 19, 2004 at 10:16:36AM +0100, Helge Hafting wrote:
 
> If you want to test NICs (or cables & hubs) do this:
> 
> 1. Run a packet sniffer on the "listening" NIC.  Run it in
>   promiscuous mode so it'll even sniff packets not meant for it.
> 
> 2. Set a default route to the "sending" NIC.  Or at least a route
>   to some network that isn't on your machine.
> 
> 3. Ping the remote network.  You will not get an answer, but:
>   The packet will be sent through the "sending" NIC, 
>   and sniffed by the "listening" NIC.  So you'll verify that
>   NICs and cable works.  Optionally make a script that reverses
>   the roles of the two NICs if you want to test both ways.

Nearly right. He will need to enter static ARP entries for this to
work because his host will try to resolve the gateway's address first,
so nothing except ARP will go out.

DNAT out + SNAT in may be OK. I've used this setup in the past, but didn't
not go on because of performance problems. Now, Julian Anastasov has written
a wonderful patch named "send-to-self" which does the trick automagically.
You can get it on his site ( http://www.ssi.bg/~ja/ IIRC ).

> If, on the other hand, you're testing apps/protocols, don't worry that 
> the traffic don't hit the wire.  A test utilizing internal loopback
> is just as good.

Right. Except that in some very weird cases, the higher MTU on loopback may
affect the app's behaviour (less packets, or bigger reads at once, etc...).

Cheers,
Willy


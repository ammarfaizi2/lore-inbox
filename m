Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUAZOag (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 09:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUAZOaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 09:30:35 -0500
Received: from mail.cyberus.ca ([209.197.145.21]:8665 "EHLO mail.cyberus.ca")
	by vger.kernel.org with ESMTP id S263600AbUAZOaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 09:30:30 -0500
Subject: Re: [RFC/PATCH] IMQ port to 2.6
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20040126135545.GA19497@usr.lcm.msu.ru>
References: <20040125152419.GA3208@penguin.localdomain>
	 <20040125164431.GA31548@louise.pinerecords.com>
	 <1075058539.1747.92.camel@jzny.localdomain>
	 <20040125202148.GA10599@usr.lcm.msu.ru>
	 <1075074316.1747.115.camel@jzny.localdomain>
	 <20040126001102.GA12303@usr.lcm.msu.ru>
	 <1075086588.1732.221.camel@jzny.localdomain>
	 <20040126093230.GA17811@usr.lcm.msu.ru>
	 <1075124312.1732.292.camel@jzny.localdomain>
	 <20040126135545.GA19497@usr.lcm.msu.ru>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1075127396.1746.370.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Jan 2004 09:29:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-26 at 08:55, Vladimir B. Savkin wrote:
> On Mon, Jan 26, 2004 at 08:38:33AM -0500, jamal wrote:

> > I cant say i doubt you, but your word alone is insufficient data ;->
> 
> You can see for youself. Police users' traffic to half of the normal rate
> and here them scream :) Then change policing to shaping using wrr
> (or htb class for each user), and sfq on the leafs, and users are happy.
> 

;-> Sorry I dont have time. But this could be a nice paper since
i havent seen this topic covered. If you want to write one i could
help provide you an outline.


> Well, I use wrr + sfq exactly for fairness. No such thing can be
> achieved with policing only.
> 

Thats what i was assuming. Shaping alone is insufficient as well.

> Here it is:
> 
>                     +---------+       +-ppp0- ... - client0
>                     |         +-eth1-<+-ppp1- ... - client1
> Internet ----- eth0-+ router  |     . . . . . . . .
>                     |         +-eth2-<  . . . . . .
>                     +---------+       +-pppN- ... - clientN
> 		    
> 
> Traffic flows from internet to clients. 
> The ethX names are for example only, my setup is more complex actually,
> but that complexity is not related to IMQ or traffic shaping.
> Clients use PPTP or PPPoE to connect to router.
> See, there's no single interface I can attach qdisc to, if I want
> to put all clients into the same qdisc. 
> 

So why cant you attach a ingress qdisc on eth1-2 and use policing to
mark excess traffic (not drop)? On eth0 all you do is based on the mark
you stash them on a different class i.e move the stuff you have on
IMQ0 to eth0.

Example on ingress:

meter1=" police index 1 rate $CIR1"
meter1a=" police index 2 rate $PIR1"

index 2 is shared by all flows for default.
index 1 (and others) is guaranteeing rate (20Kbps) for each of the flows
etc.
Look for example at examples/Edge32-ca-u32

The most important thing to know is that policers can be shared across 
devices, flows etc using the "index" operator.

I just noticed you are copying linux-kernel. Please take it off the list
in your response, this is a netdev issue. This should warn anyone
interested in the thread to join netdev.

cheers,
jamal


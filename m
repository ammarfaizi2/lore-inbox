Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSLJSHz>; Tue, 10 Dec 2002 13:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSLJSHz>; Tue, 10 Dec 2002 13:07:55 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:11990 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S263366AbSLJSHv>; Tue, 10 Dec 2002 13:07:51 -0500
Message-ID: <3DF62E42.5040607@drugphish.ch>
Date: Tue, 10 Dec 2002 19:11:14 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       jamal <hadi@cyberus.ca>
Subject: Re: hidden interface (ARP) 2.4.20 / network performance
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil>	<1039124530.18881.0.camel@rth.ninka.net>	<20021205140349.A5998@ns1.theoesters.com>	<3DEFD845.1000600@drugphish.ch>	<20021205154822.A6762@ns1.theoesters.com>	<3DF5C492.1070103@drugphish.ch> <20021210140912.7a9092b6.skraw@ithnet.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Could you please be more specific on what exactly you're trying to 
>>achieve? Do you want to load balance an application whose average 
>>package size is 80 bytes? How many sustained connections per seconds do 
>>you have?
>  
> Well, what I am trying to say is this: my experience is that under load with
> small sized packets even standard routing/packet forwarding becomes lossy. If I

That's a known fact, however I experienced Linux to perform the best in 
such worst case situations among several other Unices I tested, and NAPI 
certainly has brought some improvements in this area.

> put NAT and other nice netfilter features on top of such a situation things get
> a lot worse (obviously) - no comparison to building the "application" (e.g.
> cluster) with routing and hidden-patch (mainly because of its pure simplicity I
> guess).

I'm afraid but I don't understand what you mean with the second part of 
your statement.

> Don't get me wrong: I am pretty content with the hidden-patch and my setup
> without NAT. But I wanted to point to the direction of possible further routing
> performance improvement in 2.4.X tree. Is it correct that I can expect higher

Huh? Routing performance improvements? Routing is almost possible at 
wire speed. Some 60us delay per packet maybe (in case of load balancing 
decisions) but what do you want to improve?

I agree with you that netfilter NAT performance should and possibly can 
be impoved. And people are working on proof-of-concept improvements of 
NAPT in the Linux kernel including the netfilter team. But again, for me 
the hidden patch (http://www.ssi.bg/~ja/hidden-2.4.20pre10-1.diff) as it 
can be found does nothing to improve your situation.

> data-rates (concerning small packets) if using higher HZ ?

I doubt this would help much but I haven't tested it and I do not see 
all consequences on the routing, the routing cache and the FIB policy of 
modifying HZ. I couldn't comment on that.

> Someone selling E3 cards told me he cannot manage loads like these (small
> packet stuff) with a stock kernel, and that you _at least_ have to increase HZ
> to get acceptable throughput results.

Now that certainly is interesting, does he have any nice numbers to back 
this up? I'd be very interested. Also I've cc'd Jamal (I hope he will 
forgive me for that) who's working in this field since a couple of years 
now. Maybe he can comment on the HZ changes.

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc


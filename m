Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266760AbSLJKhW>; Tue, 10 Dec 2002 05:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSLJKhW>; Tue, 10 Dec 2002 05:37:22 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:48844 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S266760AbSLJKhT>; Tue, 10 Dec 2002 05:37:19 -0500
Message-ID: <3DF5C4B5.3030205@drugphish.ch>
Date: Tue, 10 Dec 2002 11:40:53 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
References: <Pine.LNX.3.96.1021209200239.9066D-100000@gatekeeper.tmr.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Maybe I should first note that I am not against the hidden patch at all, 
I just accepted that it won't go in. I use it on an almost daily basis.

> In spite of vast resistance from some developers, it is highly desirable
> on some systems to force a packet with a given source IP out an interface
> which has that IP assigned. With this capability it is possible to make a

Yes, source address selection based on different rules and routing 
tables. What does it have to do with the hidden patch?

> single machine with multiple NICs behave like two machines with individual
> NICs. This also solves ARP issues, although it's a much more general
> thing.

Yes.

> Think development, think debug, think UML virtual machines, or a machine
> with multiple boundary routers which are addressed to separate NICs. The

Ok, I've quite a few boxes running that way.

> usual proxy_arp fix doesn't really address these cases. If I have multiple
> default routes, the router on which the packet arrived is likely to be on
> the route with the fewest hops, randomly using another route doesn't help.

??? Depends how you use those multiple default routes. If you do nexthop 
routing you do sort of RR balancing on preferred routes. If you do 
source address selection routing based on rules you have fixed default 
routes which will not match because of the fewest hops but because of 
the rule. I am a bit confused as to what you're trying to tell me.

> Source routing takes too much overhead for lots of connections, and as I

Either we have a different view of source routing or I have to ask you 
why you think there is too much overhead with source routing.

> recall is limited to 256 rules. I'm not sure the hidden interface patch
> really does this, although I just looked quickly.

The hidden patch doesn't do source routing and the limit of available 
source routes is 254 but not because of the rules (you can have 2**16 
rule entries) but because of the amount of routing tables which is 256 
[0..255] minus local table minus main table which equals to 254 tables.

> Patches like the hidden interface will continue as long as there are
> useful things people want to do with Linux and can't. It's one of many in

Yes, that's the nice thing about patches, isn't it :).

> the networking area. I don't expect them to be adopted in the main kernel,
> but as long as they're easier than making multiple configs, particularly
> at runtime, they will be around.

Yes, definitely. And I think noone has said anything against that.

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSLJSLw>; Tue, 10 Dec 2002 13:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264785AbSLJSLw>; Tue, 10 Dec 2002 13:11:52 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:3317 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S264760AbSLJSLs>; Tue, 10 Dec 2002 13:11:48 -0500
Message-ID: <3DF62F2F.3030805@drugphish.ch>
Date: Tue, 10 Dec 2002 19:15:11 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
References: <Pine.LNX.3.96.1021210093408.12210B-100000@gatekeeper.tmr.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Yes, source address selection based on different rules and routing 
>>tables. What does it have to do with the hidden patch?
>  
>   I see it as an alternative solution to the problem the hidden patch is
> addressing. Perhaps a more general one, although the method of causing
> such routing might not be source routing in the "ip" sense.

Ohh, now I see where you're coming from. You mean the additional 
blackhole routes you need to add on every box that need to mimic the 
'non-arp parlance' or the 'do not choose this address for reply', right?

>>??? Depends how you use those multiple default routes. If you do nexthop 
>>routing you do sort of RR balancing on preferred routes. If you do 
>>source address selection routing based on rules you have fixed default 
>>routes which will not match because of the fewest hops but because of 
>>the rule. I am a bit confused as to what you're trying to tell me.
>  
> I have in mid multiple ISPs for redundancy, perhaps a pair of OC12s or
> similar. Sites would be reachable from either, but fewer hops to one or
> the other. When the client connects, it avoids asymmetric routing to reply
> on the same router.

I understand everything but the last sentence. You have a couple of 
redundant ISP links which can all act as a router to the Internet, the 
only difference is that if you go over some of them you need less hops. 
Now in order to avoid asymmetric routing you need the hidden patch? I 
apologise for being so narrow minded but I still don't get it.

>>>Source routing takes too much overhead for lots of connections, and as I
>>
>>Either we have a different view of source routing or I have to ask you 
>>why you think there is too much overhead with source routing.
>  
> More rules, more overhead, having to set up a rule per IP (which can be
> dynamic) takes overhead.

Only if you change your rules once every 1000 packets maybe but other 
than that I doubt there is a significant overhead to the hidden patch. I 
would denote the overhead as being something in the range of O(log N), 
with N being the amount of routes. The way I understand the source 
address selection algorithm efficiency for routing decision is that you 
look up the fast routing cache and if there is no hit you try to find 
the preferred route by walking the tree-like structure of rules and 
their according routes. Of course you have a worst case bounce table 
walking if every rule matches but no route in the according table can be 
selected (this would be a pretty stupid setup to begin with). This would 
mean a complete walk through all routing tables until you have a 
preferred match. In this case it is 0(N) but after that it is in the 
routing cache and therefore O(1) again :).

Please anyone correct me if I'm wrong.

>>>recall is limited to 256 rules. I'm not sure the hidden interface patch
>>>really does this, although I just looked quickly.
>>
>>The hidden patch doesn't do source routing and the limit of available 
>>source routes is 254 but not because of the rules (you can have 2**16 
>>rule entries) but because of the amount of routing tables which is 256 
>>[0..255] minus local table minus main table which equals to 254 tables.
>  
> I actually meant that the patch didn't do this in another way, but you
> have noted that the number of routing tables is limited. That may or may
> not be a limitation depending on complexity. In any case a single
> use-configured-interface patch avoids having tables.

That is something I certainly agree with you.

>>>the networking area. I don't expect them to be adopted in the main kernel,
>>>but as long as they're easier than making multiple configs, particularly
>>>at runtime, they will be around.
>>
>>Yes, definitely. And I think noone has said anything against that.
>  
> I thought this thread had a "please don't post patches like that we don't
> want it in the kernel" early on in the thread, but I've expired the
> message and lack time to dig archives.

You're right. After rereading my email I think I owe the original poster 
my apology for those rather harsh words. He even cc'd Julian who is the 
author and maintainer of those patches.

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc


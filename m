Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317511AbSFMIqm>; Thu, 13 Jun 2002 04:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317528AbSFMIql>; Thu, 13 Jun 2002 04:46:41 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:52990 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S317511AbSFMIqk>; Thu, 13 Jun 2002 04:46:40 -0400
Message-Id: <5.1.0.14.2.20020613183120.03222cb8@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 13 Jun 2002 18:44:20 +1000
To: David Schwartz <davids@webmaster.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: RFC: per-socket statistics on received/dropped packets
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        "David S. Miller" <davem@redhat.com>,
        Ben Greear <greearb@candelatech.com>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>, jamal <hadi@cyberus.ca>
In-Reply-To: <20020613072155.AAA14363@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >i know of many many folk who use transaction logs from HTTP caches for
> >volume-based billing.
> >right now, those bills are anywhere between 10% to 25% incorrect.
>
>         You are being paid to deliver packets to their destination, not 
> to drop
>them.

ho hum.
yes, that is typically true of a transit provider.
however, the transit provider wants to charge the customer not just for 
what is delivered to layer-7, but also for packetization overhead at 
layer-2/layer-3/layer-4.  after all, the IP+TCP packet headers are 
delivered to the client as well, no?

this is just my point: there is NO method to account for those pesky headers!


also, think of the case where a HTTP Proxy _isn't_ in the path of 
traffic.  from this side of the Pacific, if there are TCP retransmissions, 
they are end-to-end retransmissions, across that really expensive piece of 
wet string otherwise known as an undersea cable.  _that_ is the most 
expensive hop and if a customer is congested on the last mile, they're 
still eating into the expensive bandwidth!

discussions on the layer-8 (religion) or layer-9 (politics) aspects of 
whether it is correct to bill based on that is irrelevant.  what is 
relevant is that there isn't any mechanism to count the overhead of 
packetization or the overhead of using a "reliable stream transport" such 
as TCP.

i do have the code to do this.  its relatively trivial and consumes an 
extra 8 bytes of RAM per socket.
it doesn't obfuscate the existing kernel code nor does it slow the code 
down by any tangible amount.
it is a compile-time option so for those people who don't know or care 
about it, it doesn't impact them at all.
yet, clearly, Dave and Jamal are vehemently opposed to it.
alas, that means it stays as an out-of-kernel patch and will likely 
continue to suffer bit-rot as time goes by.  c'est la vie.


cheers,

lincoln.


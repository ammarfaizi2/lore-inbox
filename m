Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317569AbSFMKKi>; Thu, 13 Jun 2002 06:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317523AbSFMKKi>; Thu, 13 Jun 2002 06:10:38 -0400
Received: from mail.webmaster.com ([216.152.64.131]:6318 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317510AbSFMKKh> convert rfc822-to-8bit; Thu, 13 Jun 2002 06:10:37 -0400
From: David Schwartz <davids@webmaster.com>
To: <ltd@cisco.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
        "David S. Miller" <davem@redhat.com>,
        Ben Greear <greearb@candelatech.com>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>, jamal <hadi@cyberus.ca>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Thu, 13 Jun 2002 03:10:35 -0700
In-Reply-To: <5.1.0.14.2.20020613183120.03222cb8@mira-sjcm-3.cisco.com>
Subject: Re: RFC: per-socket statistics on received/dropped packets
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020613101036.AAA25884@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jun 2002 18:44:20 +1000, Lincoln Dale wrote:

>>You are being paid to deliver packets to their destination, not
>>to drop
>>them.

>ho hum.
>yes, that is typically true of a transit provider.
>however, the transit provider wants to charge the customer not just for
>what is delivered to layer-7, but also for packetization overhead at
>layer-2/layer-3/layer-4.  after all, the IP+TCP packet headers are
>delivered to the client as well, no?

	Actually, the customer really only cares about payload. And if the overhead 
is a constant ratio to the data, just adjust the rate and it all comes out in 
the wash. The only reason to care is if you want to play games, such as 
saying you charge the same rate 'per byte' as another provider when you 
really don't.

>this is just my point: there is NO method to account for those pesky 
>headers!

	No is there any need to. Do you really need to differentially account for 
customers who have more 'overhead bytes per data byte' than others? Or can 
you just say it's 12% and raise/lower your rates 12%

>also, think of the case where a HTTP Proxy _isn't_ in the path of
>traffic.  from this side of the Pacific, if there are TCP retransmissions,
>they are end-to-end retransmissions, across that really expensive piece of
>wet string otherwise known as an undersea cable.  _that_ is the most
>expensive hop and if a customer is congested on the last mile, they're
>still eating into the expensive bandwidth!

	But accounting for the retransmissions won't help you, because you can't 
tell retransmissions that the customer should rightly pay for versus 
retransmissions that he shouldn't. So again, you can't do any better than to 
just work it into the base price.

>discussions on the layer-8 (religion) or layer-9 (politics) aspects of
>whether it is correct to bill based on that is irrelevant.  what is
>relevant is that there isn't any mechanism to count the overhead of
>packetization or the overhead of using a "reliable stream transport" such
>as TCP.

	I realize that, but I don't see what good it is. So yes, it's something 
that's currently hard to do, but if there's no legitimate need, then it 
doesn't matter whether it's hard or not. You pose problems and you pose a 
solution, but unless you can show that the solution actually solves the 
problem, the solution is of no value.

>i do have the code to do this.  its relatively trivial and consumes an
>extra 8 bytes of RAM per socket.
>it doesn't obfuscate the existing kernel code nor does it slow the code
>down by any tangible amount.
>it is a compile-time option so for those people who don't know or care
>about it, it doesn't impact them at all.
>yet, clearly, Dave and Jamal are vehemently opposed to it.
>alas, that means it stays as an out-of-kernel patch and will likely
>continue to suffer bit-rot as time goes by.  c'est la vie.

	Well, show them a real-world problem that it solves. Show a case where you 
can't bill fairly without it and you can bill fairly with it. ... If you can.

	DS



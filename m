Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268295AbTCADI4>; Fri, 28 Feb 2003 22:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268222AbTCADI4>; Fri, 28 Feb 2003 22:08:56 -0500
Received: from mx02.cyberus.ca ([216.191.240.26]:519 "EHLO mx02.cyberus.ca")
	by vger.kernel.org with ESMTP id <S268212AbTCADIx>;
	Fri, 28 Feb 2003 22:08:53 -0500
Date: Fri, 28 Feb 2003 22:18:51 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org, "" <netdev@oss.sgi.com>,
       "" <linux-net@vger.kernel.org>
Subject: Re: anyone ever done multicast AF_UNIX sockets?
In-Reply-To: <3E5F748E.2080605@nortelnetworks.com>
Message-ID: <20030228212309.C57212@shell.cyberus.ca>
References: <3E5E7081.6020704@nortelnetworks.com> <20030228083009.Y53276@shell.cyberus.ca>
 <3E5F748E.2080605@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Feb 2003, Chris Friesen wrote:

>  From lmbench local communication tests:
>
> This is a multiproc 1GHz G4
> Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
>                          ctxsw       UNIX         UDP         TCP conn
> --------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
> pcary0z0. Linux 2.4.18- 0.600 3.756 6.58  10.2  26.4  13.8  36.9 599K
> pcary0z0. Linux 2.4.18- 0.590 3.766 6.43  10.1  26.7  13.9  37.2 59.1
>
>
> This is a 400MHz uniproc G4
> Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
>                          ctxsw       UNIX         UDP         TCP conn
> --------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
> zcarm0pd. Linux 2.2.17- 1.710 9.888 21.3  26.4  59.4  43.0 105.4 146.
> zcarm0pd. Linux 2.2.17- 1.740 9.866 22.2  26.3  60.4  43.1 106.7 147.
>
> This is a 1.8GHz P4
> Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
>                          ctxsw       UNIX         UDP         TCP conn
> --------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
> pcard0ks. Linux 2.4.18- 1.740  10.4 15.9  20.1  33.1  23.5  44.3 72.7
> pcard0ks. Linux 2.4.18-        10.3 16.1  19.8  36.3  22.8  43.6 74.1
> pcard0ks. Linux 2.4.18- 1.560  10.6 16.0  23.4  38.1  36.1  44.6 77.4
>
>
>  From these numbers, UDP has 18%-44% higher latency than AF_UNIX, with
> the difference going up as the machine speed goes up.
>

Did you also measure throughput?
You are overlooking the flexibility that already exists in IP based
transports as an advantage; the fact that you can make them
distributed instead of localized with a simple addressing change
is a very powerful abstraction.


> Aside from that, IP multicast doesn't seem to work properly.  I enabled
> multicast on lo and disabled it on eth0, and a ping to 224.0.0.1 still
> got responses from all the multicast-capable hosts on the network.

I think you may have something misconfigured.

> From
> userspace, multicast unix would be *simple* to use, as in totally
> transparent.
>

You could implement the abstraction in user space as a library today by
having some server that muxes to several registered clients.

> The other reason why I would like to see this happen is that it just
> makes *sense*, at least to me. We've got multicast IP, so multicast
> unix for local machine access is a logical extension in my books.
>

So whats the addressing scheme for multicast unix? Would it be a
reserved path?
I am actually indifferent: You could do this in user space for starters.
See if it buys you anything. Maybe you could do somethign clever with
passing unix file descriptors around to avoid a single server point of
failure etc.

> Do we agree at least that some form of multicast is the logical solution
> to the case of one sender/many listeners?
>

Thats what mcast definition is. You need to weigh your options; cost is
probably worth the flexibility you get with sockets.

cheers,
jamal

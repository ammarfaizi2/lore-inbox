Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267984AbTAIWCT>; Thu, 9 Jan 2003 17:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267993AbTAIWCT>; Thu, 9 Jan 2003 17:02:19 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:65522 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267984AbTAIWCS> convert rfc822-to-8bit;
	Thu, 9 Jan 2003 17:02:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>,
       <linux-kernel@vger.kernel.org>, <mbligh@aracnet.com>
Subject: Re: [2.5] IRQ distribution in the 2.5.52  kernel
Date: Thu, 9 Jan 2003 16:08:38 -0600
User-Agent: KMail/1.4.3
Cc: "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
References: <E88224AA79D2744187E7854CA8D9131DA5CE59@fmsmsx407.fm.intel.com>
In-Reply-To: <E88224AA79D2744187E7854CA8D9131DA5CE59@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301091608.38445.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> > test again with/without HT.
> >
> > Here are the results:
> >
> > 4P, no HT, 1 x e1000, no kirq:	1214 Mbps, 4% idle
> > 4P, no HT, 1 x e1000, kirq:		1223 Mbps, 4% idle,
>
> +0.74%
> [NK] It is surprising to see single e1000 is giving bandwidth more than
> 1Gbps. What can be the reason for this extra bandwidth? ... Maybe
> compression is happening somewhere.

Full duplex.  I suppose theoretical full throughput is 2Gbps.  Sar reported 
about 1174 Mb/sec with one adapter on one of these results above, and it was 
454 Recv/720 Tx (I had the percentages incorrectly swapped in previous 
email).  This is still with an MTU of 1500!
  
> > I suppose we didn't see much of an improvement here because we never
>
> >
> > 4P, HT, 1 x e1000, no kirq:	1214 Mbps, 25% idle
> > 4P, HT, 1 x e1000, kirq:	1220 Mbps, 30% idle,
>
>
> >
> > 4P, HT, 2 x e1000, no kirq:	1269 Mbps, 23% idle
> > 4P, HT, 2 x e1000, kirq:	1329 Mbps, 18% idle
>
> +4.7%
> [NK] It can be a case that throughput is getting limited by the network
> infrastructure or total load of clients. If we know the theoretical
> desired maximum throughput then we will get a better idea about the
> bottleneck. It would be interesting to see the results, after adding one
> more e1000 card to the server.

It occurred to me later, the answer was obvious, the one you mentioned: 
clients.  I originally had enough clients to accomplish 1000 Mbps, but I'm 
pretty sure 44 client will not cut it for NetBench at around 1500 Mbps (where 
this hopefully will end up).  NetBench throttles the clients, so I really 
can't drive them much harder.  There is an option to simulate more than one 
client per computer, but I have had trouble in the past with that, but I am 
going to give it one more try. 
>
> > OK, almost 5% better!
>
> [NK] It's a pretty good number!


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266520AbUGPOqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUGPOqP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 10:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUGPOqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 10:46:14 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:34438 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266520AbUGPOp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 10:45:58 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] reduce inter-node balancing frequency
Date: Fri, 16 Jul 2004 10:45:38 -0400
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       John Hawkes <hawkes@sgi.com>
References: <200407151829.20069.jbarnes@engr.sgi.com> <2700000.1089956404@[10.10.2.4]> <40F76D3F.8050309@yahoo.com.au>
In-Reply-To: <40F76D3F.8050309@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407161045.38983.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 16, 2004 1:53 am, Nick Piggin wrote:
> I'm going to cut a patch to consolidate the arch setup code in a
> bit. It would be easy to just not define SD_NODE_INIT at all in
> generic code. I expect that won't go down too well at this stage
> though ;)

It's fine with me, as long as you move it to an arch specific header at the 
same time (i.e. don't functionally change it while you move code around).

> Well I think the main thing is that you do not want a global domain
> with 512 CPUs in it, even if it is very rarely balanced.
>
> Apart from having to pull hot cachelines off 511 CPUs while in interrupt
> context, it just doesn't make sense: It could easily move a task to a
> node that is  x (=large) hops away.
>
> It is probably way too much complexity to try to model your topology in
> any amount of detail at this stage, but it could be made smarter.
>
> Instead of a top level domain spanning all CPUs, have each CPU's top level
> domain just span all CPUs within a couple of hops (enough to get, say 16 to
> 64 CPUs into each top level domain). I could give you a hand with this if
> you need.

Yeah, that's what I had in mind.  I'll wait for the patch you mentioned above 
and hack on top of that...

For sn2 at least, there are quite a few ways we could dice up the topology.  
We'll have to experiment with things a bit to find some good defaults.

Thanks,
Jesse


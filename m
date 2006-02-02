Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423060AbWBBIsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423060AbWBBIsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423384AbWBBIsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:48:32 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:11787 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1423060AbWBBIsb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:48:31 -0500
Date: Thu, 2 Feb 2006 19:48:24 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060202084824.GA17299@gondor.apana.org.au>
References: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au> <20060131.024323.83813817.davem@davemloft.net> <20060201133219.GA1435@elte.hu> <20060201202610.GA13107@gondor.apana.org.au> <20060202074627.GA6805@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202074627.GA6805@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 08:46:27AM +0100, Ingo Molnar wrote:
> 
> yeah, it should have. In any case, things are looking good so far with 
> your fixes. (Any suggestions wrt. how to trigger as many different 
> codepaths in the networking code as possible, to increase coverage of 
> locking scenarios mapped? I've tried LTP so far, and a few ad-hoc tests.  
> Perhaps there's some IP protocol tester i should try, which is known to 
> trigger lots of boundary conditions?)

Two paths you might want to cover are netfilter and IPsec.  Both of these
can be tested by simply adding netfilter rules and IPsec policies/SAs and
then running the same test you were using before.

You might also want to look at multicast but I don't know of any good
tests for that.

Oh and then there are VLANs, bridging, Ethernet bonding, qdisc's, etc.
Again these can be tested by setting up the relevant devices or rules
and running the usual TCP/UDP tests.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbVBFG7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbVBFG7e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 01:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbVBFG7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 01:59:33 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:22291 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S267333AbVBFGyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 01:54:03 -0500
Date: Sun, 6 Feb 2005 17:53:40 +1100
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: davem@davemloft.net, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050206065340.GE16057@gondor.apana.org.au>
References: <20050205201044.1b95f4e8.davem@davemloft.net> <20050206.133723.124822665.yoshfuji@linux-ipv6.org> <20050205210411.7e18b8e6.davem@davemloft.net> <20050206.143107.39728239.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206.143107.39728239.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 02:31:07PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> 
> Here, lo is going down.
> rt->rt6i_dev = lo and rt->rt6i_idev = ethX.
> I think we already see dst->dev == dev (==lo)  now.
> So, I doubt that fix the problem.
> 
> The source of problem is entry (*) which still on routing entry,
> not on gc list. And, the owner of entry is not routing table but
> unicast/anycast address structure(s).
> We need to "kill" active address on the other interfaces.
> 
> *: rt->rt6i_dev = lo and rt->rt6i_idev = ethX

Sorry I don't think this is right.  Although lo going down is
required to cause those symptoms, it is not the trigger.

The problem only occurs when eth0 itself is unregistered.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

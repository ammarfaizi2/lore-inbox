Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268098AbVBFHE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268098AbVBFHE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 02:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbVBFHE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 02:04:58 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:32787 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268370AbVBFHBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 02:01:24 -0500
Date: Sun, 6 Feb 2005 18:00:50 +1100
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: davem@davemloft.net, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050206070050.GF16057@gondor.apana.org.au>
References: <20050206.133723.124822665.yoshfuji@linux-ipv6.org> <20050205210411.7e18b8e6.davem@davemloft.net> <20050206.143107.39728239.yoshfuji@linux-ipv6.org> <20050206.145007.34543324.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206.145007.34543324.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 02:50:07PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> 
> Which means in addrconf_notiry(), if the dev == &loopback_dev,
> call addrconf_ifdown for every device like this:

This should fix the reported issue.  However, I'm not sure if it's
a good idea to stop all IP traffic when lo goes down.  We don't do
that for IPv4.

Besides, we'll still need to fix the rt6i_idev GC issue since the
same bug can occur when eth0 goes down and some appliation is holding
a dst to a local address route.  It can become a dead-lock if the
said application then invokes a syscall that takes the RTNL.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

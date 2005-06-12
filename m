Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVFLNyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVFLNyT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVFLNvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:51:36 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:1287 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262609AbVFLNum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:50:42 -0400
Date: Sun, 12 Jun 2005 23:50:18 +1000
To: Willy Tarreau <willy@w.ods.org>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612135018.GA10910@gondor.apana.org.au>
References: <20050611195144.GF28759@alpha.home.local> <20050612081327.GA24384@gondor.apana.org.au> <20050612083409.GA8220@alpha.home.local> <20050612103020.GA25111@gondor.apana.org.au> <20050612114039.GI28759@alpha.home.local> <20050612120627.GA5858@gondor.apana.org.au> <20050612123253.GK28759@alpha.home.local> <20050612131323.GA10188@gondor.apana.org.au> <20050612133349.GA6279@gondor.apana.org.au> <20050612134725.GB8951@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612134725.GB8951@alpha.home.local>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 03:47:25PM +0200, Willy Tarreau wrote:
> 
> Yes, but only if there's an ACK and the ACK is exactly equal to snd_next,
> so the connection will survive.

Sorry I wasn't thinking straight.

> 
> > My point is that there are many ways to kill TCP connections in ways
> > similar to what you proposed initially so it isn't that special.
> 
> No, there are plenty of ways to kill TCP connections when you can guess
> the window (which is more and more easy thanks to window scaling). But
> I have yet found no way to kill a TCP session without this info, except
> by exploiting the simultaneous connect feature.

I still stand by this point though.  The most obvious thing I can think
of right now is to change your attack to simply connect to kernel.org's
webserver first from source port 10000.  That will cause the real SYN
packet to fail the sequence number check.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

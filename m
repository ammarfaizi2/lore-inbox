Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVFKTwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVFKTwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVFKTwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:52:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:22028 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261783AbVFKTwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:52:16 -0400
Date: Sat, 11 Jun 2005 21:51:44 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050611195144.GF28759@alpha.home.local>
References: <20050611074350.GD28759@alpha.home.local> <E1DhBic-0005dp-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DhBic-0005dp-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Sun, Jun 12, 2005 at 05:32:34AM +1000, Herbert Xu wrote:
> Willy Tarreau <willy@w.ods.org> wrote:
> > 
> > During this, the client cannot connect to www.kernel.org from this port
> > anymore :
> >  wks$ printf "HEAD / HTTP/1.0\r\n\r\n" | nc -p 10000 204.152.191.5 80; echo "ret=$?"
> >  ret=1
> 
> What if you let the client connect from a random port which is what it
> should do?

Of course, if the port chosen by the client is not in the range probed by
the attacker, everything's OK. My point is that relying *only* on a port
number is a bit limitative. It is even more when some protocols only bind
to privileged source ports, or always use the same port range at boot (eg:
a router establishing a BGP connection to the ISP's router).

Please note that if I only called it "small DoS", it's clearly because
I don't consider this critical, but I think that most people involved
in security will find that DoSes based on port guessing should be
addressed when possible.

Regards,
Willy


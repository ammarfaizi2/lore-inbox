Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWFLGmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWFLGmX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 02:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWFLGmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 02:42:23 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:14354 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751003AbWFLGmW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 02:42:22 -0400
Date: Mon, 12 Jun 2006 16:41:22 +1000
To: Ingo Molnar <mingo@elte.hu>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Valdis.Kletnieks@vt.edu,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.17-rc5-mm3-lockdep -
Message-ID: <20060612064122.GA1101@gondor.apana.org.au>
References: <200606060250.k562oCrA004583@turing-police.cc.vt.edu> <44852819.2080503@gmail.com> <4485798B.4030007@s5r6.in-berlin.de> <4485AFB9.3040005@s5r6.in-berlin.de> <20060607071208.GA1951@gondor.apana.org.au> <20060612063807.GA23939@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612063807.GA23939@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 08:38:07AM +0200, Ingo Molnar wrote:
> 
> yeah. I'll investigate - it's quite likely that sk_receive_queue.lock 
> will have to get per-address family locking rules - right?

Yes that's the issue.

> Maybe it's enough to introduce a separate key for AF_UNIX alone (and 
> still having all other protocols share the locking rules for 
> sk_receive_queue.lock) , by reinitializing its spinlock after 
> sock_init_data()?

This could work.  AF_UNIX is probably the only family that does not
interact with hardware.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

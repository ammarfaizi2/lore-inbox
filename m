Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVFLNeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVFLNeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVFLNeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:34:16 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:60422 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262532AbVFLNeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:34:12 -0400
Date: Sun, 12 Jun 2005 23:33:49 +1000
To: Willy Tarreau <willy@w.ods.org>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612133349.GA6279@gondor.apana.org.au>
References: <20050611074350.GD28759@alpha.home.local> <E1DhBic-0005dp-00@gondolin.me.apana.org.au> <20050611195144.GF28759@alpha.home.local> <20050612081327.GA24384@gondor.apana.org.au> <20050612083409.GA8220@alpha.home.local> <20050612103020.GA25111@gondor.apana.org.au> <20050612114039.GI28759@alpha.home.local> <20050612120627.GA5858@gondor.apana.org.au> <20050612123253.GK28759@alpha.home.local> <20050612131323.GA10188@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612131323.GA10188@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 11:13:23PM +1000, herbert wrote:
> On Sun, Jun 12, 2005 at 02:32:53PM +0200, Willy Tarreau wrote:
> >
> > but it's not the case (although the naming is not clear). So if the remote
> > end was the one which sent the SYN-ACK, it will clear its session. If it has
> > been spoofed, it will ignore the RST because in turn, the SEQ will not be
> > within its window.
> 
> This is what should happen:

Sorry, you're right.  The SEQ check should catch this.

However, a few lines down in that same function there is a th->rst
check which will kill the connection just as effectively.

My point is that there are many ways to kill TCP connections in ways
similar to what you proposed initially so it isn't that special.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

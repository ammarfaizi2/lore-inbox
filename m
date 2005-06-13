Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVFMFWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVFMFWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 01:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVFMFWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 01:22:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:47628 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261360AbVFMFWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 01:22:06 -0400
Date: Mon, 13 Jun 2005 07:21:48 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050613052148.GF8907@alpha.home.local>
References: <20050612103020.GA25111@gondor.apana.org.au> <20050612114039.GI28759@alpha.home.local> <20050612120627.GA5858@gondor.apana.org.au> <20050612123253.GK28759@alpha.home.local> <20050612131323.GA10188@gondor.apana.org.au> <20050612133349.GA6279@gondor.apana.org.au> <20050612134725.GB8951@alpha.home.local> <20050612135018.GA10910@gondor.apana.org.au> <20050612142401.GA10772@alpha.home.local> <20050613044810.GA32103@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613044810.GA32103@gondor.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 02:48:10PM +1000, Herbert Xu wrote:
> On Sun, Jun 12, 2005 at 04:24:01PM +0200, Willy Tarreau wrote:
> >
> > 1) no firewall in front of A
> >   - C spoofs A and sends a fake SYN to B
> >   - B responds to A with a SYN-ACK
> >   - A sends an RST to B, which clears the session
> >   - A wants to connect and sends its SYN to B which accepts it.
> 
> Well the attacker simply has to keep sending the same SYN packet
> over and over again until A runs out of SYN retries.
> 
> What I really don't like about your patch is the fact that it is
> trying to impose a policy decision (that of forbidding all
> simultaneous connection initiations) inside the TCP stack.

It's the same for ECN or SYN cookies.

> A much better place to do that is netfilter.  If you do it there
> then not only will your protect all Linux machines from this attack,
> but you'll also protect all the other BSD-derived TCP stacks.

Netfilter already blocks simultaneous connection. A SYN in return to
a SYN produces an INVALID state.

Cheers,
Willy


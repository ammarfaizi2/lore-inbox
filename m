Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVFMGSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVFMGSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 02:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVFMGSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 02:18:12 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:49164 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261375AbVFMGSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 02:18:06 -0400
Date: Mon, 13 Jun 2005 08:17:48 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050613061748.GA13144@alpha.home.local>
References: <20050612120627.GA5858@gondor.apana.org.au> <20050612123253.GK28759@alpha.home.local> <20050612131323.GA10188@gondor.apana.org.au> <20050612133349.GA6279@gondor.apana.org.au> <20050612134725.GB8951@alpha.home.local> <20050612135018.GA10910@gondor.apana.org.au> <20050612142401.GA10772@alpha.home.local> <20050613044810.GA32103@gondor.apana.org.au> <20050613052148.GF8907@alpha.home.local> <20050613052404.GA7611@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613052404.GA7611@gondor.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 03:24:04PM +1000, Herbert Xu wrote:
> On Mon, Jun 13, 2005 at 07:21:48AM +0200, Willy Tarreau wrote:
> > 
> > > A much better place to do that is netfilter.  If you do it there
> > > then not only will your protect all Linux machines from this attack,
> > > but you'll also protect all the other BSD-derived TCP stacks.
> > 
> > Netfilter already blocks simultaneous connection. A SYN in return to
> > a SYN produces an INVALID state.
> 
> Any reason why that isn't enough?

I don't think there are a lot of people who load ip_conntrack and insert
a single DROP rule on their servers just to workaround weaknesses in the
TCP stack. If they did, they would not be more confident into netfilter
either because it would be logical to expect the same reasoning (eg: let's
not fix XX here, TCP will catch it).

What's the problem with the sysctl ? If you prefer, I can change the patch
to keep the feature enabled by default so that only people aware of the
problem have to fix it by hand. But I found it better the other way : people
who need the feature enable it by hand.

Cheers,
willy


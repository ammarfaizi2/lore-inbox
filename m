Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVERRCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVERRCV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVERRCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:02:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:44465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262380AbVERRBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:01:09 -0400
Date: Wed, 18 May 2005 10:00:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
       Linux Audit Discussion <linux-audit@redhat.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Chris Wright <chrisw@osdl.org>
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context at mm/slab.c:2502
Message-ID: <20050518170033.GT27549@shell0.pdx.osdl.net>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu> <20050517165528.GB27549@shell0.pdx.osdl.net> <1116349464.23972.118.camel@hades.cambridge.redhat.com> <20050517174300.GE27549@shell0.pdx.osdl.net> <20050518083002.GA30689@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518083002.GA30689@gondor.apana.org.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Xu (herbert@gondor.apana.org.au) wrote:
> Guys, please CC netdev on issues like this.

Sorry Herbert, we hadn't yet concluded that it's not an issue that we
need to resolve within audit.

> On Tue, May 17, 2005 at 05:43:00PM +0000, Chris Wright wrote:
> > 
> > This has some issues w.r.t. truesize and socket buffer space.  The trim
> > is done to keep accounting sane, so we'd either have to trim ourselves
> > or take into account the change in size.  And ultimately, we'd still get
> > trimmed by netlink, so the GFP issue is still there.  Ideally, gfp_any()
> > would really be _any_
> 
> The trimming is completely optional.  That is, if the allocation fails
> nothing bad will happen.  So the solution is to simply use GFP_ATOMIC.

Well, it does more pressure on atomic pool (for those cases that
GFP_KERNEL would have sufficed).

thanks,
-chris

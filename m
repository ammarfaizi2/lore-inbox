Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVERVax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVERVax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVERVax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:30:53 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:39432 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262394AbVERVa0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:30:26 -0400
Date: Thu, 19 May 2005 07:29:47 +1000
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Audit Discussion <linux-audit@redhat.com>, netdev@oss.sgi.com,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context at mm/slab.c:2502
Message-ID: <20050518212947.GA20204@gondor.apana.org.au>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu> <20050517165528.GB27549@shell0.pdx.osdl.net> <1116349464.23972.118.camel@hades.cambridge.redhat.com> <20050517174300.GE27549@shell0.pdx.osdl.net> <20050518083002.GA30689@gondor.apana.org.au> <20050518170033.GT27549@shell0.pdx.osdl.net> <1116438756.25594.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116438756.25594.76.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 06:52:35PM +0100, David Woodhouse wrote:
> 
> I've reverted your recent change to put audit messages directly into
> skbs "in order to eliminate the extra copy", on the basis that it
> blatantly wasn't having that effect anyway. Now we copy from the
> audit_buffer into an optimally-sized skb which netlink_trim() won't have
> to mangle. I've also removed the skb_get() immediately before
> netlink_send() which always made me unhappy.

Even if the audit code is never going to call netlink_unicast with
spin locks held, we simply cannot assume that for all current and
future users of netlink_unicast.

As a consequence we can't use gfp_any() in netlink_unicast.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

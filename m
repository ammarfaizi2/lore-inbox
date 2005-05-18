Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVERRy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVERRy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVERRy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:54:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63722 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262169AbVERRy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:54:56 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@oss.sgi.com,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050518170033.GT27549@shell0.pdx.osdl.net>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
	 <20050517165528.GB27549@shell0.pdx.osdl.net>
	 <1116349464.23972.118.camel@hades.cambridge.redhat.com>
	 <20050517174300.GE27549@shell0.pdx.osdl.net>
	 <20050518083002.GA30689@gondor.apana.org.au>
	 <20050518170033.GT27549@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 18 May 2005 18:52:35 +0100
Message-Id: <1116438756.25594.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.8 RCVD_IN_SORBS_WEB      RBL: SORBS: sender is a abuseable web server
	[193.113.235.174 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[193.113.235.174 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 10:00 -0700, Chris Wright wrote:
> * Herbert Xu (herbert@gondor.apana.org.au) wrote:
> > Guys, please CC netdev on issues like this.
> 
> Sorry Herbert, we hadn't yet concluded that it's not an issue that we
> need to resolve within audit.

I suspect that it _is_ an issue we can resolve entirely within audit
code. See the patch I posted half an hour or so ago to the linux-audit
list. If we agree on that approach, I'll do the equivalent for the git
tree either later this evening or tomorrow.

I've reverted your recent change to put audit messages directly into
skbs "in order to eliminate the extra copy", on the basis that it
blatantly wasn't having that effect anyway. Now we copy from the
audit_buffer into an optimally-sized skb which netlink_trim() won't have
to mangle. I've also removed the skb_get() immediately before
netlink_send() which always made me unhappy.

-- 
dwmw2


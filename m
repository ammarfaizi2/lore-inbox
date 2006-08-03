Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWHCSzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWHCSzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWHCSzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:55:50 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:12717 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S964855AbWHCSzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:55:49 -0400
Date: Thu, 3 Aug 2006 11:55:44 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Arjan van de Ven <arjan@infradead.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net, linville@tuxdriver.com, jt@hpl.hp.com
Subject: Re: orinoco driver causes *lots* of lockdep spew
Message-ID: <20060803185544.GA12062@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1154607380.2965.25.camel@laptopd505.fenrus.org> <E1G8der-0001fm-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1G8der-0001fm-00@gondolin.me.apana.org.au>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 11:54:41PM +1000, Herbert Xu wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> > 
> > this is another one of those nasty buggers;
> 
> Good catch.  It's really time that we fix this properly rather than
> adding more kludges to the core code.
> 
> Dave, once this goes in you can revert the previous netlink workaround
> that added the _bh suffix.
> 
> [WIRELESS]: Send wireless netlink events with a clean slate
> 
> Drivers expect to be able to call wireless_send_event in arbitrary
> contexts.  On the other hand, netlink really doesn't like being
> invoked in an IRQ context.  So we need to postpone the sending of
> netlink skb's to a tasklet.

	Yes, this was needed. I really like the way you implemented
it, simple and efficient. Go for it !

> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au> 

	For what it's worth :
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

> Cheers,

	Thanks !

	Jean

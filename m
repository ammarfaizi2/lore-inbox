Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWHCUBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWHCUBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWHCUBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:01:06 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:22797 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1030215AbWHCUBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:01:04 -0400
Date: Thu, 3 Aug 2006 15:53:13 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Arjan van de Ven <arjan@infradead.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net, jt@hpl.hp.com
Subject: Re: orinoco driver causes *lots* of lockdep spew
Message-ID: <20060803195306.GB7079@tuxdriver.com>
References: <1154607380.2965.25.camel@laptopd505.fenrus.org> <E1G8der-0001fm-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1G8der-0001fm-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.1i
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
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au> 

Does anyone have any objection to Herbert's patch?  It seems
appropriate to me.

Arjan, did you convince yourself whether or not this patch actually
resolves the problem at hand?  Applying it makes sense to me either
way, but it would be nice to believe it fixed a known issue. :-)

John
-- 
John W. Linville
linville@tuxdriver.com

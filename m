Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVIZROc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVIZROc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVIZROc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:14:32 -0400
Received: from host-84-9-200-79.bulldogdsl.com ([84.9.200.79]:30339 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932392AbVIZROb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:14:31 -0400
Date: Mon, 26 Sep 2005 18:14:18 +0100
From: Ben Dooks <ben@fluff.org>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/2]: explicitly set minimum packet length to ETH_ZLEN
Message-ID: <20050926171418.GB3500@home.fluff.org>
References: <87oe6fhj8y.fsf@coraid.com> <87hdc7ept7.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hdc7ept7.fsf@coraid.com>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 12:50:28PM -0400, Ed L Cashin wrote:
> "Ed L. Cashin" <ecashin@coraid.com> writes:
> 
> ...
> > Explicitly set the minimum packet length to ETH_ZLEN.
> >
> > Index: 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c
> > ===================================================================
> > --- 2.6.14-rc2-aoe.orig/drivers/block/aoe/aoecmd.c	2005-09-26 12:20:34.000000000 -0400
> > +++ 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c	2005-09-26 12:27:49.000000000 -0400
> > @@ -20,6 +20,9 @@
> >  {
> >  	struct sk_buff *skb;
> >  
> > +	if (len < ETH_ZLEN)
> > +		len = ETH_ZLEN;
> > +
> >  	skb = alloc_skb(len, GFP_ATOMIC);
> 
> This change fixes some strange problems observed on a system that was
> using the e1000 network driver.  Is the network driver supposed to
> ensure that ethernet packets are up to spec, at least 60 bytes long?

I belive that 802.3 defines that a packet should be
of at least 64 octets. I belive most ethernet controllers
should consider anything smaller as a `runt`, but as
usual, YMMV.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

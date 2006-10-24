Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbWJXSUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWJXSUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbWJXSUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:20:49 -0400
Received: from hera.kernel.org ([140.211.167.34]:61676 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1161134AbWJXSUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:20:48 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 1/5] netpoll: use sk_buff_head for txq
Date: Tue, 24 Oct 2006 07:14:51 -0700
Organization: OSDL
Message-ID: <20061024071451.2ba1b79c@freekitty>
References: <20061020153027.3bed8c86@dxpl.pdx.osdl.net>
	<20061022.204220.78710782.davem@davemloft.net>
	<20061023120253.5dd146d2@dxpl.pdx.osdl.net>
	<20061023.230350.05157566.davem@davemloft.net>
	<20061024075130.6e4cf8d2@dads-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1161714016 20273 10.8.0.54 (24 Oct 2006 18:20:16 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 24 Oct 2006 18:20:16 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2006 07:51:30 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> On Mon, 23 Oct 2006 23:03:50 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Stephen Hemminger <shemminger@osdl.org>
> > Date: Mon, 23 Oct 2006 12:02:53 -0700
> > 
> > > +	spin_lock_irqsave(&netpoll_txq.lock, flags);
> > > +	for (skb = (struct sk_buff *)netpoll_txq.next;
> > > +	     skb != (struct sk_buff *)&netpoll_txq; skb = next) {
> > > +		next = skb->next;
> > > +		if (skb->dev == dev) {
> > > +			skb_unlink(skb, &netpoll_txq);
> > > +			kfree_skb(skb);
> > > +		}
> > >  	}
> > > +	spin_unlock_irqrestore(&netpoll_txq.lock, flags);
> > 
> > IRQ's are disabled, I think we can't call kfree_skb() in such a
> > context.
> 
> It is save since the skb's only come from this code (no destructors).
> 
Actually it does use destructors... I am doing a better version (per-device).

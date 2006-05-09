Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWEIXgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWEIXgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWEIXgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:36:12 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:57730 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932225AbWEIXgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:36:10 -0400
Date: Tue, 9 May 2006 16:39:11 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       netdev@vger.kernel.org
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Message-ID: <20060509233911.GI24291@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085201.446830000@sous-sol.org> <20060509115633.36b4879e@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509115633.36b4879e@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Hemminger (shemminger@osdl.org) wrote:
> The stuff in /proc could easily just be added attributes to the class_device kobject
> of the net device (and then show up in sysfs).

Agreed, it's on the todo list to drop proc support there.  Thought that
was marked in the patch.

> > +#define GRANT_INVALID_REF	0
> > +
> > +#define NET_TX_RING_SIZE __RING_SIZE((struct netif_tx_sring *)0, PAGE_SIZE)
> > +#define NET_RX_RING_SIZE __RING_SIZE((struct netif_rx_sring *)0, PAGE_SIZE)
> > +
> > +static inline void init_skb_shinfo(struct sk_buff *skb)
> > +{
> > +	atomic_set(&(skb_shinfo(skb)->dataref), 1);
> > +	skb_shinfo(skb)->nr_frags = 0;
> > +	skb_shinfo(skb)->frag_list = NULL;
> > +}
> 
> Could you use existing sk_buff_head instead of inventing your
> own skb queue?

Hmm, there is some standard skb_queue_tail happening.  I don't have a
clear idea what you mean.

> > +	u8 mac[ETH_ALEN];
> 
> Isn't mac address already stored in dev->dev_addr and/or dev->perm_addr?

Yes, I don't see the reason to keep in twice.  It's basically a temp
buffer, but it certainly appears we can eliminate it.

thanks,
-chris

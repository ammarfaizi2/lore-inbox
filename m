Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWHIOLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWHIOLp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWHIOLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:11:45 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:35996 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750880AbWHIOLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:11:44 -0400
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Thomas Graf <tgraf@suug.ch>
Cc: Daniel Phillips <phillips@google.com>, David Miller <davem@davemloft.net>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060809131942.GY14627@postel.suug.ch>
References: <20060808193345.1396.16773.sendpatchset@lappy>
	 <20060808211731.GR14627@postel.suug.ch> <44D93BB3.5070507@google.com>
	 <20060808.183920.41636471.davem@davemloft.net>
	 <44D976E6.5010106@google.com>  <20060809131942.GY14627@postel.suug.ch>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 16:07:20 +0200
Message-Id: <1155132440.12225.70.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 15:19 +0200, Thomas Graf wrote:
> * Daniel Phillips <phillips@google.com> 2006-08-08 22:47
> > David Miller wrote:
> > >From: Daniel Phillips <phillips@google.com>
> >  >>Can you please characterize the conditions under which skb->dev changes
> > >>after the alloc?  Are there writings on this subtlety?
> > >
> > >The packet scheduler and classifier can redirect packets to different
> > >devices, and can the netfilter layer.
> > >
> > >The setting of skb->dev is wholly transient and you cannot rely upon
> > >it to be the same as when you set it on allocation.
> > >
> > >Even simple things like the bonding device change skb->dev on every
> > >receive.
> > 
> > Thankyou, this is easily fixed.
> 
> It's not that simple, in order to just fix the most obvious case
> being packet forwarding when skb->dev changes its meaning from
> device the packet is coming from to device the packet will be leaving
> on is difficult.
> 
> You can't unreserve at that point so you need to keep the original
> skb->dev. Since the packet is mostly likely queued before freeing
> you will lose the refcnt on the original skb->dev. Keeping a
> refcnt just for this memalloc stuff is out of question. Even keeping
> the ifindex on a best effort basis is unlikely an option, sk_buff is
> way overweight already.

I think Daniel was thinking of adding struct net_device *
sk_buff::alloc_dev,
I know I was after reading the first few mails. However if adding a
field 
there is strict no-no....

/me takes a look at struct sk_buff

Hmm, what does sk_buff::input_dev do? That seems to store the initial
device?



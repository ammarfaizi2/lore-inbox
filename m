Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVFPWwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVFPWwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVFPWv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:51:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36583
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261872AbVFPWsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:48:53 -0400
Date: Thu, 16 Jun 2005 15:48:38 -0700 (PDT)
Message-Id: <20050616.154838.41634341.davem@davemloft.net>
To: jesper.juhl@gmail.com, juhl-lkml@dif.dk
Cc: linux-kernel@vger.kernel.org, laforge@netfilter.org, sfrost@snowman.net
Subject: Re: Shouldn't we be using alloc_skb/kfree_skb in
 net/ipv4/netfilter/ipt_recent.c::ip_recent_ctrl ?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506170025140.2477@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506170025140.2477@dragon.hyggekrogen.localhost>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <juhl-lkml@dif.dk>
Date: Fri, 17 Jun 2005 00:36:04 +0200 (CEST)

> I was just grep'ing through the source looking for places where skb's 
> might be freed by plain kfree() and, amongst other things, I noticed 
> net/ipv4/netfilter/ipt_recent.c::ip_recent_ctrl, where a struct sk_buff* 
> is defined and then storage for it is allocated with kmalloc() and freed 
> with kfree(), and I'm wondering if we shouldn't be using 
> alloc_skb/kfree_skb instead (as pr the patch below)? Or is there some good 
> reason for doing it the way it's currently done?

It's using it to send a dummy packet to the patch function.
It is gross, but it does work because it allocated it's own
private data area to skb->nh.iph.

Just leave it alone for now, ipt_recent is gross and full of many
errors and bug, and thus stands to have a rewrite. Patrick McHardy
said he will try to do that.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVFTAT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVFTAT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 20:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVFTAT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 20:19:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52884
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261350AbVFTATS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 20:19:18 -0400
Date: Sun, 19 Jun 2005 17:18:13 -0700 (PDT)
Message-Id: <20050619.171813.104659699.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: kaber@trash.net, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netfilter-devel@manty.net,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
Subject: Re: 2.6.12: connection tracking broken?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
References: <42B56D9B.9070401@trash.net>
	<E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 20 Jun 2005 10:05:42 +1000

> Patrick McHardy <kaber@trash.net> wrote:
> >
> > The bridge-netfilter code defers calling of some NF_IP_* hooks to the
> > bridge layer, when the conntrack reference is already gone, so the entry
> 
> Why does it defer them at all? Shouldn't the fact that the device is
> bridged be transparent to the IP layer?

The bridge netfilter layer uses netif_rx(skb) at the deepest level in
order to avoid too deep stack usage.

This is also why the NF_HOOK*() macros were semantically changed
a little bit several months ago.

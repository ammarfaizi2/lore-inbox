Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWBCBGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWBCBGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWBCBF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:05:59 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32470
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751239AbWBCBF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:05:59 -0500
Date: Thu, 02 Feb 2006 17:01:27 -0800 (PST)
Message-Id: <20060202.170127.38871682.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: mingo@elte.hu, davem@redhat.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe ->
 soft-unsafe lock dependency
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060201104214.GA9085@gondor.apana.org.au>
References: <20060131102758.GA31460@gondor.apana.org.au>
	<20060131212432.GA18812@elte.hu>
	<20060201104214.GA9085@gondor.apana.org.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 1 Feb 2006 21:42:14 +1100

> OK this is definitely broken.  We should never touch the dst lock in
> softirq context.  Since inet6_destroy_sock may be called from that
> context due to the asynchronous nature of sockets, we can't take the
> lock there.
> 
> In fact this sk_dst_reset is totally redundant since all IPv6 sockets
> use inet_sock_destruct as their socket destructor which always cleans
> up the dst anyway.  So the solution is to simply remove the call.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Looks good, applied, thanks Herbert.

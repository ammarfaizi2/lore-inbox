Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVFMXZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVFMXZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVFMXX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 19:23:29 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23427
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261635AbVFMXVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 19:21:45 -0400
Date: Mon, 13 Jun 2005 16:20:52 -0700 (PDT)
Message-Id: <20050613.162052.41635836.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: jesper.juhl@gmail.com, mru@inprovide.com, rommer@active.by,
       bernd@firmix.at, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: udp.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050613230422.GA7269@gondor.apana.org.au>
References: <E1Dhwho-0001mn-00@gondolin.me.apana.org.au>
	<20050613.145716.88477054.davem@davemloft.net>
	<20050613230422.GA7269@gondor.apana.org.au>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 14 Jun 2005 09:04:22 +1000

> On Mon, Jun 13, 2005 at 02:57:16PM -0700, David S. Miller wrote:
> > From: Herbert Xu <herbert@gondor.apana.org.au>
> > Date: Tue, 14 Jun 2005 07:42:52 +1000
> > 
> > > It'll dump the stack anyway if we just make it a NULL pointer.
> > 
> > Some platforms don't handle that very cleanly, for example
> > it may be necessary to have something mapped at page zero
> > for one reason or another.
> 
> Are there any existing platforms that do that in kernel mode?

X86 did, especially during bootup, for a long time.

I know the highly optimized sparc64 instruction TLB miss handler
doesn't handle this properly and this usually hangs the machine.
I've put some checks in there that tries to handle it properly,
but there are still some cases that pass through.

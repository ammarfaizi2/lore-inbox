Return-Path: <linux-kernel-owner+w=401wt.eu-S964837AbWLTCz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWLTCz1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 21:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWLTCz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 21:55:27 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43283
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964794AbWLTCz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 21:55:26 -0500
Date: Tue, 19 Dec 2006 18:55:25 -0800 (PST)
Message-Id: <20061219.185525.41636407.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: shemminger@osdl.org, mingo@elte.hu, akpm@osdl.org, wenji@fnal.gov,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug 7596 - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1Gwokt-00050T-00@gondolin.me.apana.org.au>
References: <20061219103756.38f7426c@freekitty>
	<E1Gwokt-00050T-00@gondolin.me.apana.org.au>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 20 Dec 2006 10:52:19 +1100

> Stephen Hemminger <shemminger@osdl.org> wrote:
> > I noticed this bit of discussion in tcp_recvmsg. It implies that a better
> > queuing policy would be good. But it is confusing English (Alexey?) so
> > not sure where to start.
> 
> Actually I think the comment says that the current code isn't the
> most elegant but is more efficient.

It's just explaining the hierarchy of queues that need to
be purged, and in what order, for correctness.

Alexey added that code when I mentioned to him, right after
we added the prequeue, that it was possible process the
normal backlog before the prequeue, which is illegal.
In fixing that bug, he added the comment we are discussing.

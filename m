Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWEPAiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWEPAiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWEPAiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:38:05 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:523 "EHLO arnor.apana.org.au")
	by vger.kernel.org with ESMTP id S1750885AbWEPAiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:38:04 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@davemloft.net (David S. Miller)
Subject: Re: [PATCH] tcpdump may trace some outbound packets twice.
Cc: shemminger@osdl.org, ranjitm@google.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <20060515.170835.126804002.davem@davemloft.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.16-xen (i686))
Message-Id: <E1FfnZP-0003St-00@gondolin.me.apana.org.au>
Date: Tue, 16 May 2006 10:37:51 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@davemloft.net> wrote:
> 
> Other implementation possibility suggestions welcome :-)

I see two possibilities:

1) Move the af_packet hook into the NIC driver.
2) Rethink the lockless tx setup.  If all NICs followed the tg3 and
   replaced spin_lock_irqsave with spin_lock then we should be able
   to go back to just using the xmit_lock.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

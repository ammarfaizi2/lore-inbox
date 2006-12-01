Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759128AbWLAGTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759128AbWLAGTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 01:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759132AbWLAGTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 01:19:53 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:47878 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1759115AbWLAGTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 01:19:53 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: alan@lxorguk.ukuu.org.uk (Alan)
Subject: Re: kswapd/tg3 issue
Cc: yoh@psychology.rutgers.edu, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20061130150406.3d0b6afd@localhost.localdomain>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1Gq1kG-0003q5-00@gondolin.me.apana.org.au>
Date: Fri, 01 Dec 2006 17:19:36 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan <alan@lxorguk.ukuu.org.uk> wrote:
>> 
>> Just got a logwatch daily mail which revealed a problem:
>> [2024412.788680] kswapd1: page allocation failure. order:2, mode:0x20
>> and a lengthy backtrace with head
>> 
>> ,------------------------------------------------------------------------
>> | [2024412.795212] Call Trace:
>> | [2024412.799768]  <IRQ> [<ffffffff8020c852>] __alloc_pages+0x27a/0x291
>> | [2024412.806452]  [<ffffffff802a08e3>] kmem_getpages+0x5e/0xd8
>> | [2024412.812370]  [<ffffffff80212c68>] cache_grow+0xd0/0x185
>> | [2024412.818064]  [<ffffffff80245c4f>] cache_alloc_refill+0x18c/0x1da
>> | [2024412.824625]  [<ffffffff802a1979>] __kmalloc+0x93/0xa3
>> | [2024412.830145]  [<ffffffff80222e9e>] __alloc_skb+0x54/0x117
>> | [2024412.835958]  [<ffffffff803b8a55>] __netdev_alloc_skb+0x12/0x2d
>> | [2024412.842347]  [<ffffffff80370292>] tg3_alloc_rx_skb+0xbb/0x146
>> `---
>> full dmesg is at
>> http://www.onerussian.com/Linux/bugs/bug.kswapd/dmesg
>> 
>> is that critical? seems to behave ok but...
> 
> Its tell us that the machine got very very tight on memory, far tighter
> than it probably ever should in normal situations. It is harmless of
> itself and if you only get the odd one is not a worry.

Since this is a 2nd order allocation, it could also be that you have
memory but it's fragmented.  If you aren't using jumbograms you can
try disabling that.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

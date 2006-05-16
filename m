Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWEPBSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWEPBSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWEPBSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:18:04 -0400
Received: from stinky.trash.net ([213.144.137.162]:33256 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750962AbWEPBSB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:18:01 -0400
Message-ID: <44692847.4080100@trash.net>
Date: Tue, 16 May 2006 03:17:59 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>, shemminger@osdl.org,
       ranjitm@google.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] tcpdump may trace some outbound packets twice.
References: <E1FfnZP-0003St-00@gondolin.me.apana.org.au>
In-Reply-To: <E1FfnZP-0003St-00@gondolin.me.apana.org.au>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> David S. Miller <davem@davemloft.net> wrote:
> 
>>Other implementation possibility suggestions welcome :-)
> 
> 
> I see two possibilities:
> 
> 1) Move the af_packet hook into the NIC driver.
> 2) Rethink the lockless tx setup.  If all NICs followed the tg3 and
>    replaced spin_lock_irqsave with spin_lock then we should be able
>    to go back to just using the xmit_lock.

3) Clone the skb and have dev_queue_xmit_nit() consume it.

That should actually be pretty easy.

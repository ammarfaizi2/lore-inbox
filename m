Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVICQ6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVICQ6d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVICQ6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:58:33 -0400
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:44224
	"EHLO jm.kir.nu") by vger.kernel.org with ESMTP id S1751111AbVICQ6b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:58:31 -0400
Date: Sat, 3 Sep 2005 09:54:25 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Harald Welte <laforge@netfilter.org>, David Miller <davem@davemloft.net>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Netdev List <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [PATCH 2/2] [NETFILTER] remove bogus hand-coded htonll()
Message-ID: <20050903165425.GZ7781@jm.kir.nu>
References: <20050903084315.GD4415@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050903084315.GD4415@rama.de.gnumonks.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 10:43:15AM +0200, Harald Welte wrote:

> htonll() is nothing else than cpu_to_be64(), so we'd rather call the
> latter.

Actually, the htonll() implementation does not seem to be doing what
cpu_to_be64() is doing.. However, I would assume this is a bug in
htonll() and this change to use cpu_to_be64() is fixing that. Can this
bug cause any major problems in the current implementation?

> -u_int64_t htonll(u_int64_t in)
> -{
> -	u_int64_t out;
> -	int i;
> -
> -	for (i = 0; i < sizeof(u_int64_t); i++)
> -		((u_int8_t *)&out)[sizeof(u_int64_t)-1] = ((u_int8_t *)&in)[i];

I would assume that the first index should have had '-i' added to it, if
the purpose is to swap byte order.. The code here is leaving some
arbitrary data in 7 bytes of the 64-bit variable and setting
(u8*)&out[7] = (u8*)&in[7] in somewhat inefficient way ;-). In addition,
this looks more like swap-8-bytes-unconditionally than doing this based
on host byte order..

-- 
Jouni Malinen                                            PGP id EFC895FA

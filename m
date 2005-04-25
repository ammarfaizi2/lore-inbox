Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVDYPnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVDYPnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVDYPkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:40:10 -0400
Received: from [62.206.217.67] ([62.206.217.67]:19942 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262632AbVDYP3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:29:07 -0400
Message-ID: <426D0CB9.4060500@trash.net>
Date: Mon, 25 Apr 2005 17:28:57 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Yair@arx.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
References: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au>
In-Reply-To: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> You'll still BUG if the destination is multicast/broadcast.  I'm also
> unsure whether ipt_REJECT isn't susceptible to the same problem.
> Luckily ipt_MIRROR is no more :)

ipt_REJECT is fine, ip_route_input() is only used in NF_IP_FORWARD.
But you're right about multicast/broadcast still causing problems,
I'll have another look.

> What are the issues with getting rid of the ip_route_input path
> altogether?
> 
> The only thing we gain over calling ip_route_output is the ability
> to set the input device.  But even that is just a fake derived from
> the source address in a deterministic way.  Therefore any effects
> achievable through using ip_route_input can also be done by simply
> reconfiguring the policy routing table to look at the local source
> addresses instead of (or in conjunction with) the input device.

No, ip_route_me_harder() can be called for packets with non-local
source. ip_route_output_slow() rejects non-local source addresses,
so the only way to use them for policy routing is by using
ip_route_input().

Regards
Patrick

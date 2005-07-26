Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVGZAQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVGZAQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 20:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVGZAQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 20:16:26 -0400
Received: from p54A093C3.dip0.t-ipconnect.de ([84.160.147.195]:1271 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261162AbVGZAQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 20:16:25 -0400
Message-ID: <42E580CF.4010800@trash.net>
Date: Tue, 26 Jul 2005 02:16:15 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Graf <tgraf@suug.ch>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Andrew Morton <akpm@osdl.org>,
       Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Netlink connector
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru>	<20050724.191756.105797967.davem@davemloft.net>	<Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com>	<20050725070603.GA28023@2ka.mipt.ru> <42E4F800.1010908@trash.net>	<20050725192853.GA30567@2ka.mipt.ru> <42E579BC.8000701@trash.net> <20050725235626.GX10481@postel.suug.ch>
In-Reply-To: <20050725235626.GX10481@postel.suug.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graf wrote:
> * Patrick McHardy <42E579BC.8000701@trash.net> 2005-07-26 01:46
>
>>You still have to take care of mixed 64/32 bit environments, u64 fields
>>for example are differently alligned.
> 
> My solution to this (in the same patchset) is that we never
> derference u64s but instead copy them.

I don't understand. The problem is mainly u64 embedded in structures,
the structs have different sizes if the u64 is not 8 byte aligned
and the structure size padded to a multiple of 8.

>>Then fix it so we can use more families and groups. I started some work
>>on this, but I'm not sure if I have time to complete it.
>  
> Great, this is one of the remaining issues I haven't solved yet.
> If you want me to take over just hand over your unfinished work
> and I'll integrate it into my patchset.

I started working on it after the OLS party, so no postable code yet :)
The idea for more groups is basically to remove the fixed groups
bitmask from struct sockaddr_nl and use setsockopt to add/remove
multicast subscriptions. If we add the limitation that a packet
can only be multicasted to a single group we can support an arbitary
number of groups, otherwise we would still be limited by size of
skb->cb. This limitation shouldn't be a problem, AFAIK nothing is
multicasting to multiple groups at once right now and the increased
number of groups will allow a better granularity anyway. The main
problem is keeping it backwards-compatible for current netlink users.
If this isn't possible we may need to call it netlink2.

Regards
Patrick

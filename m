Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVFUABR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVFUABR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVFUAAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:00:55 -0400
Received: from [62.206.217.67] ([62.206.217.67]:35473 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261822AbVFTXWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:22:55 -0400
Message-ID: <42B74FC5.3070404@trash.net>
Date: Tue, 21 Jun 2005 01:22:45 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bart De Schuymer <bdschuym@pandora.be>
CC: Bart De Schuymer <bdschuym@telenet.be>,
       Herbert Xu <herbert@gondor.apana.org.au>, netfilter-devel@manty.net,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
Subject: Re: 2.6.12: connection tracking broken?
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>	 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>	 <1119249575.3387.3.camel@localhost.localdomain>  <42B6B373.20507@trash.net> <1119293193.3381.9.camel@localhost.localdomain>
In-Reply-To: <1119293193.3381.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart De Schuymer wrote:
> When the _routing_ decision sends the packet to br0 (a bridge device),
> it is unknown which bridge port(s) the packet will be sent out. This is
> only known after the packet enters the bridge code. Therefore, for
> iptables to know the bridge port out device, the hooks must be postponed
> until in the bridge code.

This seems to be a really bad idea, for a single match that violates
layering we need to deal with this inconsistency. It's not just the
conntrack reference, with IPsec the packet passed to the defered hooks
is totally different from when it was still inside IP, which for example
breaks the policy match.

> Trust me, people will complain if they can no longer use the physdev
> match for routed packets.

I'm sure they will, now that they got used to it. Why can't people
match on the bridge port inside ebtables and only match on the device
within iptables? Is there a case that can't be handled this way?

Regards
Patrick

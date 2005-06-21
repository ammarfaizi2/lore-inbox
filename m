Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVFUIys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVFUIys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVFUIOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:14:15 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:21478 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261997AbVFUHG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:06:56 -0400
Subject: Re: 2.6.12: connection tracking broken?
From: Bart De Schuymer <bdschuym@pandora.be>
To: Patrick McHardy <kaber@trash.net>
Cc: Bart De Schuymer <bdschuym@telenet.be>,
       Herbert Xu <herbert@gondor.apana.org.au>, netfilter-devel@manty.net,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
In-Reply-To: <42B74FC5.3070404@trash.net>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
	 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>
	 <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net>
	 <1119293193.3381.9.camel@localhost.localdomain>
	 <42B74FC5.3070404@trash.net>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 07:19:42 +0000
Message-Id: <1119338382.3390.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op di, 21-06-2005 te 01:22 +0200, schreef Patrick McHardy:
> This seems to be a really bad idea, for a single match that violates
> layering we need to deal with this inconsistency. It's not just the
> conntrack reference, with IPsec the packet passed to the defered hooks
> is totally different from when it was still inside IP, which for example
> breaks the policy match.

I agree it is annoying.

> > Trust me, people will complain if they can no longer use the physdev
> > match for routed packets.
> 
> I'm sure they will, now that they got used to it. Why can't people
> match on the bridge port inside ebtables and only match on the device
> within iptables? Is there a case that can't be handled this way?

ebtables doesn't have all the targets/matches that iptables has.
Perhaps a rule structure using marking can always be used so that the
ACCEPT/DROP can be deferred until inside ebtables, I don't know if that
will always be possible though.

Deferring the hooks makes the bridge-nf code alot more complicated, so I
would be glad to get rid of it if it is the right thing to do. But
backwards compatibility can't be maintained and I'd be surprised if
every ruleset that now works will still be possible using an
iptables/ebtables scheme.
It has worked fine in the past and I see no reason why to stop making it
work now because of some recently found and unrelated referencing
problem.
Of course, if the netfilter people decide it should be removed, then so
be it.

cheers,
Bart



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVFTSdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVFTSdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVFTSdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:33:38 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:40643 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261428AbVFTSde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:33:34 -0400
Subject: Re: 2.6.12: connection tracking broken?
From: Bart De Schuymer <bdschuym@pandora.be>
To: Patrick McHardy <kaber@trash.net>
Cc: Bart De Schuymer <bdschuym@telenet.be>,
       Herbert Xu <herbert@gondor.apana.org.au>, netfilter-devel@manty.net,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
In-Reply-To: <42B6B373.20507@trash.net>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
	 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>
	 <1119249575.3387.3.camel@localhost.localdomain>  <42B6B373.20507@trash.net>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 18:46:33 +0000
Message-Id: <1119293193.3381.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op ma, 20-06-2005 te 14:15 +0200, schreef Patrick McHardy:
> Bart De Schuymer wrote:
> > Op ma, 20-06-2005 te 04:45 +0200, schreef Patrick McHardy:
> > 
> >> Bart, can you explain why the hooks are defered please?
> > 
> > This is done so that iptables knows which bridge port the output device
> > is, using the iptables physdev match.
> 
> In which cases is this necessary? AFAICT the output device is determined
> in br_handle_frame_finish() for a normally bridged packet.

When the _routing_ decision sends the packet to br0 (a bridge device),
it is unknown which bridge port(s) the packet will be sent out. This is
only known after the packet enters the bridge code. Therefore, for
iptables to know the bridge port out device, the hooks must be postponed
until in the bridge code.

> > Can't you release the conntrack reference with a function registered on
> > the POSTROUTING hook with a prio higher than nat POSTROUTING (or
> > something like that)?
> 
> We would have to hold the reference while the packet is queued at the
> device for the bridge case, which we want to avoid.

Trust me, people will complain if they can no longer use the physdev
match for routed packets.
People using a bridging firewall will just have to live with the fact
that the reference is held until in the bridge code.

cheers,
Bart



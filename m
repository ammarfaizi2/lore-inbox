Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVFTG0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVFTG0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 02:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVFTG0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 02:26:40 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:28303 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261472AbVFTG0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 02:26:38 -0400
Subject: Re: 2.6.12: connection tracking broken?
From: Bart De Schuymer <bdschuym@telenet.be>
To: Patrick McHardy <kaber@trash.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, bdschuym@pandora.be,
       netfilter-devel@manty.net, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, ebtables-devel@lists.sourceforge.net,
       rankincj@yahoo.com
In-Reply-To: <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
	 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 06:39:35 +0000
Message-Id: <1119249575.3387.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op ma, 20-06-2005 te 04:45 +0200, schreef Patrick McHardy:
> On Mon, 20 Jun 2005, Herbert Xu wrote:
> > Patrick McHardy <kaber@trash.net> wrote:
> >>
> >> The bridge-netfilter code defers calling of some NF_IP_* hooks to the
> >> bridge layer, when the conntrack reference is already gone, so the entry
> >
> > Why does it defer them at all? Shouldn't the fact that the device is
> > bridged be transparent to the IP layer?
> 
> I couldn't figure out the reason, it seems to have something to do
> with setting up device pointers for iptables and ebtables. It looks
> like the only way to fix this problem without keeping the conntrack
> reference while packets are queued at the device is to avoid defering
> the NF_IP_* hooks. Bart, can you explain why the hooks are defered
> please?

This is done so that iptables knows which bridge port the output device
is, using the iptables physdev match.

Can't you release the conntrack reference with a function registered on
the POSTROUTING hook with a prio higher than nat POSTROUTING (or
something like that)?

cheers,
Bart



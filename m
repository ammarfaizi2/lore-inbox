Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTI0EgX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 00:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTI0EgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 00:36:23 -0400
Received: from colin2.muc.de ([193.149.48.15]:18704 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262109AbTI0EgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 00:36:21 -0400
Date: 27 Sep 2003 06:36:31 +0200
Date: Sat, 27 Sep 2003 06:36:31 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: davidm@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030927043631.GA75212@colin2.muc.de>
References: <A2yd.64p.31@gated-at.bofh.it> <A2yd.64p.29@gated-at.bofh.it> <A317.6GH.7@gated-at.bofh.it> <m37k3viiqp.fsf@averell.firstfloor.org> <16244.31648.766419.56901@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16244.31648.766419.56901@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 10:47:12AM -0700, David Mosberger wrote:
> >>>>> On Fri, 26 Sep 2003 19:04:30 +0200, Andi Kleen <ak@muc.de> said:
> 
>   Andi> David Mosberger <davidm@napali.hpl.hp.com> writes:
>   >> Why would that be?  Slower, yes, but very slow?
> 
>   Andi> It depends on your architecture I guess. On K8/x86-64 it isn't
>   Andi> that big a deal (one cycle penalty for unaligned accesses),
>   Andi> but if you take an exception for each unaligned read it will
>   Andi> be incredible slow.
> 
> What are you talking about?  Arches that don't like/support unaligned

They don't in this case ;-)

See my reply to David Miller for details.

> 
>   Andi> Use one receive descriptor for the MAC header and another for
>   Andi> the rest (IP/TCP/payload) In the rest everything is aligned
>   Andi> and there are no problems with misaligned data types (ignoring
>   Andi> exceptional cases like broken timestamp options which can be
>   Andi> handled slowly).
> 
> That's what I proposed.

Hmm, must have missed that sorry. I saw it in Ivan's post only.

>   Andi> Fixing the stack to hadle separate MAC headers should not be
>   Andi> that much work, the code is fairly limited. Drawback is that
>   Andi> it requires bigger changes to the network drivers and maybe
>   Andi> some special case code for non standard MAC headers.
> 
> I suspect you'd be better off just copying the 14 bytes of the
> Ethernet header so that the entire packet is contiguous.

Good point. So it can be even handled transparently in drivers without
any core stack changes.

Only drawback is that more RX descriptors also usually require 
more PCI writes, which can be also very slow. Needs to be benchmarked
carefully if it's a worthy trade-off.

-Andi

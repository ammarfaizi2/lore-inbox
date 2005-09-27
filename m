Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVI0QX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVI0QX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVI0QX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:23:28 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9435 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964980AbVI0QX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:23:27 -0400
From: Andi Kleen <ak@suse.de>
To: Harald Welte <laforge@netfilter.org>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Date: Tue, 27 Sep 2005 18:23:18 +0200
User-Agent: KMail/1.8.2
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
References: <432EF0C5.5090908@cosmosbay.com> <200509221503.21650.ak@suse.de> <20050923170911.GN731@sunbeam.de.gnumonks.org>
In-Reply-To: <20050923170911.GN731@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509271823.19365.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 September 2005 19:09, Harald Welte wrote:
> On Thu, Sep 22, 2005 at 03:03:21PM +0200, Andi Kleen wrote:
> > > 1) No more central rwlock protecting each table (filter, nat, mangle,
> > > raw), but one lock per CPU. It avoids cache line ping pongs for each
> > > packet.
> >
> > Another useful change would be to not take the lock when there are no
> > rules. Currently just loading iptables has a large overhead.
>
> This is partially due to the netfilter hooks that are registered (so we
> always take nf_hook_slow() in the NF_HOOK() macro).

Not sure it's that. nf_hook_slow uses RCU, so it should be quite
fast.

> The default policies inside an iptables chain are internally implemented
> as a rule.  Thus, policies as built-in rules have packet/byte counters.

That could be special cased and done lockless, with the counting
done per CPU.

-Andi

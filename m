Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbUCPNrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbUCPNrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:47:17 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41742
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261653AbUCPNrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:47:15 -0500
Date: Tue, 16 Mar 2004 14:47:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-ID: <20040316134756.GW30940@dualathlon.random>
References: <20040314152253.05c58ecc.akpm@osdl.org> <Pine.LNX.4.44.0403160326360.1667-100000@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403160326360.1667-100000@dmt.cyclades>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 03:31:33AM -0300, Marcelo Tosatti wrote:
> 
> 
> On Sun, 14 Mar 2004, Andrew Morton wrote:
> 
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > > 
> > > > Having a magic knob is a weak solution: the majority of people who are
> > > > affected by this problem won't know to turn it on.
> > > 
> > > that's why I turned it _on_ by default in my tree ;)
> > 
> > So maybe Marcelo should apply this patch, and also turn it on by default.
> 
> Hhhmm, not so easy I guess. What about the added overhead of 
> lru_cache_add() for every anonymous page created? 
> 
> I bet this will cause problems for users which are happy with the current 
> behaviour. Wont it?

the lru_cache_add is happening in 2.4 mainline, the only point of the
patch is to _avoid_ calling lru_cache_add (tunable with a sysctl so you
can get to the old behaviour of calling lru_cache_add for every anon
page).

> Andrea, do you have any numbers (or at least estimates) for the added
> overhead of instantly addition of anon pages to the LRU? That would be
> cool to know.

I've the numbers for the removed overhead, that's significant in some
workload, but only in the >=16-ways.

> Obviously we dont have, and dont want to, such things in 2.4.

agreed ;)

> Anyway, it seems this discussion is being productive. Glad!

yep!

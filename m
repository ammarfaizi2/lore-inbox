Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUDDXJO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 19:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUDDXJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 19:09:14 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33411
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262925AbUDDXJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 19:09:11 -0400
Date: Mon, 5 Apr 2004 01:09:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.5-aa1 arch updates
Message-ID: <20040404230913.GA2148@dualathlon.random>
References: <Pine.LNX.4.44.0404041446430.22502-100000@localhost.localdomain> <20040404154924.GD2164@dualathlon.random> <16496.36001.210779.472061@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16496.36001.210779.472061@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 08:30:57AM +1000, Paul Mackerras wrote:
> Andrea Arcangeli writes:
> 
> > I'm unsure about the arch/ppc/mm/pgtable.c part, I mean, ppc is being
> > tested heavily, how can it be necessary if nobody ever got an oops yet? 
> > OTOH your patch certainly cannot hurt and it might be needed after all.
> > Maybe I should apply it after all, it'd be nice to get a comment on this
> > bit from ppc people who knows tlb.c better to be sure.
> 
> We definitely need page->mapping and page->index set on pte and pmd
> pages, both on ppc and ppc64.  Otherwise the flush_tlb_* functions
> won't work properly.  Hugh's patch looks good to me (at least as far
> as the ppc/ppc64 bits are concerned).

ok thanks, Hugh's arch's update adding ppc support are fully applied
right now in 2.6-aa and all other relevant trees. Thanks again Hugh!

I only still wonder how this could be unnoticed in practice in ppc(32)?
I mean page->mapping should be NULL if we don't set it and it should
cause an oops in flush_hash_one_pte, no? (if Hash != 0 of course)

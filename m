Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUDDPtY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 11:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUDDPtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 11:49:24 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:46252
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262438AbUDDPtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 11:49:22 -0400
Date: Sun, 4 Apr 2004 17:49:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.5-aa1 arch updates
Message-ID: <20040404154924.GD2164@dualathlon.random>
References: <Pine.LNX.4.44.0404041446430.22502-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404041446430.22502-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 02:48:15PM +0100, Hugh Dickins wrote:
> I've gone through our arch and include/asm files checking differences,
> here's a patch to 2.6.5-aa1: page_mapping(page) and prio_tree updates.
> All uncompiled and untested, but probably better than certainly wrong.
> 
> One fix: your ppc64 pte_alloc_one forgot to return NULL on failure:
> I notice that's a __GFP_REPEAT allocation, but even those fail when
> OOM-killed - I find its alias __GFP_NOFAIL very misleading.

this is greatly appreciated, thanks!

> I forget where you stand now on the ppc pgtable stuff: it naturally
> shows up here again, ignore again if you're sure it's irrelevant.

I'm unsure about the arch/ppc/mm/pgtable.c part, I mean, ppc is being
tested heavily, how can it be necessary if nobody ever got an oops yet? 
OTOH your patch certainly cannot hurt and it might be needed after all.
Maybe I should apply it after all, it'd be nice to get a comment on this
bit from ppc people who knows tlb.c better to be sure.

The rest is definitely necessary of course (especially the return NULL
on ppc64 ;).

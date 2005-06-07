Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVFGOjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVFGOjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVFGOjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:39:44 -0400
Received: from ns2.suse.de ([195.135.220.15]:35796 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261886AbVFGOje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:39:34 -0400
Date: Tue, 7 Jun 2005 16:39:33 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mbind: check_range use standard ptwalk
Message-ID: <20050607143933.GG23831@wotan.suse.de>
References: <Pine.LNX.4.61.0506062046590.5000@goblin.wat.veritas.com> <Pine.LNX.4.61.0506062048430.5000@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506062048430.5000@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 08:49:38PM +0100, Hugh Dickins wrote:
> Strict mbind's check for currently mapped pages being on node has been
> using a slow loop which re-evaluates pgd, pud, pmd, pte for each entry:
> replace that by a standard four-level page table walk like others in mm.
> Since mmap_sem is held for writing, page_table_lock can be taken at the
> inner level to limit latency.

I doubt you will be able to benchmark a difference since the inner loop
should be normally memory bound anyways, giving the CPU plenty
of time to do some cache accesses. But ok.

-Andi


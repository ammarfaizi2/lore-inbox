Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVKJNbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVKJNbF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbVKJNbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:31:05 -0500
Received: from gold.veritas.com ([143.127.12.110]:11428 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750863AbVKJNbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:31:03 -0500
Date: Thu, 10 Nov 2005 13:29:49 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
In-Reply-To: <20051110045144.40751a42.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511101323540.7464@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
 <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
 <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu>
 <Pine.LNX.4.61.0511101233530.6896@goblin.wat.veritas.com>
 <20051110045144.40751a42.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 13:31:02.0877 (UTC) FILETIME=[FEC400D0:01C5E5FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> > On Thu, 10 Nov 2005, Ingo Molnar wrote:
> > > 
> > > yuck. What is the real problem btw? AFAICS there's enough space for a 
> > > 2-word spinlock in struct page for pagetables.
> > 
> > Yes.  There is no real problem.  But my patch offends good taste.
> 
> Isn't it going to overrun page.lru with CONFIG_DEBUG_SPINLOCK?

No.  There is just one case where it would,
so in that case split ptlock is disabled by mm/Kconfig's
# PA-RISC 7xxx's debug spinlock_t is too large for 32-bit struct page.

	default "4096" if PARISC && DEBUG_SPINLOCK && !PA20

Of course, someone may extend spinlock debugging info tomorrow; but
when they do, presumably they'll try it out, and hit the BUILD_BUG_ON.
They'll then probably want to extend the suppression in mm/Kconfig.

Hugh

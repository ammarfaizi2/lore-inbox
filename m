Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbVKJO76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVKJO76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbVKJO76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:59:58 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:2215 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751029AbVKJO75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:59:57 -0500
Date: Thu, 10 Nov 2005 16:00:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-ID: <20051110150010.GA30859@elte.hu>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com> <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com> <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com> <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu> <Pine.LNX.4.61.0511101233530.6896@goblin.wat.veritas.com> <20051110045144.40751a42.akpm@osdl.org> <Pine.LNX.4.61.0511101323540.7464@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511101323540.7464@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Hugh Dickins <hugh@veritas.com> wrote:

> On Thu, 10 Nov 2005, Andrew Morton wrote:
> > Hugh Dickins <hugh@veritas.com> wrote:
> > > On Thu, 10 Nov 2005, Ingo Molnar wrote:
> > > > 
> > > > yuck. What is the real problem btw? AFAICS there's enough space for a 
> > > > 2-word spinlock in struct page for pagetables.
> > > 
> > > Yes.  There is no real problem.  But my patch offends good taste.
> > 
> > Isn't it going to overrun page.lru with CONFIG_DEBUG_SPINLOCK?
> 
> No.  There is just one case where it would,
> so in that case split ptlock is disabled by mm/Kconfig's
> # PA-RISC 7xxx's debug spinlock_t is too large for 32-bit struct page.
> 
> 	default "4096" if PARISC && DEBUG_SPINLOCK && !PA20
> 
> Of course, someone may extend spinlock debugging info tomorrow; but 
> when they do, presumably they'll try it out, and hit the BUILD_BUG_ON. 
> They'll then probably want to extend the suppression in mm/Kconfig.

why not do the union thing so that struct page grows automatically as 
new fields are added? It is quite bad design to introduce a hard limit 
like that. The only sizing concern is to make sure that the common 
.configs dont increase the size of struct page, but otherwise why not 
allow a larger struct page - it's for debugging only.

	Ingo

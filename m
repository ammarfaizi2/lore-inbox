Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVKLGbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVKLGbG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 01:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVKLGbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 01:31:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:64210 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932162AbVKLGbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 01:31:04 -0500
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0511101155160.4627@g5.osdl.org>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
	 <20051109181022.71c347d4.akpm@osdl.org>
	 <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
	 <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu>
	 <Pine.LNX.4.61.0511101233530.6896@goblin.wat.veritas.com>
	 <20051110045144.40751a42.akpm@osdl.org>
	 <Pine.LNX.4.61.0511101323540.7464@goblin.wat.veritas.com>
	 <20051110114950.03a5946b.akpm@osdl.org>
	 <Pine.LNX.4.64.0511101155160.4627@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 17:27:30 +1100
Message-Id: <1131776851.7406.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 11:56 -0800, Linus Torvalds wrote:
> 
> On Thu, 10 Nov 2005, Andrew Morton wrote:
> > 
> > IOW we're assuming that no 32-bit architectures will obtain pagetables from
> > slab?
> 
> I thought ARM does?
> 
> The ARM page tables are something strange (I think they have 1024-byte 
> page tables and 4kB pages or something like that?). So they'll not only 
> obtain the page tables from slab, they have four of them per page.


Just catching up on old mails... ppc64 also gets page tables from kmem
caches (though they are currently page sized & aligned). We really want
to be able to have more freedom and get away from the current idea that
1 PTE page == one page. Our intermediary levels (PMDs, PUDs, PGDs)
already have various random sizes.

Ben.



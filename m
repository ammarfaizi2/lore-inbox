Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263885AbUEXEgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUEXEgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 00:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUEXEgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 00:36:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:32410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263885AbUEXEgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 00:36:43 -0400
Date: Sun, 23 May 2004 21:36:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <1085371988.15281.38.camel@gaston>
Message-ID: <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>  <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
 <1085371988.15281.38.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 May 2004, Benjamin Herrenschmidt wrote:
> 
> Typically, you can have a thread faulting on a page. It goes through hash_page,
> doesn't find the entry, and gets to do_page_fault(). However, just before it
> takes the mm sem, another thread actually mmap's that page in. Thus we end up
> in handle_pte_fault() with a present PTE which has a valid mapping already.

Ok, with you so far. But I don't see how you get to set_pte() that way, 
since handle_pte_fault() will re-test the pte_present() bit, and never 
even try to set_pte() if one already exists. Hmm?

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVCAIJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVCAIJF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVCAIJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:09:05 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:40231 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261286AbVCAII7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:08:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=R/uqgfC4AZmPgUMz/EX9QcCPvwgJ2/g8L0zOl+Nw8zsTPPeUBnLghO65dOv+373tA1FN8Vo7OLcEJ6tRRlz60C1tLAvgHlb8MHlvIAJY1vjRM7lmq3R+89+bnA4t+v61YqMGobGBWUNpQEGaoWdfcypAbkV4shWtD/I15mLaVro=
Message-ID: <3f250c7105030100085ab86bd2@mail.gmail.com>
Date: Tue, 1 Mar 2005 04:08:15 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] A new entry for /proc
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, rrebel@whenu.com,
       marcelo.tosatti@cyclades.com, nickpiggin@yahoo.com.au
In-Reply-To: <Pine.LNX.4.61.0502282029470.28484@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106202339.4f9ba479.akpm@osdl.org>
	 <3f250c710502220513179b606a@mail.gmail.com>
	 <3f250c71050224003110e74704@mail.gmail.com>
	 <20050224010947.774628f3.akpm@osdl.org>
	 <3f250c710502240343563c5cb0@mail.gmail.com>
	 <20050224035255.6b5b5412.akpm@osdl.org>
	 <3f250c7105022507146b4794f1@mail.gmail.com>
	 <3f250c71050228014355797bd8@mail.gmail.com>
	 <3f250c7105022801564a0d0e13@mail.gmail.com>
	 <Pine.LNX.4.61.0502282029470.28484@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005 20:41:31 +0000 (GMT), Hugh Dickins <hugh@veritas.com> wrote:
> On Mon, 28 Feb 2005, Mauricio Lin wrote:
> >
> > Now I am testing with /proc/pid/smaps and the values are showing that
> > the old one is faster than the new one. So I will keep using the old
> > smaps version.
> 
> Sorry, I don't have time for more than the briefest look.
> 
> It appears that your old resident_mem_size method is just checking
> pte_present, whereas your new smaps_pte_range method is also doing
> pte_page (yet no prior check for pfn_valid: wrong) and checking
> !PageReserved i.e. accessing the struct page corresponding to each
> pte.  So it's not a fair comparison, your new method is accessing
> many more cachelines than your old method.
> 
> Though it's correct to check pfn_valid and !PageReserved to get the
> same total rss as would be reported elsewhere, I'd suggest that it's
> really not worth the overhead of those struct page accesses: just
> stick with the pte_present test.
So, I can remove the PageReserved macro without no problems, right?


> 
> Your smaps_pte_range is missing pte_unmap?
Yes, but I already fixed this problem.  Paul Mundt has checked the
unmap missing.

Thanks,

Let me perform new experiments now.

BR,

Mauricio Lin.

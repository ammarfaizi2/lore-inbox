Return-Path: <linux-kernel-owner+w=401wt.eu-S1754154AbWLRPdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbWLRPdo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbWLRPdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:33:44 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.16]:55939 "EHLO
	amsfep11-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754154AbWLRPdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:33:43 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <200612181024.18829.gene.heskett@verizon.net>
References: <1166314399.7018.6.camel@localhost>
	 <1166436717.10372.58.camel@twins> <1166438986.7003.1.camel@localhost>
	 <200612181024.18829.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 16:32:51 +0100
Message-Id: <1166455971.10372.75.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 10:24 -0500, Gene Heskett wrote:
> On Monday 18 December 2006 05:49, Andrei Popa wrote:
> >> OK, I'll try this on a ext3 box. BTW, what data mode are you using
> >> ext3 in?
> >
> >ordered
> >
> >> Also, for testings sake, could you give this a go:
> >> It's a total hack but I guess worth testing.
> >>
> >> ---
> >>  mm/rmap.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> Index: linux-2.6-git/mm/rmap.c
> >> ===================================================================
> >> --- linux-2.6-git.orig/mm/rmap.c	2006-12-18 11:06:29.000000000 +0100
> >> +++ linux-2.6-git/mm/rmap.c	2006-12-18 11:07:16.000000000 +0100
> >> @@ -448,7 +448,7 @@ static int page_mkclean_one(struct page
> >>  		goto unlock;
> >>
> >>  	entry = ptep_get_and_clear(mm, address, pte);
> >> -	entry = pte_mkclean(entry);
> >> +	/* entry = pte_mkclean(entry); */
> >>  	entry = pte_wrprotect(entry);
> >>  	ptep_establish(vma, address, pte, entry);
> >>  	lazy_mmu_prot_update(entry);
> >
> >with latest git and this patch there is no corruption !
> >
> I've not run a torrent app here recently.  Should this patch be applied to 
> a plain 2.6-20-rc1 before I do run azureas or similar apps?

depends on what the blue frog does, if it uses MAP_SHARED like rtorrent
does then yeah, probably. This patch really should not be the final one,
I'm currently still trying to wrap my head around the issue. That said,
it should be safe to use :-)


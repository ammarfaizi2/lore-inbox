Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVCAPqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVCAPqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVCAPq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:46:29 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:58119 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261949AbVCAPpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:45:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mVzFyQ0xrC23iNDKchFk+OKK0yU3RGuYyQyicMe6iIbZONdYogeqJQ6a9Efxbg4yvlZboHq+jb/m3GkXF2T/bpQADe6THWGFb7fX+aOcaFOubQmNpkpDDTLzHIXVqKcrdvsUbsEsVE4Dhxbxwi19GkO+2Lt3pvevhBabU/wGVgk=
Message-ID: <3f250c710503010744390391e2@mail.gmail.com>
Date: Tue, 1 Mar 2005 11:44:22 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] A new entry for /proc
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, rrebel@whenu.com,
       marcelo.tosatti@cyclades.com, nickpiggin@yahoo.com.au
In-Reply-To: <3f250c710503010617537a3ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106202339.4f9ba479.akpm@osdl.org>
	 <20050224010947.774628f3.akpm@osdl.org>
	 <3f250c710502240343563c5cb0@mail.gmail.com>
	 <20050224035255.6b5b5412.akpm@osdl.org>
	 <3f250c7105022507146b4794f1@mail.gmail.com>
	 <3f250c71050228014355797bd8@mail.gmail.com>
	 <3f250c7105022801564a0d0e13@mail.gmail.com>
	 <Pine.LNX.4.61.0502282029470.28484@goblin.wat.veritas.com>
	 <3f250c7105030100085ab86bd2@mail.gmail.com>
	 <3f250c710503010617537a3ca@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some values about the experiments. The values are the elapsed
real time used by the process, in seconds. Each row corresponds to
10000 cat /proc/pid/smaps command.

Old smaps
19.41
19.31
21.38
20.16

New smaps
16.82
16.75
16.75
16.79


BR,

Mauricio Lin.

On Tue, 1 Mar 2005 10:17:56 -0400, Mauricio Lin <mauriciolin@gmail.com> wrote:
> Well,
> 
> It is working better now. You are right Hugh. Now the new version is
> faster than the old one. I removed the struct page and its related
> function.
> 
> Thanks,
> 
> BR,
> 
> Mauricio Lin.
> 
> On Tue, 1 Mar 2005 04:08:15 -0400, Mauricio Lin <mauriciolin@gmail.com> wrote:
> > On Mon, 28 Feb 2005 20:41:31 +0000 (GMT), Hugh Dickins <hugh@veritas.com> wrote:
> > > On Mon, 28 Feb 2005, Mauricio Lin wrote:
> > > >
> > > > Now I am testing with /proc/pid/smaps and the values are showing that
> > > > the old one is faster than the new one. So I will keep using the old
> > > > smaps version.
> > >
> > > Sorry, I don't have time for more than the briefest look.
> > >
> > > It appears that your old resident_mem_size method is just checking
> > > pte_present, whereas your new smaps_pte_range method is also doing
> > > pte_page (yet no prior check for pfn_valid: wrong) and checking
> > > !PageReserved i.e. accessing the struct page corresponding to each
> > > pte.  So it's not a fair comparison, your new method is accessing
> > > many more cachelines than your old method.
> > >
> > > Though it's correct to check pfn_valid and !PageReserved to get the
> > > same total rss as would be reported elsewhere, I'd suggest that it's
> > > really not worth the overhead of those struct page accesses: just
> > > stick with the pte_present test.
> > So, I can remove the PageReserved macro without no problems, right?
> >
> >
> > >
> > > Your smaps_pte_range is missing pte_unmap?
> > Yes, but I already fixed this problem.  Paul Mundt has checked the
> > unmap missing.
> >
> > Thanks,
> >
> > Let me perform new experiments now.
> >
> > BR,
> >
> > Mauricio Lin.
> >
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVEKUm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVEKUm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVEKUm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:42:26 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:40486 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262043AbVEKUlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:41:49 -0400
Date: Wed, 11 May 2005 21:42:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: William Jordan <bjordan.ics@gmail.com>
cc: Timur Tabi <timur.tabi@ammasso.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
    implementation
In-Reply-To: <78d18e2050511131246075b37@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0505112129280.7826@goblin.wat.veritas.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> 
    <20050411171347.7e05859f.akpm@osdl.org> 
    <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com> 
    <4279142A.8050501@ammasso.com> <427A6A7E.8000604@ammasso.com> 
    <427BF8E1.2080006@ammasso.com> 
    <Pine.LNX.4.61.0505071304010.4713@goblin.wat.veritas.com> 
    <427CD49E.6080300@ammasso.com> 
    <Pine.LNX.4.61.0505071617470.5718@goblin.wat.veritas.com> 
    <78d18e2050511131246075b37@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 11 May 2005 20:41:47.0915 (UTC) 
    FILETIME=[DA0395B0:01C55669]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005, William Jordan wrote:
> On 5/7/05, Hugh Dickins <hugh@veritas.com> wrote:
> > > My understanding is that mlock() could in theory allow the page to be moved,
> > > but that currently nothing in the kernel would actually move it.  However,
> > > that could change in the future to allow hot-swapping of RAM.
> > 
> > That's my understanding too, that nothing currently does so.  Aside from
> > hot-swapping RAM, there's also a need to be able to migrate pages around
> > RAM, either to unfragment memory allowing higher-order allocations to
> > succeed more often, or to get around extreme dmamem/normal-mem/highmem
> > imbalances without dedicating huge reserves.  Those would more often
> > succeed if uninhibited by mlock.
> 
> If I am reading you correctly, you are saying that mlock currently
> prevents pages from migrating around to unfragment memory, but
> get_user_pages does not prevent this?

No, not what I meant at all.  I'm saying that currently (aside from
proposed patches) there is no such migration of pages; that we'd prefer
to implement migration in such a way that mlock does not inhibit it
(though there might prove to be strong arguments defeating that);
and that get_user_pages _must_ prevent migration (and if there
were already such migration, I'd be saying it _does_ prevent it).

Hugh

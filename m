Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVA1P4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVA1P4a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVA1P43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:56:29 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5649 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261279AbVA1P4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:56:11 -0500
Date: Fri, 28 Jan 2005 15:53:58 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Rik van Riel <riel@redhat.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <Pine.LNX.4.61.0501281036240.28137@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.61.0501281547240.7331@goblin.wat.veritas.com>
References: <20050127050927.GR10843@holomorphy.com> 
    <16888.46184.52179.812873@alkaid.it.uu.se> 
    <20050127125254.GZ10843@holomorphy.com> 
    <20050127142500.A775@flint.arm.linux.org.uk> 
    <20050127151211.GB10843@holomorphy.com> 
    <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com> 
    <20050127204455.GM10843@holomorphy.com> 
    <Pine.LNX.4.61.0501271557300.13927@chimarrao.boston.redhat.com> 
    <20050127211319.GN10843@holomorphy.com> 
    <Pine.LNX.4.61.0501271626460.13927@chimarrao.boston.redhat.com> 
    <20050128053036.GO10843@holomorphy.com> 
    <Pine.LNX.4.61.0501280801070.24304@chimarrao.boston.redhat.com> 
    <Pine.LNX.4.61.0501281348110.6922@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0501281036240.28137@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Rik van Riel wrote:
> 
> The main thing I would really like to preserve is the
> space used for "near-NULL" pointer detection. That is,
> detection of trying to access a large index in a NULL
> pointer array, etc.
> 
> I'd be happy to have some arbitrary value for the lower
> boundary...

Almost everything will still have that not-so-near-NULL pointer
detection.  It only gets limited to a PAGE_SIZE detection extent
in the case when the app mmaps as much as it possibly can.
I think it should be allowed make that tradeoff.

> > arch/ppc64/mm/hugetlbpage.c (odd place to find it) has its own
> > arch_get_unmapped_area_topdown, should be given a similar fix.
> 
> Good point, though a 64 bit architecture is, umm, less
> likely to run all the way down to zero within our lifetime.

I hadn't looked at it that way!

Hugh

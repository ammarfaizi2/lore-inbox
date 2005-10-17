Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVJQMew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVJQMew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 08:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVJQMew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 08:34:52 -0400
Received: from silver.veritas.com ([143.127.12.111]:32026 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932285AbVJQMev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 08:34:51 -0400
Date: Mon, 17 Oct 2005 13:33:53 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Robin Holt <holt@sgi.com>
cc: Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       ia64 list <linux-ia64@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org, jgarzik@pobox.com,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Carsten Otte <cotte@de.ibm.com>,
       Jack Steiner <steiner@americas.sgi.com>
Subject: Re: [Patch 2/3] Export get_one_pte_map.
In-Reply-To: <20051017114730.GC30898@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.61.0510171331090.2993@goblin.wat.veritas.com>
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com>
 <20051014192225.GD14418@lnx-holt.americas.sgi.com> <20051014213038.GA7450@kroah.com>
 <20051017113131.GA30898@lnx-holt.americas.sgi.com> <1129549312.32658.32.camel@localhost>
 <20051017114730.GC30898@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Oct 2005 12:34:44.0949 (UTC) FILETIME=[27731850:01C5D317]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005, Robin Holt wrote:
> On Mon, Oct 17, 2005 at 01:41:52PM +0200, Dave Hansen wrote:
> > On Mon, 2005-10-17 at 06:31 -0500, Robin Holt wrote:
> > > On Fri, Oct 14, 2005 at 02:30:38PM -0700, Greg KH wrote:
> > > > On Fri, Oct 14, 2005 at 02:22:25PM -0500, Robin Holt wrote:
> > > > > +EXPORT_SYMBOL(get_one_pte_map);
> 
> I got a little push from our internal incident tracking system for
> this being a module.  _GPL it will be.

Sorry, Robin, I've not been following your patches.  But if you look
at 2.6.14-rc4-mm1, you'll find that there isn't even a get_one_pte_map
there.  Though there's no certainty yet that my pt locking changes, or
Nick's PageReserved changes, will actually go forward, there's a lot of
work queued up in -mm that is likely to affect your code.  And I don't
think exporting internal functions from mremap.c, _GPL or otherwise,
is the way to go.

Moving useful functions to a more central location might be.  But I'm
very dubious about your doing this kind of pte stuff deep down in an
architecture-specific driver.  You're not the only one interested in
this kind of functionality: we were thinking of providing it via an
alternative to the ->nopage method, which deals in pfns rather than
struct pages (I think that was wli's suggestion originally; Carsten
has an interest in it on s390, and I bet there are others).  There
may be excellent reasons why that wouldn't be good enough for you,
and your retcode method may be a better idea: I don't know yet.

Please rebase your work to 2.6.14-rc4-mm1 (but I won't get to look
at the result for a few days: perhaps others will).

The big question has to be: what are you expecting to happen for
PROT_WRITE, MAP_PRIVATE?

Hugh

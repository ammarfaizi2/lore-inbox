Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbVLFT0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVLFT0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVLFT0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:26:08 -0500
Received: from mx1.suse.de ([195.135.220.2]:44703 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030200AbVLFT0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:26:07 -0500
Date: Tue, 6 Dec 2005 20:26:03 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/3] Framework for accurate node based statistics
Message-ID: <20051206192603.GX11190@wotan.suse.de>
References: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com> <20051206183524.GU11190@wotan.suse.de> <Pine.LNX.4.62.0512061105220.19475@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512061105220.19475@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 11:08:42AM -0800, Christoph Lameter wrote:
> On Tue, 6 Dec 2005, Andi Kleen wrote:
> 
> > > +static inline void mod_node_page_state(int node, enum node_stat_item item, int delta)
> > > +{
> > > +	vm_stat_diff[get_cpu()][node][item] += delta;
> > > +	put_cpu();
> > 
> > Instead of get/put_cpu I would use a local_t. This would give much better code
> > on i386/x86-64.  I have some plans to port over all the MM statistics counters
> > over to local_t, still stuck, but for new code it should be definitely done.
> 
> Yuck. That code uses atomic operations and is not aware of atomic64_t.

Hmm? What code are you looking at? 

At least i386/x86-64/generic don't use any atomic operations, just
normal non atomic on bus but atomic for interrupts local rmw.

Do you actually need 64bit? 

-Andi

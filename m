Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbUBYWRc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUBYWRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:17:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:43464 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261767AbUBYWPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:15:34 -0500
Date: Wed, 25 Feb 2004 14:16:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: paulmck@us.ibm.com, sct@redhat.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] Distributed mmap API
Message-Id: <20040225141646.28aa0750.akpm@osdl.org>
In-Reply-To: <200402251707.05932.phillips@arcor.de>
References: <20040216190927.GA2969@us.ibm.com>
	<200402251604.19040.phillips@arcor.de>
	<20040225140727.0cde826e.akpm@osdl.org>
	<200402251707.05932.phillips@arcor.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:
>
> On Wednesday 25 February 2004 17:07, Andrew Morton wrote:
> > Daniel Phillips <phillips@arcor.de> wrote:
> > > -			pte = ptep_get_and_clear(ptep);
> > > +			if (unlikely(!all) && is_anon(pfn_to_page(pfn)))
> > > +				continue;
> > > +			pte = ptep_get_and_clear(ptep); /* get dirty bit atomically */
> > >  			tlb_remove_tlb_entry(tlb, ptep, address+offset);
> > >  			if (pfn_valid(pfn)) {
> >
> > I think you need to check pfn_valid() before running is_anon(pfn_to_page())
> 
> Easy enough:
> 
> 	if (unlikely(!all) && pfn_valid(pfn) && is_anon(pfn_to_page(pfn)))

You can probably factor this into

	page = NULL;
	if (pfn_valid(..))
		page = pfn_to_page(..)
	if (page)
		..
	if (page)
		..

> but how can we legitimately get !pfn_valid there?

A mapping of some I/O region?


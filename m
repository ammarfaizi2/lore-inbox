Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVAXQhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVAXQhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVAXQhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:37:37 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5001 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261527AbVAXQh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:37:28 -0500
Date: Mon, 24 Jan 2005 08:37:15 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: davem@davemloft.net, hugh@veritas.com, linux-ia64@vger.kernel.org,
       torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Extend clear_page by an order parameter
In-Reply-To: <20050122234517.376ef3f8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0501240835041.15963@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
 <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
 <20050108135636.6796419a.davem@davemloft.net>
 <Pine.LNX.4.58.0501211210220.25925@schroedinger.engr.sgi.com>
 <20050122234517.376ef3f8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2005, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > The zeroing of a page of a arbitrary order in page_alloc.c and in hugetlb.c may benefit from a
> >  clear_page that is capable of zeroing multiple pages at once (and scrubd
> >  too but that is now an independent patch). The following patch extends
> >  clear_page with a second parameter specifying the order of the page to be zeroed to allow an
> >  efficient zeroing of pages. Hope I caught everything....
> >
>
> Sorry, I take it back.  As Paul says:
>
> : Wouldn't it be nicer to call the version that takes the order
> : parameter "clear_pages" and then define clear_page(p) as
> : clear_pages(p, 0) ?

> It would make the patch considerably smaller, and our naming is all over
> the place anyway...

Sounds good. Note though that this just means renaming clear_page to
clear_pages for all arches which would increase the patch size for the
arch specific section.

> I'd have thought that we'd want to make the new clear_pages() handle
> highmem pages too, if only from a regularity POV.  x86 hugetlbpages could
> use it then, if someone thinks up a fast page-clearer.

That would get us back to code duplication. We would have a clear_page (no
highmem support) and a clear_pages (supporting highmem). Then it may
also be better to pass the page struct to clear_pages instead of a memory address.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVDXKQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVDXKQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 06:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVDXKQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 06:16:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65153 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262302AbVDXKQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 06:16:19 -0400
Date: Sun, 24 Apr 2005 11:16:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] mspec driver for 2.6.12-rc2-mm3
Message-ID: <20050424101615.GA22393@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@wildopensource.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <16987.39773.267117.925489@jaguar.mkp.net> <20050412032747.51c0c514.akpm@osdl.org> <yq07jj8123j.fsf@jaguar.mkp.net> <20050413204335.GA17012@infradead.org> <yq08y3bys4e.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq08y3bys4e.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> int count; /* Number of pages allocated. */ + int type; /* Type of
> >> pages allocated. */ + unsigned long maddr[1]; /* Array of MSPEC
> >> addresses. */
> 
> Christoph> dito
> 
> The code use the size to calculate, it could be changed either way,
> don't think it's worth making the change.

The current code is obsufcated, see the pages-1 stuff and co.
Please change it.

> >> + /* + * The kernel requires a page structure to be returned upon +
> >> * success, but there are no page structures for low granule pages.
> >> + * remap_page_range() creates the pte for us and we return a + *
> >> bogus page back to the kernel fault handler to keep it happy + *
> >> (the page is freed immediately there).  + */
> 
> Christoph> Please don't use the ->nopage approach thenm but do
> Christoph> remap_pfn_range beforehand.  ->nopage is very nice if the
> Christoph> region is actually backed by normal RAM, but what you're
> Christoph> doing doesn't make much sense.
> 
> Thats what I used to think, however you want the node-local setup for
> performance reasons. Otherwise I would have switched to remap_pfn_range.

Then fixup remap_pfn_range (or rather add a new _node variant).  The
current code relies on deep magic to work and could be broken by a new
kernel release easily.

> >> +/* + * Walk the EFI memory map to pull out leftover pages in the
> >> lower + * memory regions which do not end up in the regular memory
> >> map and + * stick them into the uncached allocator + */ +static
> >> void __init +mspec_walk_efi_memmap_uc (void)
> 
> Christoph> I'm pretty sure this was NACKed on the ia64 list, and SGI
> Christoph> was told to do a more generic efi memmap walk.
> 
> No the issue back then was that the driver just took the memory and
> kept it to itself. The new approach exports it for other users.

That comment doesn't make sense at all to me.  exports what to what other
users.  And through what way.  Please bring this issue up on the ia64
list again.  (also please post this patch to linux-ia64, too)


Jes, is it just me or are you trying to chicken out on all the real
problems? :-)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVIUVcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVIUVcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVIUVcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:32:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964838AbVIUVcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:32:04 -0400
Date: Wed, 21 Sep 2005 14:31:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [swsusp] Rework image freeing
Message-Id: <20050921143123.462ea5fa.akpm@osdl.org>
In-Reply-To: <20050921211944.GB2071@elf.ucw.cz>
References: <20050921205132.GA4249@elf.ucw.cz>
	<20050921135834.4fd73447.akpm@osdl.org>
	<20050921211944.GB2071@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> > >
> > > +	for_each_zone(zone) {
> > >  +		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
> > >  +			struct page * page;
> > >  +			page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
> > >  +			if (PageNosave(page) && PageNosaveFree(page)) {
> > >  +				ClearPageNosave(page);
> > >  +				ClearPageNosaveFree(page);
> > >  +				free_page((long) page_address(page));
> > >  +			}
> > 
> > There doesn't seem to be much point in converting the pageframe address to
> > a virtual address, then back to a pageframe address.  Why not just do
> > put_page() here?
> 
> I do not know what put_page does, and free_page() has some friendly
> BUG_ONs. But if I should just do put_page(page); instead of
> free_page((long) page_address(page)), that is okay with me.

I don't know what alloc_pages() and free_page[s]() are supposed to do either
really.  They date from when Linus was in diapers.  They talk in terms of
kernel virtual addresses and will explode loudly if used for highmem pages.

All modern code will use page*'s or pfn's.

> [Sound of harddrive seeking and CPU fan going up as test kernel
> compiles].
> 

Ah, I wondered what it was.


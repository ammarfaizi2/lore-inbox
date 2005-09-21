Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVIUVUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVIUVUA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVIUVUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:20:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42453 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964897AbVIUVT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:19:59 -0400
Date: Wed, 21 Sep 2005 23:19:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [swsusp] Rework image freeing
Message-ID: <20050921211944.GB2071@elf.ucw.cz>
References: <20050921205132.GA4249@elf.ucw.cz> <20050921135834.4fd73447.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921135834.4fd73447.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >
> > +	for_each_zone(zone) {
> >  +		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
> >  +			struct page * page;
> >  +			page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
> >  +			if (PageNosave(page) && PageNosaveFree(page)) {
> >  +				ClearPageNosave(page);
> >  +				ClearPageNosaveFree(page);
> >  +				free_page((long) page_address(page));
> >  +			}
> 
> There doesn't seem to be much point in converting the pageframe address to
> a virtual address, then back to a pageframe address.  Why not just do
> put_page() here?

I do not know what put_page does, and free_page() has some friendly
BUG_ONs. But if I should just do put_page(page); instead of
free_page((long) page_address(page)), that is okay with me.

[Sound of harddrive seeking and CPU fan going up as test kernel
compiles].

								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address

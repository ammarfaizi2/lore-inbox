Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVIUU7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVIUU7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVIUU7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:59:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964833AbVIUU7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:59:15 -0400
Date: Wed, 21 Sep 2005 13:58:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [swsusp] Rework image freeing
Message-Id: <20050921135834.4fd73447.akpm@osdl.org>
In-Reply-To: <20050921205132.GA4249@elf.ucw.cz>
References: <20050921205132.GA4249@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> +	for_each_zone(zone) {
>  +		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
>  +			struct page * page;
>  +			page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
>  +			if (PageNosave(page) && PageNosaveFree(page)) {
>  +				ClearPageNosave(page);
>  +				ClearPageNosaveFree(page);
>  +				free_page((long) page_address(page));
>  +			}

There doesn't seem to be much point in converting the pageframe address to
a virtual address, then back to a pageframe address.  Why not just do
put_page() here?


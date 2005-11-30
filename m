Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVK3L31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVK3L31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 06:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVK3L31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 06:29:27 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:46530 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751163AbVK3L31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 06:29:27 -0500
Message-ID: <438D8D22.4090303@jp.fujitsu.com>
Date: Wed, 30 Nov 2005 20:29:38 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, Cliff Wickman <cpw@sgi.com>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 5/7] Direct Migration V5: remove_from_swap()
 to remove swap ptes
References: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com> <20051128204310.10037.32852.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051128204310.10037.32852.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Lameter wrote:
> Add remove_from_swap
> 
> remove_from_swap() allows the restoration of the pte entries that existed
> before page migration occurred for anonymous pages by walking the reverse
> maps. This reduces swap use and establishes regular pte's without the need
> for page faults.
> 

in migrate_page_copy()
==
        ClearPageSwapCache(page);
         ClearPageActive(page);
         ClearPagePrivate(page);
         set_page_private(page, 0);
         page->mapping = NULL;
==
page->mapping turns to be NULL, when migration success.
 > +			if (newpage) {
 >  				/* Successful migration. Return new page to LRU */
 > +				remove_from_swap(page);
 >  				move_to_lru(newpage);
 > -
When success, remove_from_swap(page) is called.

> +#ifdef CONFIG_MIGRATION
> +/*
> + * Remove an anonymous page from swap replacing the swap pte's
> + * through real pte's pointing to valid pages.
> + */
> +void remove_from_swap(struct page *page)
> +{
> +	struct anon_vma *anon_vma;
> +	struct vm_area_struct *vma;
> +
> +	if (!PageAnon(page))
> +		return;
> +
PageAnon(page) always 0.

remove_from_swap(newpage) is sane ?

-- Kame


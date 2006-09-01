Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWIAPEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWIAPEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWIAPEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:04:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:9377 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751348AbWIAPEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:04:20 -0400
Subject: Re: [patch 4/9] Guest page hinting: volatile swap cache.
From: Dave Hansen <haveblue@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <20060901111006.GE15684@skybase>
References: <20060901111006.GE15684@skybase>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 08:04:06 -0700
Message-Id: <1157123046.28577.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 13:10 +0200, Martin Schwidefsky wrote:
> +#if defined(CONFIG_PAGE_STATES)
> +
> +struct page * find_get_page_nodiscard(struct address_space *mapping,
> +				      unsigned long offset)
> +{
> +	struct page *page;
> +
> +	read_lock_irq(&mapping->tree_lock);
> +	page = radix_tree_lookup(&mapping->page_tree, offset);
> +	if (page)
> +		page_cache_get(page);
> +	read_unlock_irq(&mapping->tree_lock);
> +	return page;
> +}
> +
> +EXPORT_SYMBOL(find_get_page_nodiscard);
> +
> +#endif

Is it worth having another full copy of find_get_page()?  What about a
"nodiscard" argument?

-- Dave


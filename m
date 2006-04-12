Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWDLVOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWDLVOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 17:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWDLVOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 17:14:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932262AbWDLVOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 17:14:43 -0400
Date: Wed, 12 Apr 2006 14:16:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, rjw@sisk.pl, pavel@suse.cz
Subject: Re: [PATCH 1/3] swsusp add architecture special saveable pages
 support
Message-Id: <20060412141642.63debf90.akpm@osdl.org>
In-Reply-To: <1144809499.2865.39.camel@sli10-desk.sh.intel.com>
References: <1144809499.2865.39.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> wrote:
>
> +static int save_arch_mem(void)
> +{
> +	void *kaddr;
> +	struct arch_saveable_page *tmp = arch_pages;
> +
> +	pr_debug("swsusp: Saving arch specific memory");
> +	while (tmp) {
> +		tmp->data = (void *)get_zeroed_page(GFP_ATOMIC);

There's no need to zero the page here.

> +		if (!tmp->data)
> +			return -ENOMEM;
> +		/* arch pages might haven't a 'struct page' */
> +		kaddr = kmap_atomic_pfn(tmp->pfn, KM_PTE0);
> +		memcpy(tmp->data, kaddr, PAGE_SIZE);
> +		kunmap_atomic(kaddr, KM_PTE0);

Why was KM_PTE0 chosen here?

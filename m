Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUJNUz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUJNUz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUJNUyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:54:53 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:9990 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264113AbUJNUfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:35:46 -0400
Date: Thu, 14 Oct 2004 21:35:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RESEND][PATCH 4/6] Add page becoming writable notification
Message-ID: <20041014203545.GA13639@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <24449.1097780701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24449.1097780701@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +	/* notification that a page is about to become writable */
> +	int (*page_mkwrite)(struct page *page);

This doesn't fit into address_space operations at all.  The vm_operation
below is enough.

> --- linux-2.6.9-rc1-mm2/mm/memory.c	2004-08-31 16:52:40.000000000 +0100
> +++ linux-2.6.9-rc1-mm2-cachefs/mm/memory.c	2004-09-02 15:40:26.000000000 +0100
> @@ -1030,6 +1030,54 @@ static inline void break_cow(struct vm_a
>  }
>  
>  /*
> + * Make a PTE writeable for do_wp_page() on a shared-writable page
> + */
> +static inline int do_wp_page_mk_pte_writable(struct mm_struct *mm,
> +					     struct vm_area_struct *vma,
> +					     unsigned long address,
> +					     pte_t *page_table,
> +					     struct page *old_page,
> +					     pte_t pte)

This prototype shows pretty much that splitting it out doesn't make much sense.
Why not add a goto reuse_page; where you call it currently and append it
at the end of do_wp_page?


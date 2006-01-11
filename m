Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932768AbWAKCQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbWAKCQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 21:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWAKCQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 21:16:00 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:40095 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932779AbWAKCP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 21:15:59 -0500
Subject: Re: [PATCH] remove uneccesary page++
From: Dave Hansen <haveblue@us.ibm.com>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org, Andy Wihitcroft <apw@shadowen.org>
In-Reply-To: <200601110128.k0B1S4tU013956@localhost.localdomain>
References: <200601110128.k0B1S4tU013956@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 18:15:57 -0800
Message-Id: <1136945757.27584.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 11:28 +1000, Greg Ungerer wrote:
> Remove unecessary page++ from memmap_init_zone loop.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> 
> 
> --- linux-2.6.15/mm/page_alloc.c	2006-01-03 13:21:10.000000000 +1000
> +++ linux-2.6.15-uc0/mm/page_alloc.c	2006-01-11 11:16:46.981376296 +1000
> @@ -1706,7 +1706,7 @@
>  	unsigned long end_pfn = start_pfn + size;
>  	unsigned long pfn;
>  
> -	for (pfn = start_pfn; pfn < end_pfn; pfn++, page++) {
> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>  		if (!early_pfn_valid(pfn))
>  			continue;
>  		if (!early_pfn_in_nid(pfn, nid))

You're right.  Somebody missed that when we made it re-calculate the
struct page each time.  Probably from the sparsemem updates.  You could
also take the page variable and just declare it inside that loop.  The
use appears to be local there.

                for (pfn = start_pfn; pfn < end_pfn; pfn++) {
                	struct page *page;
                        if (!early_pfn_valid(pfn))
                               continue;
                if (!early_pfn_in_nid(pfn, nid))
                        continue;
                page = pfn_to_page(pfn);


-- Dave


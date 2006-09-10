Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWIJQZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWIJQZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 12:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWIJQZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 12:25:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:55009 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932269AbWIJQZl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 12:25:41 -0400
Subject: Re: [patch 2/2] convert s390 page handling macros to functions v3
From: Dave Hansen <haveblue@us.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <20060910130832.GB12084@osiris.ibm.com>
References: <20060908111716.GA6913@osiris.boeblingen.de.ibm.com>
	 <Pine.LNX.4.64.0609092248400.6762@scrub.home>
	 <20060910130832.GB12084@osiris.ibm.com>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 09:25:18 -0700
Message-Id: <1157905518.26324.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-10 at 15:08 +0200, Heiko Carstens wrote:
> 
> +static inline int page_test_and_clear_dirty(struct page *page)
> +{
> +       unsigned long physpage = __pa((page - mem_map) << PAGE_SHIFT);
> +       int skey = page_get_storage_key(physpage); 

This has nothing to do with your patch at all, but why is 'page -
mem_map' being open-coded here?

I see at least a couple of page_to_phys() definitions on some
architectures.  This operation is done enough times that s390 could
probably use the same treatment.

It could at least use a page_to_pfn() instead of the 'page - mem_map'
operation, right?

-- Dave


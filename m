Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWEYKlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWEYKlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWEYKlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:41:18 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:62096 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965115AbWEYKlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:41:17 -0400
Message-ID: <348553673.03597@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 25 May 2006 18:41:17 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/33] readahead: common macros
Message-ID: <20060525104117.GE4996@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469539.42623@ustc.edu.cn> <44754708.5090406@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44754708.5090406@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 03:56:24PM +1000, Nick Piggin wrote:
> >+#include <linux/writeback.h>
> >+#include <linux/nfsd/const.h>
> >
> 
> How come you're adding these includes?

For something added in the past and removed later...

> >+#define PAGES_BYTE(size) (((size) + PAGE_CACHE_SIZE - 1) >> 
> >PAGE_CACHE_SHIFT)
> >+#define PAGES_KB(size)	 PAGES_BYTE((size)*1024)
> >
> Don't really like the names. Don't think they do anything for clarity, but
> if you can come up with something better for PAGES_BYTE I might change my
> mind ;) (just forget about PAGES_KB - people know what *1024 means)

No, they are mainly for concision. Don't you think it's cleaner to write
        PAGES_KB(VM_MAX_READAHEAD)
than
        (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE

Admittedly the names are somewhat awkward though :)

> Also: the replacements are wrong: if you've defined VM_MAX_READAHEAD to be
> 4095 bytes, you don't want the _actual_ readahead to be 4096 bytes, do you?
> It is saying nothing about minimum, so presumably 0 is the correct choice.

The macros were first introduced exact for this reason ;)

It is rumored that there will be 64K page support, and this macro
helps round up the 16K sized VM_MIN_READAHEAD. The eof_index also
needs rounding up.

> >+#define next_page(pg) (list_entry((pg)->lru.prev, struct page, lru))
> >+#define prev_page(pg) (list_entry((pg)->lru.next, struct page, lru))
> >
> 
> Again, it is probably easier just to use the expanded version. Then the
> reader can immediately say: ah, the next page on the LRU list (rather
> than, maybe, the next page in the pagecache).

Ok, will expand it.

Wu

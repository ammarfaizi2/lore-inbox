Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265227AbUFCRLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUFCRLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUFCRKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:10:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:39391 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264253AbUFCRJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:09:24 -0400
Date: Thu, 3 Jun 2004 10:08:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Export swapper_space
Message-Id: <20040603100826.2fd235c8.akpm@osdl.org>
In-Reply-To: <20040603170137.E8244@flint.arm.linux.org.uk>
References: <20040603161909.D8244@flint.arm.linux.org.uk>
	<20040603153727.GA17798@infradead.org>
	<20040603170137.E8244@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> > Please not.  This seems to be some cache-flushing magic on the stranger
>  > architectures again :)  Can you check how they're using it in the end
>  > and hopefully fix it by uninlining something?
> 
>  extern struct address_space swapper_space;
>  static inline struct address_space *page_mapping(struct page *page)
>  {
>          struct address_space *mapping = NULL;
>   
>          if (unlikely(PageSwapCache(page)))
>                  mapping = &swapper_space;
>          else if (likely(!PageAnon(page)))
>                  mapping = page->mapping;
>          return mapping;
>  }

Christoph means "can arm uninline flush_dcache_page()"?

It looks like that would be the best approach - it's quite a large function.

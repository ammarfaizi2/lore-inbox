Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbUKWQMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUKWQMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 11:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbUKWQMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 11:12:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:18388 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261296AbUKWQMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:12:14 -0500
Date: Tue, 23 Nov 2004 08:11:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, wli@holomorphy.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compound page overhaul
Message-Id: <20041123081129.3e0121fd.akpm@osdl.org>
In-Reply-To: <29356.1101201515@redhat.com>
References: <20041122155434.758c6fff.akpm@osdl.org>
	<11948.1101130077@redhat.com>
	<29356.1101201515@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> Andrew Morton <akpm@osdl.org>:
> > ugh, sorry, I'd forgotten that !MMU needs to use the fields inside
> > pages[1].  It seems that the !MMU requirement is in that case quite
> > dissimilar from what compound pages are supposed to do.  Perhaps we should
> > just forget the whole thing and stick with the current design approach?
> 
> Nonono... you misunderstand. Compound-pages support uses fields from page[1]
> to store extra data.

I know.  I wrote it.

> It's nothing at all to do with MMU vs !MMU.
> 

In that case I just dunno what's going on now.

I thought we were discussing the removal of this, from __free_pages_ok():

#ifndef CONFIG_MMU
	if (order > 0)
		for (i = 1 ; i < (1 << order) ; ++i)
			__put_page(page + i);
#endif

by using compound page's refcounting logic instead.  But !MMU really wants
to treat that higher-order page as an array of zero-order pages, and that
requires the usual usage of the fields of page[1], page[2], etc.

So what I'm saying is "compound pages are designed for treating a
higher-order page as a higher-order page.  !MMU wants to treat a higher
order page as an array of zero-order pages.  Hence give up and stick with
the current code".

What are you saying?

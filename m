Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUKWW6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUKWW6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbUKWRnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:43:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:24968 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261340AbUKWQ4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:56:38 -0500
Date: Tue, 23 Nov 2004 08:56:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, wli@holomorphy.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compound page overhaul
Message-Id: <20041123085608.3c30aa34.akpm@osdl.org>
In-Reply-To: <15564.1101228539@redhat.com>
References: <20041123081129.3e0121fd.akpm@osdl.org>
	<20041122155434.758c6fff.akpm@osdl.org>
	<11948.1101130077@redhat.com>
	<29356.1101201515@redhat.com>
	<15564.1101228539@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> > > ugh, sorry, I'd forgotten that !MMU needs to use the fields inside
> > > pages[1].
> 
> Perhaps I misunderstood what you meant here. I _assumed_ you meant that it
> used the bits of pages[1] for compound page metadata - which it now does only
> because it's now using compound pages (if only with my patch applied).

I thought that's what you meant ;)

So why did you create a "Compound page overhaul" in the first place?  Was it
not to address some insufficiency for !MMU?

> > But !MMU really wants to treat that higher-order page as an array of
> > zero-order pages, and that requires the usual usage of the fields of
> > page[1], page[2], etc.
> 
> That's not really so. For the most part, !MMU linux treats pages identically
> to MMU linux, whether those pages are big or small.
> 
> It's only for interprocess userspace access that there's an issue, and the
> issue there is, I think, that access_process_vm() wants to pin the page in
> place to stop it going away whilst it is being fiddled with.
> 
> Normally, the page is pinned in place by its refcount and/or flags. However,
> for compound pages, the refcount in question is really on the first page of
> the batch, and so refcount accesses should be directed there, and not to a
> secondary page.

The current compound page logic should handle that quite happily, no?


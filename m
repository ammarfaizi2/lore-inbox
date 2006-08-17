Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWHQOg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWHQOg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWHQOg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:36:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:6804 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932454AbWHQOg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:36:27 -0400
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E46FC4.2050002@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>  <44E46FC4.2050002@sw.ru>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 07:36:19 -0700
Message-Id: <1155825379.9274.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 17:31 +0400, Kirill Korotaev wrote:
> > How many things actually use this?  Can we have the slab ubcs
> without
> > the struct page pointer?
> slab doesn't use this pointer on the page.
> It is used for pages allocated by buddy
> alocator implicitly (e.g. LDT pages, page tables, ...). 

Hmmm.  There aren't _that_ many of those cases, right?  Are there any
that absolutely need raw access to the buddy allocator?  I'm pretty sure
that pagetables can be moved over to a slab, as long as we bump up the
alignment.

It does seem a wee bit silly to have the pointer in _all_ of the struct
pages, even the ones for which we will never do any accounting (and even
on kernels that never need it).  But, a hashing scheme sounds like a
fine idea.

-- Dave


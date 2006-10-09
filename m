Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWJIVES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWJIVES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 17:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWJIVES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 17:04:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:45257 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964861AbWJIVER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 17:04:17 -0400
Subject: Re: User switchable HW mappings & cie
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>,
       linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Arnd Bergmann <arnd@arndb.de>,
       Linus Torvalds <torvalds@osdl.org>, Nick Piggin <npiggin@suse.de>
In-Reply-To: <200610092036.50010.ioe-lkml@rameria.de>
References: <1160347065.5926.52.camel@localhost.localdomain>
	 <452A35FF.50009@tungstengraphics.com>
	 <1160394662.10229.30.camel@localhost.localdomain>
	 <200610092036.50010.ioe-lkml@rameria.de>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 07:03:49 +1000
Message-Id: <1160427829.7752.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 20:36 +0200, Ingo Oeser wrote:
> Hi all,
> 
> On Monday, 9. October 2006 13:51, Benjamin Herrenschmidt wrote:
> > > One problem that occurs is that the rule for ptes with non-backing 
> > > struct pages
> > > Which I think was introduced in 2.6.16:
> > > 
> > >     pfn_of_page == vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT)
> > > 
> > > cannot be honored, at least not with the DRM memory manager, since the 
> > > graphics object will be associated with a vma and not the underlying 
> > > physical address. User space will have vma->vm_pgoff as a handle to the 
> > > object, which may move around in graphics memory.
> > 
> > That's a problem with VM_PFNMAP set indeed. get_user_pages() is a
> > non-issue with VM_IO set too but I'm not sure about other code path that
> > might try to hit here... though I think we don't hit that if MAP_SHARED,
> > Nick ?
> 
> Istn't this just a non-linear PFN mapping, you are describing here?
> 
> Nick: 
> 	Cant your new fault consolidation code handle that?
> 	AFAICS your new .fault handler just gets the
> 	vma and pgoff and install the matching PTE via install_THINGIE()
> 	or vm_insert_THINGIE()
> 
> Or do I miss sth. here?

It is somewhat yes.

Ben.



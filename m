Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751886AbWJIShB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbWJIShB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 14:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWJIShB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 14:37:01 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:45787 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751886AbWJIShA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 14:37:00 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: User switchable HW mappings & cie
Date: Mon, 9 Oct 2006 20:36:47 +0200
User-Agent: KMail/1.9.3
Cc: Thomas =?iso-8859-15?q?Hellstr=F6m?= 
	<thomas@tungstengraphics.com>,
       linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Arnd Bergmann <arnd@arndb.de>,
       Linus Torvalds <torvalds@osdl.org>, Nick Piggin <npiggin@suse.de>
References: <1160347065.5926.52.camel@localhost.localdomain> <452A35FF.50009@tungstengraphics.com> <1160394662.10229.30.camel@localhost.localdomain>
In-Reply-To: <1160394662.10229.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610092036.50010.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Monday, 9. October 2006 13:51, Benjamin Herrenschmidt wrote:
> > One problem that occurs is that the rule for ptes with non-backing 
> > struct pages
> > Which I think was introduced in 2.6.16:
> > 
> >     pfn_of_page == vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT)
> > 
> > cannot be honored, at least not with the DRM memory manager, since the 
> > graphics object will be associated with a vma and not the underlying 
> > physical address. User space will have vma->vm_pgoff as a handle to the 
> > object, which may move around in graphics memory.
> 
> That's a problem with VM_PFNMAP set indeed. get_user_pages() is a
> non-issue with VM_IO set too but I'm not sure about other code path that
> might try to hit here... though I think we don't hit that if MAP_SHARED,
> Nick ?

Istn't this just a non-linear PFN mapping, you are describing here?

Nick: 
	Cant your new fault consolidation code handle that?
	AFAICS your new .fault handler just gets the
	vma and pgoff and install the matching PTE via install_THINGIE()
	or vm_insert_THINGIE()

Or do I miss sth. here?


Regards

Ingo Oeser

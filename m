Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSKVDSi>; Thu, 21 Nov 2002 22:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbSKVDSi>; Thu, 21 Nov 2002 22:18:38 -0500
Received: from fmr02.intel.com ([192.55.52.25]:22770 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265102AbSKVDSh>; Thu, 21 Nov 2002 22:18:37 -0500
Message-ID: <25282B06EFB8D31198BF00508B66D4FA03EA5B14@fmsmsx114.fm.intel.com>
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "Seth, Rohit" <rohit.seth@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@digeo.com,
       torvalds@transmeta.com
Subject: RE: hugetlb page patch for 2.5.48-bug fixes
Date: Thu, 21 Nov 2002 19:23:03 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> At some point in the past, I wrote:
> >> Okay, first off why are you using a list linked through 
> >> page->private?
> >> page->list is fully available for such tasks.
> 
> On Thu, Nov 21, 2002 at 05:54:22PM -0800, Seth, Rohit wrote:
> > Don't really need a list_head kind of thing for always inorder 
> > complete traversal. list_head (slightly) adds fat in data 
> structures 
> > as well as insertaion/removal. Please le me know if anything that 
> > prohibits the use of page_private field for internal use.
> 
> page->private is also available for internal use. The objection here
> was about not using the standardized list macros. I'm not 
> convinced about the fat since the keyspace is tightly bounded 
> and the back pointers are in struct page regardless. (And we 
> also just happen to know page->lru is also available though 
> I'd not suggest using it.)
> 

Either way. That is fine. I will make the change.

> 
> At some point in the past, I wrote:
> >> Third, the hugetlb_release_key() in unmap_hugepage_range() is
> >> the one that should be removed [along with its corresponding 
> >> mark_key_busy()], not the one in sys_free_hugepages(). 
> >> unmap_hugepage_range() is doing neither setup nor teardown of 
> >> the key itself, only the pages and PTE's. I would say 
> >> key-level refcounting belongs to sys_free_hugepages().
> 
> On Thu, Nov 21, 2002 at 05:54:22PM -0800, Seth, Rohit wrote:
> > It is not mandatory that user app calls free_pages.  Or 
> even in case 
> > of app aborts this call will not be made.  The internal 
> structures are 
> > always released during the exit (with last ref count) along 
> with free 
> > of underlying physical pages.
> 
> Hmm, I can understand caution wrt. touching core. I suspect 
> vma->close() should do hugetlb_key_release() instead of 
> sys_free_hugepages()?
> 
That is a good option for 2.5. I will update the patch tomorrow.

rohit

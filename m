Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbSKVBrs>; Thu, 21 Nov 2002 20:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264785AbSKVBrs>; Thu, 21 Nov 2002 20:47:48 -0500
Received: from fmr02.intel.com ([192.55.52.25]:19144 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S264779AbSKVBrr>; Thu, 21 Nov 2002 20:47:47 -0500
Message-ID: <25282B06EFB8D31198BF00508B66D4FA03EA5B12@fmsmsx114.fm.intel.com>
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "Seth, Rohit" <rohit.seth@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@digeo.com,
       torvalds@transmeta.com
Subject: RE: hugetlb page patch for 2.5.48-bug fixes
Date: Thu, 21 Nov 2002 17:54:22 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bill for your comments. 

> Okay, first off why are you using a list linked through page->private?
> page->list is fully available for such tasks.

Don't really need a list_head kind of thing for always inorder complete
traversal. list_head (slightly) adds fat in data structures as well as
insertaion/removal. Please le me know if anything that prohibits the use of
page_private field for internal use.
> 
> Second, the if (key == NULL) check in hugetlb_release_key() 
> is bogus; someone is forgetting to check for NULL, probably 
> in alloc_shared_hugetlb_pages().
> 
This if condition will be removed.  It does not serve any purpose.  As there
is no way to release_key without a valid key.

> Third, the hugetlb_release_key() in unmap_hugepage_range() is 
> the one that should be removed [along with its corresponding 
> mark_key_busy()], not the one in sys_free_hugepages(). 
> unmap_hugepage_range() is doing neither setup nor teardown of 
> the key itself, only the pages and PTE's. I would say 
> key-level refcounting belongs to sys_free_hugepages().
> 
> Bill
> 
It is not mandatory that user app calls free_pages.  Or even in case of app
aborts this call will not be made.  The internal structures are always
released during the exit (with last ref count) along with free of underlying
physical pages.  

rohit

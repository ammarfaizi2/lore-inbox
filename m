Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWEVXt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWEVXt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 19:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWEVXt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 19:49:29 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:54709 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751310AbWEVXt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 19:49:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OSQtibuCXf+RVsTf45Q58V2OdukBHX8gs4p+E5tomcGV0TIPRH/R5vZMPGyOJEUimJ4hUUUP/MEykUfZlsA/xtEhAr4LemcBvsQzDy80yDWcY8mt17TM6IOkW4H+LBuo/O3qF2/sj/rQRAJPX6WMmMx4PZA3Q9XoiKLh/vmqxbE=  ;
Message-ID: <44724E00.8090000@yahoo.com.au>
Date: Tue, 23 May 2006 09:49:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add user taint flag
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org> <20060522033644.26d47a00.akpm@osdl.org> <20060522183352.GA4453@thunk.org>
In-Reply-To: <20060522183352.GA4453@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:

>
>+struct page *rmem_vma_nopage(struct vm_area_struct *vma,
>+                unsigned long address, int *type)
>+{
>+	struct page *pageptr;
>+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
>+	unsigned long physaddr = address - vma->vm_start + offset;
>+	unsigned long pageframe = physaddr >> PAGE_SHIFT;
>+
>+	if (!pfn_valid(pageframe))
>+		return NOPAGE_SIGBUS;
>+	pageptr = pfn_to_page(pageframe);
>+	get_page(pageptr);
>+	if (type)
>+		*type = VM_FAULT_MINOR;
>+	return pageptr;
>+}
>

This won't work because struct page could easily be a free page.

I think /dev/mem should be able to remap physical memory now that
PG_reserved is gone.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 

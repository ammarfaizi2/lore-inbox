Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbWCQN4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWCQN4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWCQN4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:56:07 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:33449 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932711AbWCQN4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:56:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=orwcx6amyEqYl8inUSZTstxKEyBvKaSh2bck7Dih+1HHm/mX4gk/GXuNydQ5TRYRk092I77YTEjLDw3uTFqdlTgQu11y36JiWWHHe9pNrFGBd+s4XQzd0qCH+Z03Hc47SlpbvSRqbApCdgLeLnfDkiR9C++mnMQ7Ws2SHR8xTHc=  ;
Message-ID: <441ABFF2.5060400@yahoo.com.au>
Date: Sat, 18 Mar 2006 00:56:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: carsteno@de.ibm.com
CC: Jes Sorensen <jes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
References: <yq0k6auuy5n.fsf@jaguar.mkp.net> <441ABEDD.4070003@de.ibm.com>
In-Reply-To: <441ABEDD.4070003@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otte wrote:
> Jes Sorensen wrote:
> 
>>Index: linux-2.6/include/linux/mm.h
>>===================================================================
>>--- linux-2.6.orig/include/linux/mm.h
>>+++ linux-2.6/include/linux/mm.h
>>@@ -199,6 +199,7 @@
>> 	void (*open)(struct vm_area_struct * area);
>> 	void (*close)(struct vm_area_struct * area);
>> 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
>>+	long (*nopfn)(struct vm_area_struct * area, unsigned long address, int *type);
>> 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
>> #ifdef CONFIG_NUMA
>> 	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
> 
> If you use address as parameter to nopfn, it won't work with highmem
> on 32bit systems. Alternative would be to use (unsigned long) phys. page
> frame number.
> 

It is vaddr, so that should be OK. Return is pfn, which is the important one.

> Your work in memory.c looks like the right thing to do.
> Afaics it will work for xip as well once I figure how to
> do COW. Cool stuff :-).
> 

I think you may be able to use VM_PFNMAP in much the same way as remap_pfn_range
does. You won't be able to support get_user_pages, of course.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

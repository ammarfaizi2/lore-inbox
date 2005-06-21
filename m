Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVFUSVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVFUSVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVFUSVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:21:49 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:54401 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261469AbVFUSVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:21:43 -0400
Message-ID: <42B85AB4.7030401@ammasso.com>
Date: Tue, 21 Jun 2005 13:21:40 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: get_user_pages() and shared memory question
References: <42B82DF2.2050708@ammasso.com> <Pine.LNX.4.61.0506211840210.5784@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0506211840210.5784@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> It depends on what you mean by allocate and deallocate.  If the second
> process is attaching the same shared memory segment as the first process
> had attached, then yes, its buffer will contain those very pages which
> the driver erroneously failed to release.

No, I'm talking about when the first process completely destroys the shared memory segment 
so that it no longer exists.  No processes are attached to it, and any attempt to attach 
to it results in an error, because it doesn't exist.

In this case, when a process creates a new memory segment, I just want to know whether the 
pages with a non-zero refcount (because of the get_user_pages() call) can ever be used in 
a new shared memory segment.

I'm assuming the answer is no, because that would defeat the purpose of refcount (right?). 
  I've been looking at the code and reading books on the VM, but I get lost easily.  It 
appears that the function which allocates a page is shmem_alloc_page(), which calls 
alloc_page() to do the actual work.  If that's correct, is it possible for alloc_page() to 
return a page that has been previously "claimed" by get_user_pages()?  I'm looking at 
__alloc_pages(), and I don't see any calls to page_count(), so I guess there's some other 
mechanism (either in get_user_pages() or in the way the VM works) that prevents this 
possibility.  However, I'm getting dangerously close to my limit of understanding the 
Linux VM.

Thanks for replying to my message.  I really appreciate the help in understanding the 
Linux VM.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13

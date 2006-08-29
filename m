Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWH2Ldz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWH2Ldz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWH2Ldz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:33:55 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:58799 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964929AbWH2Ldy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:33:54 -0400
Message-ID: <44F40E76.5000809@sw.ru>
Date: Tue, 29 Aug 2006 13:52:54 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: devel@openvz.org
CC: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Greg KH <greg@kroah.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Devel] [PATCH 6/6] BC: kernel memory accounting (marks)
References: <44EC31FB.2050002@sw.ru>  <44EC371F.7080205@sw.ru> <1156357820.12011.45.camel@localhost.localdomain>
In-Reply-To: <1156357820.12011.45.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> I'm still a bit concerned about if we actually need the 'struct page'
> pointer.  I've gone through all of the users, and I'm not sure that I
> see any that _require_ having a pointer in 'struct page'.  I think it
> will take some rework, especially with the pagetables, but it should be
> quite doable.
don't worry:
1. we will introduce a separate patch moving this pointer
  into mirroring array
2. this pointer is still required for _user_ pages tracking,
  that's why I don't follow your suggestion right now...

> vmalloc:
> 	Store in vm_struct
> fd_set_bits:
> poll_get:
> mount hashtable:
> 	Don't need alignment.  use the slab?
> pagetables:
> 	either store in an extra field of 'struct page', or use the
> 	mm's.  mm should always be available when alloc/freeing a
> 	pagetable page
> 
> Did I miss any?
flocks, pipe buffers, task_struct, sighand, signal, vmas,
posix timers, uid_cache, shmem dirs, 

Thanks,
Kirill

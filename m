Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUIWQHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUIWQHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUIWQHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:07:24 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:24524 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266364AbUIWQEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:04:24 -0400
Message-ID: <4152F19C.4000804@sgi.com>
Date: Thu, 23 Sep 2004 10:54:04 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Longerbeam <stevel@mwwireless.net>
CC: linux-mm <linux-mm@kvack.org>, lse-tech <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mm: memory policy for page cache allocation
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com> <20040920205509.GF4242@wotan.suse.de> <414F6C69.8060406@mwwireless.net>
In-Reply-To: <414F6C69.8060406@mwwireless.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Steve Longerbeam wrote:

> -------- original email follows ----------
> 
> Hi Andi,
> 
> I'm working on adding the features to NUMA mempolicy
> necessary to support MontaVista's MTA.
> 
> Attached is the first of those features, support for
> global page allocation policy for mapped files. Here's
> what the patch is doing:
> 
> 1. add a shared_policy tree to the address_space object in fs.h.
> 2. modify page_cache_alloc() in pagemap.h to take an address_space
>    object and page offset, and use those to allocate a page for the
>    page cache using the policy in the address_space object.
> 3. modify filemap.c to pass the additional {mapping, page offset} pair
>    to page_cache_alloc().
> 4. Also in filemap.c, implement generic file {set|get}_policy() methods and
>    add those to generic_file_vm_ops.
> 5. In filemap_nopage(), verify that any existing page located in the cache
>    is located in a node that satisfies the file's policy. If it's not in 
> a node that
>    satisfies the policy, it must be because the page was allocated 
> before the
>    file had any policies. If it's unused, free it and goto retry_find 
> (will allocate
>    a new page using the file's policy). Note that a similar operation is 
> done in
>    exec.c:setup_arg_pages() for stack pages.
> 6. Init the file's shared policy in alloc_inode(), and free the shared 
> policy in
>    destroy_inode().
> 
> I'm working on the remaining features needed for MTA. They are:
> 
> - support for policies contained in ELF images, for text and data regions.
> - support for do_mmap_mempolicy() and do_brk_mempolicy(). Do_mmap()
>   can allocate pages to the region before the function exits, such as 
> when pages
>   are locked for the region. So it's necessary in that case to set the 
> VMA's policy
>   within do_mmap() before those pages are allocated.
> - system calls for mmap_mempolicy and brk_mempolicy.
> 
> Let me know your thoughts on the filemap policy patch.
> 
> Thanks,
> Steve
> 
> 

Steve,

I guess I am a little lost on this without understanding what MTA is.
Is there a design/requirements document you can point me at?

Also, can you comment on how the above is related to my page cache
allocation policy patch?   Does having a global page cache allocation
policy with a per process override satisfy your requirements at all
or do you specifically have per file policies you want to specify?

(Just trying to figure out how to work both of our requirements into
the kernel in as simple as possible (but no simpler!) fashion.)

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------


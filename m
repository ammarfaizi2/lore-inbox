Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268882AbUHUHby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268882AbUHUHby (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 03:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUHUHby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 03:31:54 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:30337 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268882AbUHUHay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 03:30:54 -0400
Message-ID: <4126FA2D.4000804@namesys.com>
Date: Sat, 21 Aug 2004 00:30:53 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Alexander Zarochentcev <zam@namesys.com>,
       vs <vs@thebsh.namesys.com>
Subject: Re: 2.6.8.1-mm2
References: <Pine.LNX.4.44.0408201753250.4192-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408201753250.4192-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>
>  
>
>>reiser4-perthread-pages.patch
>>    
>>
>
>If a task exits unexpectedly, it will leak the reserved pages.
>This memory leak wants fixing...
>
>Also, why the !in_interrupt() test in perthread_pages_alloc() ?
>Surely this function shouldn't be called from interrupts, since
>it is a general purpose pool of pages.
>
>  
>
>>reiser4-radix-tree-tag.patch
>>    
>>
>
>Just a nitpick here, could we rename PAGECACHE_TAG_FS_SPECIFIC
>to PAGECACHE_TAG_FS_PRIVATE, since we're using the name "private"
>in half a number of other places for the exact same purpose ?
>
>  
>
>>reiser4-radix_tree_lookup_slot.patch
>>    
>>
>
>Having reiserfs dig into the radix tree looks like a layering
>violation to me.  If there is a real need to replace pagecache
>pages with other pages in the radix tree, maybe we should have
>a function to do that in the pagecache code, leaving reiserfs
>to call things at the right abstraction level ?
>
>I see a potential for race conditions when reiserfs changes a
>page which write has just looked up, and what about mmap?
>Even if the code is safe now, this is bound to result in a
>maintenance nightmare down the road.
>
>  
>
>>reiser4-truncate_inode_pages_range.patch
>>    
>>
>
>This has the same race issue as any of the "hole punch"
>patches that have been floating around in the past.  The
>truncate path has some (subtle!) race prevention that
>depends on the nopage functions not searching past i_size,
>but this hole punch code doesn't.
>
>I am not convinced this is SMP safe.
>
>cheers,
>
>Rik
>  
>
Thanks very much for identifying some races and leaks for us to look 
at.  Zam is the head of our Races and Leaks Department;-), so I will let 
him comment.

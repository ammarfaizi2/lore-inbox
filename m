Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbUJ1OML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbUJ1OML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUJ1OML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:12:11 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:14274 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S261272AbUJ1OK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:10:29 -0400
Message-ID: <4180FE0A.2020000@metaparadigm.com>
Date: Thu, 28 Oct 2004 22:11:22 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 page allocation failure. order:0, mode:0x20
References: <41808419.8070104@metaparadigm.com> <20041028024039.1a9f5056.akpm@osdl.org>
In-Reply-To: <20041028024039.1a9f5056.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/04 17:40, Andrew Morton wrote:
> Michael Clark <michael@metaparadigm.com> wrote:
>> cc1: page allocation failure. order:0, mode:0x20
>>   [<c013ba43>] __alloc_pages+0x1c3/0x390
>>   [<c013bc35>] __get_free_pages+0x25/0x40
>>   [<c013f283>] kmem_getpages+0x23/0xd0
>>   [<c013ffcf>] cache_grow+0xaf/0x160
>>   [<c0140202>] cache_alloc_refill+0x182/0x230
>>   [<c0140499>] kmem_cache_alloc+0x49/0x50
>>   [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>>   [<c01c0aad>] radix_tree_insert+0xed/0x110
>>   [<c014d841>] __add_to_swap_cache+0x71/0x100
>>   [<c014da5f>] add_to_swap+0x5f/0xc0
>>   [<c0142d32>] shrink_list+0x442/0x480
>>   [<c014bf7c>] page_referenced_anon+0x7c/0x90
>>   [<c01419c8>] __pagevec_release+0x28/0x40
> 
> 
> I'm confused.  2.6.9 uses __GFP_NOWARN in add_to_swap() so the messages
> should be suppressed.  Are you sure you're using 2.6.9?

Ya is 2.6.9, has uml-skas patch also but that doesn't touch swap_state.c

Ah, I see I think, radix_tree_node_alloc first calls kmem_cache_alloc
with root->gfp_mask and only if this fails dips into the preloaded
percpu node stash. Perhaps root->gfp_mask has !__GFP_NOWARN

Shouldn't it use the preloaded nodes that have been reserved anyway.

~mc

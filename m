Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbUJ1Osk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbUJ1Osk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbUJ1Osj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:48:39 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:17860 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S261318AbUJ1OqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:46:10 -0400
Message-ID: <41810668.1050800@metaparadigm.com>
Date: Thu, 28 Oct 2004 22:47:04 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 page allocation failure. order:0, mode:0x20
References: <41808419.8070104@metaparadigm.com> <20041028024039.1a9f5056.akpm@osdl.org> <4180FE0A.2020000@metaparadigm.com>
In-Reply-To: <4180FE0A.2020000@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/04 22:11, Michael Clark wrote:
> On 10/28/04 17:40, Andrew Morton wrote:
>>
>> I'm confused.  2.6.9 uses __GFP_NOWARN in add_to_swap() so the messages
>> should be suppressed.  Are you sure you're using 2.6.9?
> 
> 
> Ya is 2.6.9, has uml-skas patch also but that doesn't touch swap_state.c
> 
> Ah, I see I think, radix_tree_node_alloc first calls kmem_cache_alloc
> with root->gfp_mask and only if this fails dips into the preloaded
> percpu node stash. Perhaps root->gfp_mask has !__GFP_NOWARN
> 
> Shouldn't it use the preloaded nodes that have been reserved anyway.

 From my other traces - looks like as_get_io_context also needs to use
__GFP_NOWARN in get_io_context as a NULL return appears to be handled.
This is the only other noise i'm getting in my tests.

~mc

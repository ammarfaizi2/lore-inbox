Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUBVLOb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 06:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUBVLOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 06:14:31 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:13203 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261222AbUBVLOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 06:14:30 -0500
Message-ID: <40388BCC.2050309@colorfullife.com>
Date: Sun, 22 Feb 2004 12:00:28 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Large slab cache in 2.6.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Linus Torvalds <torvalds@osdl.org> wrote:
>>
>> What happened to the experiment of having slab pages on the (in)active
>>  lists and letting them be free'd that way? Didn't somebody already do 
>>  that? Ed Tomlinson and Craig Kulesa?
>
>That was Ed.  Because we cannot reclaim slab pages direct from the LRU
>
I think that this is needed: Bonwick's slab algorithm (i.e. two-level 
linked lists, implemented in cache_alloc_refill and  free_block) is 
intended for unfreeable objects.
The dentry cache is a cache of freeable objects - a different algorithm 
would be more efficient for shrinking the dentry cache after an updatedb.
I had started prototyping, but didn't get far.
--
    Manfred


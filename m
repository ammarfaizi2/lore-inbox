Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933640AbWLDFuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933640AbWLDFuZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 00:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933667AbWLDFuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 00:50:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39090 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933640AbWLDFuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 00:50:23 -0500
Message-ID: <4573B8DE.20205@redhat.com>
Date: Mon, 04 Dec 2006 00:57:50 -0500
From: Wendy Cheng <wcheng@redhat.com>
Reply-To: wcheng@redhat.com
Organization: Red Hat
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
References: <4564C28B.30604@redhat.com>	<20061122153603.33c2c24d.akpm@osdl.org>	<456B7A5A.1070202@redhat.com>	<20061127165239.9616cbc9.akpm@osdl.org>	<456CACF3.7030200@redhat.com>	<20061128162144.8051998a.akpm@osdl.org>	<456D2259.1050306@redhat.com>	<456F014C.5040200@redhat.com>	<20061201132329.4050d6cd.akpm@osdl.org>	<45730E36.10309@redhat.com> <20061203124752.15e35357.akpm@osdl.org>
In-Reply-To: <20061203124752.15e35357.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Sun, 03 Dec 2006 12:49:42 -0500
>Wendy Cheng <wcheng@redhat.com> wrote:
>
>  
>
>>I read this as "It is ok to give system admin(s) commands (that this 
>>"drop_pagecache_sb() call" is all about) to drop page cache. It is, 
>>however, not ok to give filesystem developer(s) this very same function 
>>to trim their own page cache if the filesystems choose to do so" ?
>>    
>>
>
>If you're referring to /proc/sys/vm/drop_pagecache then no, that isn't for
>administrators - it's a convenience thing for developers, to get repeatable
>benchmarks.  Attempts to make it a per-numa-node control for admin purposes have
>been rejected.
>  
>
Just saw you suggested the "next door" LKML thread ("la la la la ... 
swappiness") to use "-o sync" ? Well, now I do see you're determined ... 
anyway, I think I got my stuff working without this kernel patch ... 
still under testing though.

The rename post will be done first thing tomorrow morning.

>>[snip] .......
>>    
>>
>hmm, I suppose that makes sense.
>
>Are there dentries associated with these locks?
>  
>
Yes, dentries are part of the logic (during lookup time) but 
book-keepings (reference count, reclaim, delete, etc) are all done thru 
inode structures.

>  
>
>>>Did you look at improving that lock-lookup algorithm, btw?  Core kernel has
>>>no problem maintaining millions of cached VFS objects - is there any reason
>>>why your lock lookup cannot be similarly efficient?
>>> 
>>>      
>>>
Yes, just found the new DLM uses "jhash" call (include/linux/jhash.h). 
I'm on an older version of DLM that uses FNV hash algorithm 
(http://www.isthe.com/chongo/tech/comp/fnv/). Will do some performance 
test runs to compare these two methods.

A final note on this subject - I may not agree with you (about various 
things) but your comments and amazingly quick responses are very very 
appreciated !

-- Wendy


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVBBMRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVBBMRv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 07:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVBBMRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 07:17:51 -0500
Received: from [195.23.16.24] ([195.23.16.24]:43497 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262547AbVBBMRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 07:17:36 -0500
Message-ID: <4200C4D3.9060805@grupopie.com>
Date: Wed, 02 Feb 2005 12:17:23 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       penberg@cs.helsinki.fi
Subject: Re: [PATCH 2.6] 1/7 create kstrdup library function
References: <1107228501.41fef755e66e8@webmail.grupopie.com>	 <84144f0205020108441679cbef@mail.gmail.com>	 <41FFB5A1.20100@grupopie.com> <84144f02050201232324bebb3f@mail.gmail.com>
In-Reply-To: <84144f02050201232324bebb3f@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> At some point in time, I wrote:
> 
>>>kstrdup() is a special-case _memory allocator_ (not so much a string
>>>operation) so I think it should go into mm/slab.c where we currently
>>>have kcalloc().
> 
> 
> On Tue, 01 Feb 2005 17:00:17 +0000, Paulo Marques <pmarques@grupopie.com> wrote:
> 
>>I was following Rusty Russell's approach. Also, I believe this is more
>>intuitive because the standard libc strdup function is declared in string.h.
>>
>>However, I really don't have strong feelings either way, so if the
>>majority agrees that this should be in mm/slab, its fine by me.
> 
> 
> Intuitive, perhaps, but I think it's wrong. I don't like it because it
> makes string operations depend on slab. Furthermore, kstrdup() is not
> a string operation. It is about memory allocation, really, just like
> kcalloc().

I agree with the "is like kcalloc" argument in the sense that it does an 
allocation + something else. But in this case the "something else" is in 
fact a string operation, so this just seem to be in the middle.

> One possible way to clean this up would be to extract the
> standard-like allocators (kmalloc, kcalloc, and kstrdup) from
> mm/slab.c and move them into a separate file.

I don't like this approach. From a quick grep you get 4972 kmalloc's in 
.c files in the kernel tree and only 35 kstrdup's. Moving kstrdup around 
is still just 7 patches, kmalloc is a much bigger problem.

Anyway, as I said before, if more people believe that moving kstrdup 
into mm/slab.c is the way to go, then its fine by me. The problem I was 
trying to solve was having several versions of strdup-like functions all 
around the kernel, and this problem gets fixed either way. Right now, 
the poll goes something like this:

string.c: me, Rusty Russell
slab.c: Pekka Enberg

I think we need more votes :)

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

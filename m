Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVBBM3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVBBM3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 07:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVBBM3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 07:29:54 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:63909 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262525AbVBBM3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 07:29:40 -0500
References: <1107228501.41fef755e66e8@webmail.grupopie.com>
            <84144f0205020108441679cbef@mail.gmail.com>
            <41FFB5A1.20100@grupopie.com>
            <84144f02050201232324bebb3f@mail.gmail.com>
            <4200C4D3.9060805@grupopie.com>
In-Reply-To: <4200C4D3.9060805@grupopie.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Pekka Enberg <penberg@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: 1/7 create kstrdup library function
Date: Wed, 02 Feb 2005 14:29:39 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.4200C7B3.00003E1B@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques writes:
> I agree with the "is like kcalloc" argument in the sense that it does an 
> allocation + something else. But in this case the "something else" is in 
> fact a string operation, so this just seem to be in the middle.

Sure, but now you're forcing all users of <string.h> to depend on the slab 
as well. Conceptually, kstrdup() is an initializing memory allocator, not a 
string operation, which is why I think it should go into slab.c. 

Paulo Marques writes:
> I don't like this approach. From a quick grep you get 4972 kmalloc's in .c 
> files in the kernel tree and only 35 kstrdup's. Moving kstrdup around is 
> still just 7 patches, kmalloc is a much bigger problem.

Hmm? Yes, moving the declaration from slab.h to some other header is 
painful. I only talked about moving the definition from slab.c. 

Paulo Marques writes:
> Anyway, as I said before, if more people believe that moving kstrdup into 
> mm/slab.c is the way to go, then its fine by me. The problem I was trying 
> to solve was having several versions of strdup-like functions all around 
> the kernel, and this problem gets fixed either way. Right now, the poll 
> goes something like this: 
> 
> string.c: me, Rusty Russell
> slab.c: Pekka Enberg 
> 
> I think we need more votes :)

Could we also get Rusty's confirmation on this? 

       Pekka 


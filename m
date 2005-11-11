Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbVKKS25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVKKS25 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 13:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVKKS25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 13:28:57 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:37031 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750993AbVKKS24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 13:28:56 -0500
Message-ID: <4374E2D9.3020304@us.ibm.com>
Date: Fri, 11 Nov 2005 10:28:41 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       manfred@colorfullife.com, Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 6/9] Cleanup kmem_cache_create()
References: <4373DD82.8010606@us.ibm.com> <4373E011.9070508@us.ibm.com> <200511110910.38350.ioe-lkml@rameria.de>
In-Reply-To: <200511110910.38350.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Friday 11 November 2005 01:04, Matthew Dobson wrote:
> 
>>- if (size < 4096 || fls(size - 1) == fls(size - 1 + 3 * BYTES_PER_WORD))
>>+ if (size < RED_ZONE_LIMIT ||
>>+	fls(size - 1) == fls(size - 1 + 3 * BYTES_PER_WORD))
>>             flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
> 
> 
> I would suggest sth. like
> 
> if (size < RED_TONE_LIMIT
>     || fls(size - 1) = fls(size - 1 + 3 * BYTES_PER_WORD))
> 	flags |= SLAB_RED_ZONE | SLAB_STORE_USER
> 
> 
> Reason: A binary operator in front is a huge hint 
> 	that this is a continued line.
> 
> Just compare when you go to a store next time.
> 
> 	1
> +	2
> -	3
> *	4
> 
> is much more readable then
> 
> 1	+
> 2	-
> 3	*
> 4
> 
> right?
> 
> 
> Regards
> 
> Ingo Oeser

You make a very good point.  It's not the way that I'm used to writing
multi-line ifs, but it is a bit more readable.  However, since the rest of
the multi-line ifs in the file have the binary operator at the end of the
first line, I'm inclined to leave it the way it is for consistency.  If
anyone really feels strongly, I could come up with a patch for the whole
file...?

Thanks for the feedback!

-Matt

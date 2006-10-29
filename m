Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965315AbWJ2RsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965315AbWJ2RsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 12:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965316AbWJ2RsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 12:48:10 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:19978 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965315AbWJ2RsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 12:48:09 -0500
Message-ID: <4544E92C.8000103@shadowen.org>
Date: Sun, 29 Oct 2006 17:47:24 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Martin J. Bligh" <mbligh@google.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
References: <454442DC.9050703@google.com> <20061029000513.de5af713.akpm@osdl.org>
In-Reply-To: <20061029000513.de5af713.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 28 Oct 2006 22:57:48 -0700
> "Martin J. Bligh" <mbligh@google.com> wrote:
> 
>> -git4 was fine. -git5 is broken (on PPC64 blade)
>>
>> As -rc2-mm2 seemed fine on this box, I'm guessing it's something
>> that didn't go via Andrew ;-( Looks like it might be something
>> JFS or slab specific. Bigger PPC64 box with different config
>> was OK though.
>>
>> Full log is here: http://test.kernel.org/abat/59046/debug/console.log
>> Good -git4 run: http://test.kernel.org/abat/58997/debug/console.log
>>
>> kernel BUG in cache_grow at mm/slab.c:2705!
> 
> This?
> 
> --- a/mm/vmalloc.c~__vmalloc_area_node-fix
> +++ a/mm/vmalloc.c
> @@ -428,7 +428,8 @@ void *__vmalloc_area_node(struct vm_stru
>  	area->nr_pages = nr_pages;
>  	/* Please note that the recursion is strictly bounded. */
>  	if (array_size > PAGE_SIZE) {
> -		pages = __vmalloc_node(array_size, gfp_mask, PAGE_KERNEL, node);
> +		pages = __vmalloc_node(array_size, gfp_mask & ~__GFP_HIGHMEM,
> +					PAGE_KERNEL, node);
>  		area->flags |= VM_VPAGES;
>  	} else {
>  		pages = kmalloc_node(array_size,
> _

/me shoves it into the tests... results in a couple of hours.

-apw



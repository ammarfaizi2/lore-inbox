Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWJ2XAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWJ2XAS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 18:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWJ2XAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 18:00:18 -0500
Received: from dvhart.com ([64.146.134.43]:13984 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1030417AbWJ2XAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 18:00:16 -0500
Message-ID: <4545325D.8080905@mbligh.org>
Date: Sun, 29 Oct 2006 14:59:41 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@google.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
References: <454442DC.9050703@google.com> <20061029000513.de5af713.akpm@osdl.org> <4544E92C.8000103@shadowen.org>
In-Reply-To: <4544E92C.8000103@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> kernel BUG in cache_grow at mm/slab.c:2705!
>> This?
>>
>> --- a/mm/vmalloc.c~__vmalloc_area_node-fix
>> +++ a/mm/vmalloc.c
>> @@ -428,7 +428,8 @@ void *__vmalloc_area_node(struct vm_stru
>>  	area->nr_pages = nr_pages;
>>  	/* Please note that the recursion is strictly bounded. */
>>  	if (array_size > PAGE_SIZE) {
>> -		pages = __vmalloc_node(array_size, gfp_mask, PAGE_KERNEL, node);
>> +		pages = __vmalloc_node(array_size, gfp_mask & ~__GFP_HIGHMEM,
>> +					PAGE_KERNEL, node);
>>  		area->flags |= VM_VPAGES;
>>  	} else {
>>  		pages = kmalloc_node(array_size,
>> _
> 
> /me shoves it into the tests... results in a couple of hours.

Seems like that doesn't fix it, I'm afraid.

M.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTKJS7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264041AbTKJS7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:59:21 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:37317 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263081AbTKJS7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:59:19 -0500
Message-ID: <3FAFDFFF.70100@colorfullife.com>
Date: Mon, 10 Nov 2003 19:59:11 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: EFAULT reading /dev/mem... - broken x86info
References: <20031108162737.GB26350@vana.vc.cvut.cz> <20031110161114.GM10144@redhat.com> <3FAFC1D1.3090309@colorfullife.com> <20031110165654.GS10144@redhat.com> <3FAFC831.4090108@colorfullife.com> <20031110180551.GA20168@vana.vc.cvut.cz>
In-Reply-To: <20031110180551.GA20168@vana.vc.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

>On Mon, Nov 10, 2003 at 06:17:37PM +0100, Manfred Spraul wrote:
>  
>
>>DEBUG_PAGEALLOC unmaps pages on kmem_cache_free and __free_pages(). The 
>>pages are mapped again during get_free_pages and kmem_cache_alloc.
>>
>>0x86000 looks like a normal page - what guarantees that it's not used by 
>>the kernel?
>>    
>>
>
>With DEBUG_PAGEALLOC there is no problem with page if it is USED by the kernel.
>Problem is if page is NOT USED - in this case kernel does not have it in its
>mapping, and bad thing happen.
>  
>
If the page is used by AGP, then it won't have a mapping either.

>x86info (and other simillar tools for dumping different BIOS structures) just
>scans physical memory for some well known signatures - hoping that kernel did
>not smash these structures.
>  
>
Scanning physical memory is very dangerous: it's undefined what happens 
if a page is mapped multiple times with different cache settings. Athlon 
cpus prefetch whatever they see, and they speculatively set the dirty 
bit in cachelines for WB cacheable pages.

>Up to now it was possible to read whole physical memory from userspace - some 
>pages by reading /dev/mem, some pages by mmaping /dev/mem. Now it is not possible 
>anymore - which I think is bad, as /dev/mem has semantic of it.
>
I think /dev/mem should lie and return 0x00 for pages that are not in 
the linear mapping.

Or /dev/mem users should expect random holes.

--
    Manfred


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264010AbTKJRRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 12:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbTKJRRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 12:17:46 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:5573 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264010AbTKJRRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 12:17:44 -0500
Message-ID: <3FAFC831.4090108@colorfullife.com>
Date: Mon, 10 Nov 2003 18:17:37 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: EFAULT reading /dev/mem... - broken x86info
References: <20031108162737.GB26350@vana.vc.cvut.cz> <20031110161114.GM10144@redhat.com> <3FAFC1D1.3090309@colorfullife.com> <20031110165654.GS10144@redhat.com>
In-Reply-To: <20031110165654.GS10144@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Mon, Nov 10, 2003 at 05:50:25PM +0100, Manfred Spraul wrote:
> > It breaks either your app or your AGP driver - what's simpler to fix? 
> > I'm biased, because if you update the AGP driver, then I must figure out 
> > how to fix DEBUG_PAGEALLOC 8-)
>
>I'm not convinced changing agpgart is worth the pain.
>The only userspace app that actually grovels through the aperture
>in this way is the agpgart test code, so this shouldn't be an issue.
>  
>
You misunderstood my objection:
we cannot assume that every page is mapped in the kernel linear mapping:
- with DEBUG_PAGEALLOC, lots of pages are removed from the linear mapping
- even without it, all pages that are used for AGP are removed from the 
mapping.

Thus if something fails with DEBUG_PAGEALLOC, it will fail sometimes 
with AGP gart as well.

>I thought the DEBUG_PAGEALLOC stuff just unmapped pages that had been
>kmalloc'd ?  The area of memory we're trying to read those mptables from
>shouldn't be unmapped in the first place should they ? Confused.
>  
>
DEBUG_PAGEALLOC unmaps pages on kmem_cache_free and __free_pages(). The 
pages are mapped again during get_free_pages and kmem_cache_alloc.

0x86000 looks like a normal page - what guarantees that it's not used by 
the kernel?

--
    Manfred


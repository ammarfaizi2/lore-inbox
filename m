Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUFEKVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUFEKVH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 06:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUFEKVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 06:21:07 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:42383 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261181AbUFEKVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 06:21:04 -0400
Message-ID: <40C19E85.7090809@colorfullife.com>
Date: Sat, 05 Jun 2004 12:20:53 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use numa policy API for boot time policy
References: <20040605034356.1037d299.ak@suse.de>	<40C12865.9050803@colorfullife.com> <20040605041813.75e2d22d.ak@suse.de>
In-Reply-To: <20040605041813.75e2d22d.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Sat, 05 Jun 2004 03:56:53 +0200
>Manfred Spraul <manfred@colorfullife.com> wrote:
>  
>
>>Does it work for order != 0 allocations? It's important that the big 
>>hash tables do not end up all in node 0. AFAICS alloc_pages_current() 
>>calls interleave_nodes() only for order==0 allocs.
>>    
>>
>
>That's correct. It will only work for order 0 allocations.
>
>  
>
What's the purpose of the "&& order == 0)" test for MPOL_INTERLEAVE in 
alloc_pages_current?
What would break if it's removed?

And what about in_interrupt() allocations? During boot everything should 
be interleaved - I'd modify default_policy to MPOL_INTERLEAVE instead of 
setting process affinity.

--
    Manfred

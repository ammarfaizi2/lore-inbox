Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWJ3VKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWJ3VKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161489AbWJ3VKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:10:47 -0500
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:42911 "EHLO smTp.neuf.fr")
	by vger.kernel.org with ESMTP id S1161366AbWJ3VKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:10:47 -0500
Date: Mon, 30 Oct 2006 22:09:46 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] vmalloc : optimization, cleanup, bugfixes
In-reply-to: <Pine.LNX.4.64.0610301234500.20628@montezuma.fsmlabs.com>
To: Zwane Mwaikambo <zwane@infradead.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Message-id: <45466A1A.706@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <453C3A29.4010606@intel.com>
 <20061022214508.6c4f30c6.akpm@osdl.org>
 <200610231036.10418.dada1@cosmosbay.com> <453C87A6.4060602@yahoo.com.au>
 <Pine.LNX.4.64.0610301234500.20628@montezuma.fsmlabs.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo a écrit :
> On Mon, 23 Oct 2006, Nick Piggin wrote:
> 
>> Eric Dumazet wrote:
>>> [PATCH] vmalloc : optimization, cleanup, bugfixes
>>>
>>> This patch does three things
>>>
>>> 1) reorder 'struct vm_struct' to speedup lookups on CPUS with small cache
>>> lines. The fields 'next,addr,size' should be now in the same cache line, to
>>> speedup lookups.
>>>
>>> 2) One minor cleanup in __get_vm_area_node()
>>>
>>> 3) Bugfixes in vmalloc_user() and vmalloc_32_user()
>>> NULL returns from __vmalloc() and __find_vm_area() were not tested.
>> Hmm, so they weren't. As far as testing the return of __find_vm_area,
>> you can just turn that into a BUG_ON(!area), because at that point,
>> we've established that the vmalloc succeeded.
> 
> No need for a BUG_ON it'll simply be a NULL dereference, at which point 
> we're back to the original code.

Indeed

This is what Andrew said one week ago :)


Return-Path: <linux-kernel-owner+w=401wt.eu-S932578AbWLMLDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWLMLDR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWLMLDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:03:17 -0500
Received: from elvis.mu.org ([192.203.228.196]:57375 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932578AbWLMLDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:03:16 -0500
Message-ID: <457FDDCE.7010303@FreeBSD.org>
Date: Wed, 13 Dec 2006 03:02:38 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
CC: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel@vger.kernel.org, balbir@in.ibm.com, csturtiv@sgi.com,
       daw@sgi.com, guillaume.thouvenin@bull.net, jlan@sgi.com,
       nagar@watson.ibm.com, tee@sgi.com
Subject: Re: [patch 03/13] io-accounting: write accounting
References: <200612081152.kB8BqQvb019756@shell0.pdx.osdl.net>	<457FBDBE.10102@FreeBSD.org> <20061213005954.e2d32446.akpm@osdl.org> <457FD777.9040703@FreeBSD.org>
In-Reply-To: <457FD777.9040703@FreeBSD.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suleiman Souhlal wrote:
> Andrew Morton wrote:
> 
>> On Wed, 13 Dec 2006 00:45:50 -0800
>> Suleiman Souhlal <ssouhlal@FreeBSD.org> wrote:
>>
>>
>>> akpm@osdl.org wrote:
>>>
>>>> From: Andrew Morton <akpm@osdl.org>
>>>>
>>>> Accounting writes is fairly simple: whenever a process flips a page 
>>>> from clean
>>>> to dirty, we accuse it of having caused a write to underlying 
>>>> storage of
>>>> PAGE_CACHE_SIZE bytes.
>>>
>>>
>>> On architectures where dirtying a page doesn't cause a page fault 
>>> (like i386), couldn't you end up billing the wrong process (in fact, 
>>> I think that even on other archituctures set_page_dirty() doesn't get 
>>> called immediately in the page fault handler)? 
>>
>>
>>
>> Yes, that would be a problem in 2.6.18 and earlier.
>>
>> In 2.6.19 and later, we do take a fault when transitioning a page from
>> pte-clean to pte-dirty.  That was done to get the dirty-page accounting
>> right - to avoid the 
>> all-of-memory-is-dirty-but-the-kernel-doesn't-know-it
>> problem.
> 
> 
> Ah yes indeed. I'm unable to keep up with all the new developments. :-(
> 
> However, if my understanding of this code is correct, it seems that the
> page fault is only done for shared writable VMAs, so you still can't
> rely on set_page_dirty() always being called by the process that
> dirtied the page in the first place.
> 
> Am I wrong?

Yes I am.
The only I/O non-shared VMAs might cause is from swapping, and I'm not
sure if the io accounting patches actually care about that.
My confusion came from the term "shared": A VMA is considered shared
whenever MAP_SHARED is specified, even if it only has only one single
"user".

-- Suleiman

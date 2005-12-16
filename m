Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVLPVNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVLPVNX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVLPVNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:13:23 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:38604 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932427AbVLPVNW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:13:22 -0500
Date: Fri, 16 Dec 2005 13:08:30 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Lee Revell <rlrevell@joe-job.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks 
In-Reply-To: <Pine.LNX.4.61.0512161407270.31274@chaos.analogic.com>
Message-ID: <Pine.LNX.4.62.0512161304120.5919@qynat.qvtvafvgr.pbz>
References: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.61.0512161407270.31274@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2005, linux-os (Dick Johnson) wrote:

> On Fri, 16 Dec 2005, Horst von Brand wrote:
>
>> linux-os \(Dick Johnson\) <linux-os@analogic.com> wrote:
>>
>> [...]
>>
>>> Throughout the past two years of 4k stack-wars, I never heard why
>>> such a small stack was needed (not wanted, needed). It seems that
>>> everybody "knows" that smaller is better and most everybody thinks
>>> that one page in ix86 land is "optimum". However I don't think
>>> anybody ever even tried to analyze what was better from a technical
>>> perspective. Instead it's been analyzed as religious dogma, i.e.,
>>> keep the stack small, it will prevent idiots from doing bad things.
>>
>> OK, so here goes again...
>>
>> The kernel stack has to be contiguous in /physical/ memory. Keep the
> stack
>> /one/ page, that way you can always get a new stack when needed (==
> each
>> fork(2) or clone(2)). If the stack is 2 (or more) pages, you'll have
> to
>> find (or create) a multi-page free area, and (fragmentation being what
> it
>> is, and Linux routinely running for months at a time) you are in a
> whole
>> new world of pain.
>
> The interrupt stack needs to be non-paged. Are you sure the user-stacks
> need to be 'physical', non-paged too? If so, that's probably the
> problem. All addresses accessed by the CPUs in the kernel are virtual
> which means one needs some mapping anyway.

actually, the kernel always uses real addresses, userspace uses virtual 
addresses.

This came up recently with the page tables, Linus said that he was 
absolutly opposed to adding the complication and overhead of changine the 
kernel to user virtual addresses instead of real addresses for it's data 
structures. it would add an extra level of redirection to just about every 
memory access (which also means an additional load on the cache to store 
the mapping info to resolve this redirection). The performance hit for 
this would be considerable.

David Lang

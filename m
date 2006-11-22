Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755837AbWKVN3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837AbWKVN3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 08:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755847AbWKVN3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 08:29:46 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:62160 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1755837AbWKVN3q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 08:29:46 -0500
Date: Wed, 22 Nov 2006 13:29:44 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andi Kleen <ak@suse.de>
Cc: d binderman <dcb314@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: arch/x86_64/mm/numa.c(124): remark #593: variable "bootmap_size"
 was set but nev
In-Reply-To: <p73mz6j8xdv.fsf@bingen.suse.de>
Message-ID: <Pine.LNX.4.64.0611221319340.23776@skynet.skynet.ie>
References: <BAY107-F11C5D88BF00FBB291F3FC09CE30@phx.gbl> <p73mz6j8xdv.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006, Andi Kleen wrote:

> "d binderman" <dcb314@hotmail.com> writes:
>
>> Hello there,
>>
>> I just tried to compile Linux kernel 2.6.18.3 with the Intel C
>> C compiler.
>>
>> The compiler said
>>
>> arch/x86_64/mm/numa.c(124): remark #593: variable "bootmap_size" was
>> set but never used
>
> Actually it looks like a real bug -- probably added recently with the
> new bootmap code.
>
> The bootmap should be reserved based on that size.
>

I checked the arch-independent sizing patches submitted related to x86_64 
and no line is changed that does anything with bootmap_size so that ruled 
out an obvious candidate. I did a diff on a grep for bootmap_size in 
arch/x86_64 and found that there is no difference in usage between 2.6.18 
and 2.6.19-rc6. Both call reserve_bootmem(bootmap, bootmap_size) which has 
changed. However, the changes seem to be more cosmetic than anything else 
using PFN_DOWN and PFN_UP instead of some_value/PAGE_SIZE so it's not 
super-clear where the warning is coming from.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab

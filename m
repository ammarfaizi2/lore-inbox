Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWBMVUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWBMVUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWBMVUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:20:04 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:60289 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1030187AbWBMVUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:20:01 -0500
Date: Mon, 13 Feb 2006 13:19:57 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v25
In-Reply-To: <Pine.LNX.4.62.0602131313250.3110@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0602131317540.2608@qynat.qvtvafvgr.pbz>
References: <200602120141.46084.kernel@kolivas.org><Pine.LNX.4.62.0602131256000.3026@schroedinger.engr.sgi.com><Pine.LNX.4.62.0602131309120.2608@qynat.qvtvafvgr.pbz>
 <Pine.LNX.4.62.0602131313250.3110@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Christoph Lameter wrote:

> Date: Mon, 13 Feb 2006 13:16:00 -0800 (PST)
> From: Christoph Lameter <clameter@engr.sgi.com>
> To: David Lang <dlang@digitalinsight.com>
> Cc: Con Kolivas <kernel@kolivas.org>,
>     linux kernel mailing list <linux-kernel@vger.kernel.org>,
>     Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
> Subject: Re: [PATCH] mm: Implement Swap Prefetching v25
> 
> On Mon, 13 Feb 2006, David Lang wrote:
>
>> On Mon, 13 Feb 2006, Christoph Lameter wrote:
>>> spare ram when swapping??? We are already under memory pressure. Why make
>>> it worse by getting rid of the few bits of available memory? If a system
>>> swaps then we are per definition in the bad performance range. Add more
>>> memory.
>> when a program exits it's memory is now free, rather then just waiting until
>> something uses this memory up normally, this patch attempts to fill that
>> memory with things that are expected to be useful (things that were swapped
>> out)
>
> Then trigger this action when a program exits and when you know there was
> enough freed up to justify such an action. However, this is still a
> heuristic. No one knows if the pages read from swap will be of any use at
> all. For all I know a process may want to allocate some memory and fail
> because the memory was needlessly spend to read in pages that no one
> needs.

this won't happen, becouse if a program requests memory the kernel will 
through away data from the swap cache that's unchanged on disk (like the 
memory just filled by this) to free up memory for the program.

you don't want to trigger this on a program exit becouse the system is 
likly to be busy doing other things at that time, you want to try and do 
this when the system is otherwise idle.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare


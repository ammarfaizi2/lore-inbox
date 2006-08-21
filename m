Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWHUIye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWHUIye (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWHUIye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:54:34 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:14722 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750751AbWHUIye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:54:34 -0400
Message-ID: <44E9755F.8080405@sw.ru>
Date: Mon, 21 Aug 2006 12:57:03 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru> <44E33C8A.6030705@sw.ru>	 <1155754029.9274.21.camel@localhost.localdomain>	<44E46FC4.2050002@sw.ru>	 <1155825379.9274.39.camel@localhost.localdomain>  <44E57689.9070209@sw.ru> <1155912188.9274.79.camel@localhost.localdomain>
In-Reply-To: <1155912188.9274.79.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Fri, 2006-08-18 at 12:12 +0400, Kirill Korotaev wrote:
> 
>>LDT takes from 1 to 16 pages. and is allocated by vmalloc.
>>do you propose to replace it with slab which can fail due to memory
>>fragmentation?
> 
> 
> Nope.  ;)
so what is your proposal then? Sorry, probably missed it due to lots of emails :)

>>the same applies to fdset, fdarray, ipc ids and iptables entries. 
> 
> 
> The vmalloc area, along with all of those other structures _have_ other
> data structures.  Now, it will take a wee bit more patching to directly
> tag those thing with explicit container pointers (or accounting
> references), but I would much prefer that, especially for the things
> that are larger than a page.
do you mean that you prefer adding a explicit pointer to the structures
itself?

> I worry that this approach was used instead of patching all of the
> individual subsystems because this was easier to maintain as an
> out-of-tree patch, and it isn't necessarily the best approach.
:) if we were to optimize for patch size then we would select vserver
approach and be happy...

Dave, we used to add UBC pointers on each data structure and then do
a separate accounting in the places where objects are allocated.
We spent a lot of time and investigation on how to make it better,
because it was leading to often accounting errors, wrong error paths etc.
The approach provided in this patchset proved to be much more efficient
and more error prone. And it is much much more elegant!

Thanks,
Kirill

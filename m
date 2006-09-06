Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWIFOZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWIFOZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWIFOZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:25:00 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:48405 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750790AbWIFOY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:24:59 -0400
Message-ID: <44FED84A.9090002@sw.ru>
Date: Wed, 06 Sep 2006 18:16:42 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 9/13] BC: locked pages (charge hooks)
References: <44FD918A.7050501@sw.ru> <44FD97D1.4070206@sw.ru> <44FE43E7.1030003@yahoo.com.au>
In-Reply-To: <44FE43E7.1030003@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,

> Kirill Korotaev wrote:
> 
> 
>>Introduce calls to BC core over the kernel to charge locked memory.
>>
>>Normaly new locked piece of memory may appear in insert_vm_struct,
>>but there are places (do_mmap_pgoff, dup_mmap etc) when new vma
>>is not inserted by insert_vm_struct(), but either link_vma-ed or
>>merged with some other - these places call BC code explicitly.
>>
>>Plus sys_mlock[all] itself has to be patched to charge/uncharge
>>needed amount of pages.
> 
> 
> 
> I still haven't heard your good reasons why such a complex scheme is
> required when my really simple proposal of unconditionally charging
> the page to the container it was allocated by.
Nick can you elaborate what your proposal is?
Probably I missed it somewhere...

> That has the benefit of not being full of user explotable holes and
> also not putting such a huge burden on mm/ and the wider kernel in
> general.
I guess you will have to account locked pages still and
thus complexity won't be reduced much in this regard...

Thanks,
Kirill

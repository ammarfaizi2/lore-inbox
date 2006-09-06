Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWIFIsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWIFIsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 04:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWIFIsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 04:48:06 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:38195 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750696AbWIFIsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 04:48:02 -0400
Message-ID: <44FE8A8D.9090801@openvz.org>
Date: Wed, 06 Sep 2006 12:45:01 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 9/13] BC: locked pages (charge hooks)
References: <44FD918A.7050501@sw.ru> <44FD97D1.4070206@sw.ru> <44FE43E7.1030003@yahoo.com.au>
In-Reply-To: <44FE43E7.1030003@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Kirill Korotaev wrote:
>
>> Introduce calls to BC core over the kernel to charge locked memory.
>>
>> Normaly new locked piece of memory may appear in insert_vm_struct,
>> but there are places (do_mmap_pgoff, dup_mmap etc) when new vma
>> is not inserted by insert_vm_struct(), but either link_vma-ed or
>> merged with some other - these places call BC code explicitly.
>>
>> Plus sys_mlock[all] itself has to be patched to charge/uncharge
>> needed amount of pages.
>
>
> I still haven't heard your good reasons why such a complex scheme is
> required when my really simple proposal of unconditionally charging
> the page to the container it was allocated by.
Charging the page to the container it was allocated in is a possible and
correct way, we agree, but how does this comment refer to locked pages
accounting?
>
> That has the benefit of not being full of user explotable holes and
> also not putting such a huge burden on mm/ and the wider kernel in
> general.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTJKJhN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 05:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTJKJhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 05:37:12 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:20148 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262048AbTJKJhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 05:37:11 -0400
Message-ID: <3F87CF3D.8080402@colorfullife.com>
Date: Sat, 11 Oct 2003 11:37:01 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7 DEBUG_PAGEALLOC oops
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike wrote:

>Unable to handle kernel paging request at virtual address c034a000
> printing eip:
>c0134d5a
>*pde = 00102027
>*pte = 0034a000
>
Fault trying to read from address 0xc034a000: the page is not mapped.

>Oops: 0000 [#1]
>CPU:    0
>EIP:    0060:[<c0134d5a>]    Not tainted
>EFLAGS: 00010002
>EIP is at store_stackinfo+0x4e/0x80
>
In store_stackinfo: the function stores a backtrace of the last 
kmem_cache_free caller in the object - might be useful, and the memory 
is not used.

>eax: 00000000   ebx: c7802f98   ecx: c0301390   edx: c030138c
>esi: c0349ffe   edi: 017e0008   ebp: c0349da6   esp: c0349d96
>ds: 007b   es: 007b   ss: 0068
>Process swapper (pid: 0, threadinfo=c0348000 task=c02fcbe0)
>
The esp value is sane, the stack is at 0xc0348000, and the fault is at 
'a000: just behind the end of the stack.
I assume the fauling line is
                        svalue = *sptr++;

It looks like store stackinfo accesses memory behind the end of the stack.
Which gcc version do you use? Could you send me mm/slab.o?

--
    Manfred


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266781AbUHIRdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266781AbUHIRdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266783AbUHIRdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:33:00 -0400
Received: from smtp.rol.ru ([194.67.21.9]:58217 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S266781AbUHIRcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:32:55 -0400
Message-ID: <4117B5DB.7060602@vlnb.net>
Date: Mon, 09 Aug 2004 21:35:23 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: ru, en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
References: <20040805200622.GA17324@logos.cnet> <411392E0.6080507@vlnb.net> <20040806143359.GC20911@logos.cnet> <4113A579.5060702@vlnb.net> <20040806155328.GA21546@logos.cnet> <4113B752.7050808@vlnb.net> <20040806170931.GA21683@logos.cnet> <411794E8.6000806@vlnb.net> <20040809155009.GB6361@logos.cnet>
In-Reply-To: <20040809155009.GB6361@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>>>Not really. x86 doesnt have such an instruction.
>>
>>But how then spin_lock() works? It guarantees memory sync between CPUs, 
>>doesn't it? Otherwise how can it prevent possible races with concurrent 
>>data modifications?
> 
> It makes use of the "lock" instruction to lock the bus before the "dec" instruction:
>                                                                                                                                                                                    
> #define spin_lock_string \
>         "\n1:\t" \
>         "lock ; decb %0\n\t" \
>         "js 2f\n" \
> 
> That way it prevent races wrt other CPUs. atomic accesses which need to modify 
> (atomic_inc, atomic_dec, etc) data also use the "lock" to prevent other CPUs 
> from reading the data. 
> 
> grep for "lock" in include/asm-i386/.
> 
> As hpa said, most x86 instructions (except SSE-related ones) are
> strictly ordered (except the cases Alan pointed, which were not known 
> to me).
> 
> Thats why there is no "sync"-like instruction on x86 (again, except SSE-related 
> ones).
> 
> This is just a simple and short explanation of how this works. It gets more complex
> you think about cache coherency between processors, etc. For more details 
> the best book probably is "UNIX Systems for Modern Architectures. 
> Symmetric Multiprocessing and Caching for Kernel Programming" - Curt Schimmel (which 
> has been suggested here over and over).

I know basically, how spinlocks work to provide ordering, my question 
was about the cache coherency. Thanks for the link to the book, I will 
try to find it.

Vlad

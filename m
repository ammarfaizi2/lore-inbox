Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVJOTF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVJOTF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 15:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVJOTF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 15:05:57 -0400
Received: from [194.90.79.130] ([194.90.79.130]:33296 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751197AbVJOTF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 15:05:56 -0400
Message-ID: <4351530C.3070907@argo.co.il>
Date: Sat, 15 Oct 2005 21:05:48 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: EDAC atomic scrub operations
References: <1129402528.17923.9.camel@localhost.localdomain>
In-Reply-To: <1129402528.17923.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2005 19:05:50.0781 (UTC) FILETIME=[755966D0:01C5D1BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>linux-2.6.14-rc2-mm1/include/asm-x86_64/atomic.h
>--- linux.vanilla-2.6.14-rc2-mm1/include/asm-x86_64/atomic.h	2005-09-22 15:22:11.000000000 +0100
>+++ linux-2.6.14-rc2-mm1/include/asm-x86_64/atomic.h	2005-10-14 18:29:47.000000000 +0100
>@@ -378,4 +378,16 @@
> #define smp_mb__before_atomic_inc()	barrier()
> #define smp_mb__after_atomic_inc()	barrier()
> 
>+/* ECC atomic, DMA, SMP and interrupt safe scrub function */
>+
>+static __inline__ void atomic_scrub(unsigned long *virt_addr, u32 size)
>+{
>+	u32 i;
>+	for (i = 0; i < size / 4; i++, virt_addr++)
>  
>
(size+7)  / 8? or increment virt_addr by 0.5? :)

>+		/* Very carefully read and write to memory atomically
>+		 * so we are interrupt, DMA and SMP safe.
>+		 */
>+		__asm__ __volatile__("lock; addl $0, %0"::"m"(*virt_addr));
>  
>
shouldn't that be addq?

>+}
>+
> #endif
>  
>

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


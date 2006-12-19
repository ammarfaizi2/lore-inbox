Return-Path: <linux-kernel-owner+w=401wt.eu-S1751768AbWLSMrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWLSMrf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 07:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWLSMrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 07:47:35 -0500
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:61952 "EHLO
	lin5.shipmail.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751768AbWLSMre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 07:47:34 -0500
Message-ID: <4587DF61.5020007@tungstengraphics.com>
Date: Tue, 19 Dec 2006 13:47:29 +0100
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@linux.ie>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] agpgart - allow user-populated memory types.
References: <4579ADE3.6040609@tungstengraphics.com>	 <1165616236.27217.108.camel@laptopd505.fenrus.org>	 <1095.213.114.71.166.1165619148.squirrel@www.shipmail.org>	 <1166518064.3365.1188.camel@laptopd505.fenrus.org>	 <4587B47F.20008@tungstengraphics.com> <1166530649.3365.1237.camel@laptopd505.fenrus.org>
In-Reply-To: <1166530649.3365.1237.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>A short background:
>>The current code uses vmalloc only. The potential use of kmalloc was 
>>introduced
>>to save memory and cpu-speed.
>>All agp drivers expect to see a single memory chunk, so I'm not sure we 
>>want to have an array of pages. That may require rewriting a lot of code.
>>    
>>
>
>but if it's clearly the right thing.....
>How hard can it be? there are what.. 5 or 6 AGP drivers in the kernel?
>
>
>  
>
Hmm,
but we would still waste a lot of memory compared to kmalloc,
when the amount of memory needed is much less than one page, which tends 
to be
a very common case.

Unless we allow the first entry in the array to be the virtual adress to an
arbitrary-sized (max one page) kmalloc() area, the rest of the entries 
can be pointers
to pages allocated with __get_free_page().

This would almost introduce the same level of confusion as the original 
proposal,
and effectively we'd be doing virtual address translation in software 
for each access.

>>If it's acceptable I'd like to go for the vmalloc / kmalloc flag, or at 
>>worst keep the current vmalloc only but that's such a _huge_ memory 
>>waste for small buffers. The flag was the original idea, but 
>>unfortunately the agp_memory struct is part of the drm interface, and I 
>>wasn't sure we could add a variable to it.
>>    
>>
>
>I doubt this is part of the userspace interface so for sure we can
>change it to be right.
>
>
>  
>
/Thomas


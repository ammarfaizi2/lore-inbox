Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVATVTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVATVTv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVATVTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:19:51 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:54229 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261956AbVATVTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:19:46 -0500
Message-ID: <41F0206C.5040605@cosmosbay.com>
Date: Thu, 20 Jan 2005 22:19:40 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Something very strange on x86_64 2.6.X kernels
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>	<20050120162807.GA3174@stusta.de>	<20050120164829.GG450@wotan.suse.de>	<41F01A50.1040109@cosmosbay.com> <20050120130848.14a92990.akpm@osdl.org>
In-Reply-To: <20050120130848.14a92990.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Eric Dumazet <dada1@cosmosbay.com> wrote:

>>
>>Every time the crash occurs when one thread is using some ram located at 
>>virtual address 0xffffe6xx
> 
> 
> What does "using" mean?  Is the program executing from that location?

No, the program text is located between 0x00100000 and 0x001c6000  (no 
shared libs)

0xffffe6xx is READ|WRITE data, mapped on Hugetlb fs

extract from /proc/pid/maps
ff400000-100400000 rw-s 82000000 00:0b 12960938 
    /huge/file

> 
> Interesting.  IIRC, opterons will very occasionally (and incorrectly) take
> a fault when performing a prefetch against a dud pointer.  The kernel will
> fix that up.  At a guess, I'd say tha the fixup code isn't doing the right
> thing when the faulting EIP is in the vsyscall page.

Maybe, but I want to say that in this case, the address 'prefetched' is 
valid (ie mapped read/write by the program, on a huge page too)

Thanks
Eric Dumazet


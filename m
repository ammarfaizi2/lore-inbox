Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTKYQhZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTKYQhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:37:04 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:58533 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262330AbTKYQe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:34:26 -0500
Message-ID: <3FC3848A.5010908@softhome.net>
Date: Tue, 25 Nov 2003 17:34:18 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-rc5
References: <VK1t.6TB.1@gated-at.bofh.it>
In-Reply-To: <VK1t.6TB.1@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

   I was investigating memory allocation problems on my systems.
   And I only figured out that I'm using quite up-to-date kernel - 2.4.22.

   This is my post from another thread:

>    Vanilla 2.4.22 (this is x86) (with HZ=1024, if it does matter).
> 
>    after '# echo -1 >/proc/sys/vm/overcommit_memory'
>    1. test app with memory touch still gets killed by 
>       oom_killer. (so no malloc() == NULL)
>    2. test app w/o memory touch still can happily allocate 2.8GB 
>       of memory (x86 - looks like 3/1 memory split) and only then 
>       gets NULL pointer - oom_killer is silent.

   "overcommit_memory < 0" supposed to not allow apps to overallocate 
memory - but still it works not like it is said in 
Documentation/filesystems/proc.txt.
    So apps which try to be MM friendly can silently break due to 
very-very lazy memory allocation in kernel. Not nice when malloc() says 
"everything is fine!".

   [ Just checked: with overcommit==-1, as soon app trying to touch 
those magic 2.8GB of memory, it gets killed by oom_killer. This is 
totally wrong... ]

   Probably fix docs at least... :-(

Marcelo Tosatti wrote:
> 
> Hi, 
> 
> Yet another thing showed up (possible data corruption on x86-64), so here 
> goes -rc5.
> 
> 
> Summary of changes from v2.4.23-rc4 to v2.4.23-rc5
> ============================================
> 
> Andi Kleen:
>   o Fix 32bit truncate64 on x86-64
> 
> Marcelo Tosatti:
>   o Felix Radensky: Remove debugging printk from agpgart
>   o Changed EXTRAVERSION to -rc5
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbVLWKdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbVLWKdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 05:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbVLWKdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 05:33:44 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:59566 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1030479AbVLWKdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 05:33:43 -0500
Message-ID: <43ABD178.2020203@cosmosbay.com>
Date: Fri, 23 Dec 2005 11:29:12 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <5lQOU-492-31@gated-at.bofh.it> <5lQOU-492-29@gated-at.bofh.it> <E1Epjug-0001iA-In@be1.lrz>
In-Reply-To: <E1Epjug-0001iA-In@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 23 Dec 2005 11:29:16 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert a écrit :
> Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> 
>> "With some drawbacks" is the point: It has been determined that the
>> drawbacks are heavy enough that the 8KiB stack option should go.
> 
> Determined by voodoo and wild guessing.
> 
> Let's detect the need for 4K stacks: (I hope I found the correct place)
> 
> (Maybe the printk should be completely ifdefed, but I'm not sure)
> 
> 
> Signed-off-by: Bodo Eggert <7eggert@gmx.de>
> 
> --- 2.6.14/kernel/fork.c.ori    2005-12-21 19:06:24.000000000 +0100
> +++ 2.6.14/kernel/fork.c        2005-12-21 19:15:23.000000000 +0100
> @@ -168,4 +168,9 @@ static struct task_struct *dup_task_stru
>         if (!ti) {
>                 free_task_struct(tsk);
> +               printk(KERN_WARNING, "Can't allocate new task structure"
> +#ifndef CONFIG_4KSTACKS
> +               ". Maybe you could benefit from 4K stacks.\n"
> +#endif
> +               "\n");
>                 return NULL;
>         }
> 

This patch is not OK but for i386 architecture.

For example, x86_64 cannot use a 4K stack, it needs a 8KB stack (so a order-1 
allocation that may fail)

Eric


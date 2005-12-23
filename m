Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbVLWKoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbVLWKoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 05:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbVLWKoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 05:44:55 -0500
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:35855 "EHLO
	BAYC1-PASMTP07.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1030481AbVLWKoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 05:44:54 -0500
Message-ID: <BAYC1-PASMTP07A5FBE9B828DA420B2F7AAE330@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <38510.10.10.10.28.1135334691.squirrel@linux1>
In-Reply-To: <E1Epjug-0001iA-In@be1.lrz>
References: <5lQOU-492-31@gated-at.bofh.it> <5lQOU-492-29@gated-at.bofh.it>
    Lines:	30 <E1Epjug-0001iA-In@be1.lrz>
Date: Fri, 23 Dec 2005 05:44:51 -0500 (EST)
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: "Sean" <seanlkml@sympatico.ca>
To: 7eggert@gmx.de
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Parag Warudkar" <kernel-stuff@comcast.net>,
       "Dumitru Ciobarcianu" <dumitru.ciobarcianu@ines.ro>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>,
       "Andi Kleen" <ak@suse.de>, "Adrian Bunk" <bunk@stusta.de>,
       "Kyle Moffett" <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 23 Dec 2005 10:45:37.0937 (UTC) FILETIME=[02CD9810:01C607AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, December 23, 2005 5:12 am, Bodo Eggert said:
> Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>
>> "With some drawbacks" is the point: It has been determined that the
>> drawbacks are heavy enough that the 8KiB stack option should go.
>
> Determined by voodoo and wild guessing.

Bullshit.  There's no more guessing involved than you thinking 8K stacks
are sufficient.   How do you know that 8K stacks are enough?   If you
don't understand the testing and common sense that has gone into 4K+4K
stacks you should really be putting in a patch for 128K stacks, because
you don't have any proof that 8K stacks are sufficient either (except by
voodoo and wild guessing).   However, if you _do_ understand the testing
and coding methods then you'll see that 4K + 4K stacks are sufficient
(modulo any bugs, which should be fixed).

Sean



>
> Let's detect the need for 4K stacks: (I hope I found the correct place)
>
> (Maybe the printk should be completely ifdefed, but I'm not sure)
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

>


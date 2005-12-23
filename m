Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbVLWXI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbVLWXI7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 18:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbVLWXI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 18:08:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51627 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161124AbVLWXI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 18:08:58 -0500
Date: Sat, 24 Dec 2005 00:08:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: 7eggert@gmx.de
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051223230828.GB16043@elf.ucw.cz>
References: <5lQOU-492-31@gated-at.bofh.it> <5lQOU-492-29@gated-at.bofh.it> <E1Epjug-0001iA-In@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1Epjug-0001iA-In@be1.lrz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 23-12-05 11:12:38, Bodo Eggert wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> 
> > "With some drawbacks" is the point: It has been determined that the
> > drawbacks are heavy enough that the 8KiB stack option should go.
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

Two newlines in case of 4Kstacks...

								Pavel

-- 
Thanks, Sharp!

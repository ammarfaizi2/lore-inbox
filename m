Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283880AbRLABg7>; Fri, 30 Nov 2001 20:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283878AbRLABgu>; Fri, 30 Nov 2001 20:36:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32012 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283876AbRLABgd>; Fri, 30 Nov 2001 20:36:33 -0500
Message-ID: <3C083404.1050608@zytor.com>
Date: Fri, 30 Nov 2001 17:36:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <Pine.LNX.4.40.0111301738420.1600-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>>
>>This seems to confuddle the idea of colouring the kernel stack.
>>
> 
> It's task_truct colouring not stack, to colour the stack you've to go in
> arch/??/kernel/process.c and jitter the stack pointer.
> The task_struct colouring is done at task_struct creation time :
> 
> +struct task_struct *alloc_task_struct(void)
> +{
> +       unsigned long tskb = __get_free_pages(GFP_KERNEL, 1), tsk;
> +       tsk = tskb | ((tskb >> 13) & 0x00000060) | SMP_CACHE_BYTES;
> +       *(unsigned long *) tskb = tsk;
> +       return (struct task_struct *) tsk;
> +}
> 


I know, but I believe the part of the idea was to color not just the
current, but also the stack.

Your idea would make the obvious way to color the kernel stack -- have the
stacks offset by a non-power-of-two -- no longer work.

	-hpa



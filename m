Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283870AbRLABZT>; Fri, 30 Nov 2001 20:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283872AbRLABZQ>; Fri, 30 Nov 2001 20:25:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8204 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283870AbRLABYr>; Fri, 30 Nov 2001 20:24:47 -0500
Message-ID: <3C083150.3060906@zytor.com>
Date: Fri, 30 Nov 2001 17:24:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <Pine.LNX.4.40.0111301725480.1600-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

> 
> Again this is the  "current"  diff :
> 
>  static inline struct task_struct * get_current(void)
>  {
> -       struct task_struct *current;
> -       __asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
> -       return current;
> +       unsigned long *tskptr;
> +       __asm__("andl %%esp,%0; ":"=r" (tskptr) : "0" (~8191UL));
> +       return (struct task_struct *) *tskptr;
>  }
> 
> that will probably resolve in something like:
> 
> movl %esp, %eax
> andl $-8192, %eax
> movl (%eax), %eax
> 


This seems to confuddle the idea of colouring the kernel stack.

	-hpa



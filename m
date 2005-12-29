Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVL2Eii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVL2Eii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 23:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVL2Eih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 23:38:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13069 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965017AbVL2Eih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 23:38:37 -0500
Date: Thu, 29 Dec 2005 05:38:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229043835.GC4872@stusta.de>
References: <20051228114637.GA3003@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228114637.GA3003@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 12:46:37PM +0100, Ingo Molnar wrote:
> this patchset (for the 2.6.16 tree) consists of two patches:
> 
>   gcc-no-forced-inlining.patch
>   gcc-unit-at-a-time.patch
> 
> the purpose of these patches is to reduce the kernel's .text size, in 
> particular if CONFIG_CC_OPTIMIZE_FOR_SIZE is specified. The effect of 
> the patches on x86 is:
> 
>     text    data     bss     dec     hex filename
>  3286166  869852  387260 4543278  45532e vmlinux-orig
>  3194123  955168  387260 4536551  4538e7 vmlinux-inline
>...

The most interesting question is:
Which object files do these savings come from

We have two cases in the kernel:
- header files where forced inlining is required
- C files where forced inlining is nearly always wrong

The classical example are functions some marked as "inline" when they 
where tiny and had one caller, but now are huge and have many callers.

An interesting number would be the space saving after doing some kind of 
s/inline//g in all .c files.

> unit-at-a-time still increases the kernel stack footprint somewhat (by 
> about 5% in the CC_OPTIMIZE_FOR_SIZE case), but not by the insane degree 
> gcc3 used to, which prompted the original -fno-unit-at-a-time addition.
>...

Please hold off this patch.

I do already plan to look at this after the smoke has cleared after the 
4k stacks issue. I want to avoid two different knobs both with negative 
effects on stack usage (currently CONFIG_4KSTACKS=y, and after your 
patch gcc >= 4.0) giving a low testing coverage of the worst cases.

> 	Ingo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


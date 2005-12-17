Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVLQUhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVLQUhE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVLQUhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:37:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964834AbVLQUhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:37:01 -0500
Date: Sat, 17 Dec 2005 12:36:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.15-rc5-git3] hpet.c causes FC4 GCC 4.0.2 to bomb with
 unrecognizable insn
Message-Id: <20051217123636.cdd53270.akpm@osdl.org>
In-Reply-To: <5a4c581d0512130507n698846ao719c389f3c3ee416@mail.gmail.com>
References: <5a4c581d0512130507n698846ao719c389f3c3ee416@mail.gmail.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
>
>  CC      drivers/char/hpet.o
> drivers/char/hpet.c: In function `hpet_calibrate':
> drivers/char/hpet.c:803: Unrecognizable insn:
> (insn/i 95 270 264 (parallel[
>             (set (reg:SI 0 eax)
>                 (asm_operands ("") ("=a") 0[
>                         (reg:DI 1 edx)
>                     ]
>                     [
>                         (asm_input:DI ("A"))
>                     ]  ("drivers/char/hpet.c") 452))
>             (set (reg:SI 1 edx)
>                 (asm_operands ("") ("=d") 1[
>                         (reg:DI 1 edx)
>                     ]
>                     [
>                         (asm_input:DI ("A"))
>                     ]  ("drivers/char/hpet.c") 452))
>             (clobber (reg:QI 19 dirflag))
>             (clobber (reg:QI 18 fpsr))
>             (clobber (reg:QI 17 flags))
>         ] ) -1 (insn_list 92 (nil))
>     (nil))
> drivers/char/hpet.c:803: confused by earlier errors, bailing out
> make[2]: *** [drivers/char/hpet.o] Error 1
> make[1]: *** [drivers/char] Error 2
> make: *** [drivers] Error 2
> 

Same compiler works OK here, so it's presumably "fixed" by some some good
.config luck.

If we can find a decent workaround in-kernel it's worth putting it in. 
It's quite possible that inlined hpet_time_div() - please try uninlining
it.

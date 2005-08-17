Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVHQIMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVHQIMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 04:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVHQIMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 04:12:09 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:6038 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750975AbVHQIMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 04:12:09 -0400
Date: Wed, 17 Aug 2005 17:07:00 +0900 (JST)
Message-Id: <20050817.170700.34136678.taka@valinux.co.jp>
To: hyoshiok@miraclelinux.com, lkml.hyoshiok@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: math_state_restore() question
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <98df96d305081700581ebdd5ed@mail.gmail.com>
References: <98df96d305081700581ebdd5ed@mail.gmail.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just take a look at __switch_to(), where __unlazy_fpu() is called.

> Hi,
> 
> I have a quick question.
> 
> The math_state_restore() restores the FPU/MMX/XMM states.
> However where do we save the previous task's states if it is necessary?
> 
> asmlinkage void math_state_restore(struct pt_regs regs)
> {
>         struct thread_info *thread = current_thread_info();
>         struct task_struct *tsk = thread->task;
> 
>         clts();         /* Allow maths ops (or we recurse) */
>         if (!tsk_used_math(tsk))
>                 init_fpu(tsk);
>         restore_fpu(tsk);
>         thread->status |= TS_USEDFPU;   /* So we fnsave on switch_to() */
> }
> 
> Thanks in advance,
>   Hiro
> -- 
> Hiro Yoshioka
> mailto:hyoshiok at miraclelinux.com
> -



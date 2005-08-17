Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVHQH6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVHQH6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 03:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVHQH6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 03:58:16 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:48577 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750962AbVHQH6Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 03:58:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K6OuaQ1++cNGtRGsk1iv3EzpvpbP8SfwAzg6W5RpdQyMKAjF6mBOUY5rPIxqJkcN1jke0V3ZXdNFFfDbckUGWK739BmF6DRjPbeNkaPt6Z/yxZOPfLpQKxjM9S2WBIFUPSA5kDIwhgu3LHAwept8+EfLlBRd6DsBCzVlEIfRQkA=
Message-ID: <98df96d305081700581ebdd5ed@mail.gmail.com>
Date: Wed, 17 Aug 2005 16:58:13 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: linux-kernel@vger.kernel.org
Subject: math_state_restore() question
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a quick question.

The math_state_restore() restores the FPU/MMX/XMM states.
However where do we save the previous task's states if it is necessary?

asmlinkage void math_state_restore(struct pt_regs regs)
{
        struct thread_info *thread = current_thread_info();
        struct task_struct *tsk = thread->task;

        clts();         /* Allow maths ops (or we recurse) */
        if (!tsk_used_math(tsk))
                init_fpu(tsk);
        restore_fpu(tsk);
        thread->status |= TS_USEDFPU;   /* So we fnsave on switch_to() */
}

Thanks in advance,
  Hiro
-- 
Hiro Yoshioka
mailto:hyoshiok at miraclelinux.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSGFSNf>; Sat, 6 Jul 2002 14:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSGFSNf>; Sat, 6 Jul 2002 14:13:35 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:55825 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S315721AbSGFSNe>;
	Sat, 6 Jul 2002 14:13:34 -0400
Message-ID: <3D27347C.29DC9014@tv-sign.ru>
Date: Sat, 06 Jul 2002 22:18:36 +0400
From: oleg@tv-sign.ru
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mingo@elte.hu
Subject: Re: [patch] sched-2.5.24-D3, batch/idle priority scheduling, SCHED_BATCH
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I beleive this patch against entry.S should be sufficient:

--- entry.S~    Sat Jul  6 21:01:16 2002
+++ entry.S     Sat Jul  6 21:06:14 2002
@@ -255,7 +255,7 @@
        testb $_TIF_NEED_RESCHED, %cl
        jz work_notifysig
 work_resched:
-       call schedule
+       call schedule_userspace
        cli                             # make sure we don't miss an
interrupt
                                        # setting need_resched or
sigpending
                                        # between sampling and the iret

Both calls to schedule() at resume_kernel: and work_pending:
have clear kernel/user return path.

And users of __KERNEL_SYSCALLS__ and kernel_thread() should not
have policy == SCHED_BATCH.

No?

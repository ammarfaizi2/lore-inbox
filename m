Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262888AbSJLLYW>; Sat, 12 Oct 2002 07:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262889AbSJLLYW>; Sat, 12 Oct 2002 07:24:22 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:18450 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S262888AbSJLLYV>;
	Sat, 12 Oct 2002 07:24:21 -0400
Message-ID: <3DA80935.9DF08D08@tv-sign.ru>
Date: Sat, 12 Oct 2002 15:36:21 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: BUG: [RESEND] de_thread()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Thu, 10 Oct 2002 Oleg Nesterov wrote:
> 
> Suppose process P in thread group was cloned _without_
> CLONE_DETACHED flag. Then another thread, group_leader
> for simplicity, does exec and calls de_thread(). It kills
> P via _broadcast_thread_group(). While doing do_exit(),
> P skips release_task(), because its exit_signal != -1,
> and becomes TASK_ZOMBIE.
> 
> Then leader calls schedule() with TASK_UNINTERRUPTIBLE
> in while(oldsig->count > 1) {...} and sleeps forever,
> because nobody can do wake_up_process(sig->group_exit_task).

Oleg.

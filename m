Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbSJJR3T>; Thu, 10 Oct 2002 13:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbSJJR3T>; Thu, 10 Oct 2002 13:29:19 -0400
Received: from www.sgg.ru ([217.23.135.2]:39432 "EHLO mail.sgg.ru")
	by vger.kernel.org with ESMTP id <S261659AbSJJR3T>;
	Thu, 10 Oct 2002 13:29:19 -0400
Message-ID: <3DA5BBB2.67435F2D@tv-sign.ru>
Date: Thu, 10 Oct 2002 21:41:06 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: BUG: de_thread()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Suppose process P in thread group was cloned _without_
CLONE_DETACHED flag. Then another thread, group_leader
for simplicity, does exec and calls de_thread(). It kills
P via _broadcast_thread_group(). While doing do_exit(),
P skips release_task(), because its exit_signal != -1,
and becomes TASK_ZOMBIE.

Then leader calls schedule() with TASK_UNINTERRUPTIBLE
in while(oldsig->count > 1) {...} and sleeps forever,
because nobody can do wake_up_process(sig->group_exit_task).

Sorry if i missed something, i have no machine to test
development kernel, so i can only speculate looking at
source.

Oleg.

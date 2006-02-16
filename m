Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWBPT6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWBPT6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWBPT6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:58:49 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:59115 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964771AbWBPT6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:58:48 -0500
Message-ID: <43F4EBAF.D9BFEA13@tv-sign.ru>
Date: Fri, 17 Feb 2006 00:16:31 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] fix kill_proc_info() vs CLONE_THREAD race
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com> <43F3352C.E2D8F998@tv-sign.ru> <43F37D54.4D0AAEFD@tv-sign.ru> <20060216191932.GE1296@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> > After that we don't need tasklist_lock to iterate over the thread
> > list, and we can simplify things, see for example do_sigaction()
> > or sys_times().
> 
> The above proposal would require that we hold siglock during the
> traversal, correct?

Yes, of course.

>                     Is that reasonable for non-signal-related traversals?
> Or were you thinking of making this change only for signal code?

Yes, I think it may be useful for non-signal-related traversals.

Currently we need tasklist_lock in order to use next_thread().
I beleive, we can migrate to rcu_read_lock+spinlock(sighand)
in most cases.

Well, next_thread() itself is safe already, but it can return
already zapped threads.

Oleg.

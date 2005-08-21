Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVHUKsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVHUKsb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 06:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVHUKsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 06:48:31 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:24448 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750947AbVHUKsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 06:48:30 -0400
Message-ID: <43085E97.4EC3908B@tv-sign.ru>
Date: Sun, 21 Aug 2005 14:59:35 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
References: <20050818060126.GA13152@elte.hu>
		 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
		 <43076138.C37ED380@tv-sign.ru> <1124617458.23647.643.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> 
>  arm timer
>  exit
>  timer event

I think there is another bug here.

CPU_0					CPU_1

release_task:				posix_timer_fn:
	write_lock(tasklist);			lock(timer->it_lock);

	exit_timers:				send_sigxxx();
		lock(timer->it_lock)			read_lock(tasklist);
				
Deadlock.

Dear cc-list, what do you think?

Oleg.

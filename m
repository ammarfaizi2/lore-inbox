Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264445AbSIQSXB>; Tue, 17 Sep 2002 14:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264452AbSIQSXB>; Tue, 17 Sep 2002 14:23:01 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:23817
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264445AbSIQSXB>; Tue, 17 Sep 2002 14:23:01 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209171153050.7096-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209171153050.7096-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 14:27:52 -0400
Message-Id: <1032287273.4593.31.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 05:57, Ingo Molnar wrote:

> We *must* use the schedule() check to debug preemption bugs, or we wont
> have usable preemption in 2.6, i dont really understand why your are not
> happy that we have such a great tool. In fact we should also add other
> debugging bits, like 'check for !0 preemption count in smp_processor_id()'
> , and the underflow checks that caught the IDE bug. These are all bits
> that help the elimination of preemption bugs which are also often SMP
> bugs, on plain UP boxes.

Hm, sorry if I sound like I do not want something "so great".  I do.  I
just do not ever want to compromise the existing code... I would much
prefer to say "wow we cannot do this cleanly now, let's wait until we
figure out a clean way".

Anyhow, one of us is confused.  How can this in_atomic() test _ever_
catch a preemption bug?  We cannot enter the scheduler off kernel
preemption unless preempt_count==0.  This is a test to catch bugs in
other parts of the kernel, e.g. where code explicitly calls schedule()
while holding a lock.

	Robert Love


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbSI1QhB>; Sat, 28 Sep 2002 12:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262200AbSI1QhB>; Sat, 28 Sep 2002 12:37:01 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:61635 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262168AbSI1Qg7>;
	Sat, 28 Sep 2002 12:36:59 -0400
Date: Sat, 28 Sep 2002 09:42:20 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200209281642.g8SGgKMA007827@napali.hpl.hp.com>
To: mingo@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: show_stack()/show_trace() prototypes
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, the ksymoops patch adds these to linux/sched.h:

extern void show_trace(unsigned long *stack);
extern void show_stack(unsigned long *stack);

This is not good.  In general, it is not possible to do a reliable
backtrace with just a stack pointer as a starting point (it is
necessary to have access to the entire "preserved" machine state
instead).  I'd suggest to either change the argument to a task_struct
pointer (and update half a dozen platforms or so accordingly), or to
leave the declarations platform-specific like they were before.

Thanks,

	--david

PS: force_sig_info() still drops the siginfo pointer passed to it.
    Will you fix this soon as promised?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264590AbSIQUBs>; Tue, 17 Sep 2002 16:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264591AbSIQUBs>; Tue, 17 Sep 2002 16:01:48 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:54799
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264590AbSIQUBr>; Tue, 17 Sep 2002 16:01:47 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Steven Cole <elenstev@mesatop.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1032292468.11907.44.camel@spc9.esa.lanl.gov>
References: <Pine.LNX.4.44.0209172055550.13829-100000@localhost.localdomain> 
	<1032290611.4592.206.camel@phantasy> 
	<1032292468.11907.44.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 16:06:34 -0400
Message-Id: <1032293199.4588.235.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 15:54, Steven Cole wrote:

Thank you for the testing, Steven.

> Running dbench 3 resulted in the dbench clients hanging and being
> unkillable with kill -9 in the D state.

Hrm, I cannot reproduce this.  I just successfully completed a `dbench
16'.  Can you find where they are hanging?  You can get a trace via
sysrq.  You can also see where they are in the kernel via the wchan
field of ps: "ps -ewo user,pid,priority,%cpu,stat,command,wchan" is a
favorite of mine.

Sure it does not happen with a stock kernel (no preempt)?

What if you replace the printk() and dump_stack() in schedule() with a
no-op (but not something that will optimize away the conditional, i.e.
try a cpu_relax()).

Oh, is the previous patch fully backed out?  None of that do_exit muck
anymore, right?

> Test box is 2-way pIII, kernel SMP.

I too am SMP with kernel preemption, dual Athlon MP.

Regards,

	Robert Love


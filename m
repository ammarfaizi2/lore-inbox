Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284728AbSAGSPS>; Mon, 7 Jan 2002 13:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284755AbSAGSPJ>; Mon, 7 Jan 2002 13:15:09 -0500
Received: from zero.tech9.net ([209.61.188.187]:33541 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284728AbSAGSO7>;
	Mon, 7 Jan 2002 13:14:59 -0500
Subject: [PATCH] preemptible kernel patch for 2.4 and 2.5
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 07 Jan 2002 13:16:58 -0500
Message-Id: <1010427419.1519.24.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Announcing the next revision of the fully preemptible linux kernel
patch, available for 2.4 and 2.5 trees now at:

ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel

and your favorite mirrors.  Diffs for 2.4.18-pre1 and 2.5.2-pre9 are
available along with previous patches.

This patch, which we are all familiar with by now, makes the kernel
preemptible.  This means that a higher priority process can preempt a
lower priority process, even if it is running inside the kernel. 
Reentrancy is protected by SMP lock points.  Despite the warnings to the
contrary about throughput, benchmarking actually shows a marked
increase, probably due to faster scheduling of woken I/O tasks. 
Complexity added is minimal.

ARM, i386, and SH are supported.  UP and SMP is supported.  There are no
outstanding bugs.

Perhaps a feature that is often overlooked is the growth for performance
gains in the future.  As we continue to make locks finer grained (and,
especially, remove the BKL) performance will increase.  Thus we now have
an architecture where by we can continue to improve performance.

Changes:

- (2.5 only) include linux/sched.h in fs/char_dev.c

- SH arch: fix certain code path not hitting preempt_enable (Jeremy
Siegel)

- stop locking task to CPU across preemptions.
 
- back out console race fix as it was merged with mainline

Todo:

- Port the scheduling details to Ingo's O(1) scheduler

Enjoy,

	Robert Love


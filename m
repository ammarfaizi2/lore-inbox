Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267301AbSLKTjB>; Wed, 11 Dec 2002 14:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267302AbSLKTjB>; Wed, 11 Dec 2002 14:39:01 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:44043
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267301AbSLKTi7>; Wed, 11 Dec 2002 14:38:59 -0500
Subject: Re: 2.5 Changes doc update.
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021211172559.GA8613@suse.de>
References: <20021211172559.GA8613@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1039636010.833.98.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 14:46:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 12:25, Dave Jones wrote:

> Process scheduler improvements.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - Another much talked about feature. Ingo Molnar reworked the process
>   scheduler to use an O(1) algorithm.  In operation, you should notice
>   no changes with low loads, and increased scalability with large numbers
>   of processes, especially on large SMP systems.
> - Robert Love wrote various utilities for changing behaviour of the
>   scheduler (binding processes to CPUs etc). You can find these tools at
>   http://tech9.net/rml/schedutils
> - Regressions to mingo@redhat.com and rml@tech9.net

Two notes here:

- The behavior of sched_yield() changed a lot.  A task that uses
  this system call should now expect to sleep for possibly a very
  long time.  Tasks that do not really desire to give up the
  processor for a while should probably not make heavy use of this
  function.  Unfortunately, some GUI programs (like Open Office)
  do make excessive use of this call and under load their
  performance is poor.  It seems this new 2.5 behavior is optimal
  but some user-space applications may need fixing.

- The above applies to use of yield() in the kernel, too.

- 2.5 adds system calls for manipulating a task's processor
  affinity: sched_getaffinity() and sched_setaffinity()

	Robert Love


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbTIIXeZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbTIIXeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:34:25 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:43156
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S265063AbTIIXeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:34:24 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <tCPY.4xU.1@gated-at.bofh.it> <tDsR.5tY.31@gated-at.bofh.it> <tZ0f.49P.5@gated-at.bofh.it> <tZjz.4Bn.7@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 09 Sep 2003 16:24:24 -0700
In-Reply-To: <tZjz.4Bn.7@gated-at.bofh.it>
Message-ID: <ug8yoxsfyv.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 10 Sep 2003 00:40:09 +0200, Andrew Morton <akpm@osdl.org> said:

  Andrew> Steven Pratt <slpratt@austin.ibm.com> wrote:

  >> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-CAN_MIGRATE_TASK-fix.patch
  >> >
  >> This patch improves specjjb over test5 and has no real effect on
  >> any of kernbench, volanomark or specsdet.

  Andrew> Fine, it's a good fix.

Is it that simple?  My reading is that it will do very bad things,
e.g., to pipe roundtrip latency on SMP machines.  Something that the
O(1) scheduler has handled nicely so far.

My preference would have been to break affinity only in the presence
of a _persistent_ load imbalance of >> 1.  For example, it's perfectly
OK and indeed encouraged to run N tasks on one and the same CPU, if
those tasks are (almost) never runnable at the same time.

	--david
--
Interested in learning more about IA-64 Linux?  Try http://www.lia64.org/book/

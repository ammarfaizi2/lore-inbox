Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293059AbSCEAXZ>; Mon, 4 Mar 2002 19:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293051AbSCEAXP>; Mon, 4 Mar 2002 19:23:15 -0500
Received: from zero.tech9.net ([209.61.188.187]:38674 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293049AbSCEAXD>;
	Mon, 4 Mar 2002 19:23:03 -0500
Subject: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 19:23:10 -0500
Message-Id: <1015287791.882.25.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same schedule_tail bug affecting 2.5 affects 2.4 with O(1).  I.e.,
2.4.19-pre2-ac2.

In recent O(1) scheduler releases, an optimization was made that removed
schedule_tail from UP kernels.  This causes the initial preempt_count of
a new task, which starts at 1, to never decrement to zero and thus never
become preemptible.  CONFIG_PREEMPT requires schedule_tail, too.

Users of 2.4+O(1)+preempt (i.e. -ac) should use this patch:

	http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-pre2-ac2-2.patch

instead.  Thanks to everyone who pointed out the lousy performance.  Enjoy,

	Robert Love


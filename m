Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269203AbUHZRNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269203AbUHZRNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269241AbUHZRNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:13:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:39818 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S269203AbUHZRMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:12:17 -0400
Subject: kstopmachine thread panic in do_exit (2.6.9-rc1-bk1)
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain
Message-Id: <1093540274.4249.48.camel@biclops.private.network>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 12:11:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

Something crept in between 2.6.9-rc1 and 2.6.9-rc1-bk1 which reliably
trips the "Aiee, killing interrupt handler!" panic in do_exit when
offlining a cpu.  I inserted a BUG() before the panic call to see what's
causing it, looks like one of the kstopmachine threads spawned by
stop_machine.  I can't do a comparison with current -mm because
offlining a cpu doesn't even get that far there.

Backing out the most recent sched.c change ("sched: smt fixes" as of
this writing) fixes it.  Turning off preempt seems to work around it. 
The bug is still present in -bk2.  I'm seeing this on a 4-way ppc64
machine.

Nathan



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbTJXWHf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbTJXWHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:07:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:49130 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262678AbTJXWHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:07:33 -0400
Date: Fri, 24 Oct 2003 15:08:21 -0700
From: Dave Olien <dmo@osdl.org>
To: kernel@kolivas.org, piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] linux 2.6.0-test8 reaim tests fail to exit
Message-ID: <20031024220821.GA15231@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've observed in the last two days, linux 2.6.0-test8 and I think
linux 2.6.0-test8-mm1.  The reaim test workload fails to exit.
All of the reaim tasks are blocked in sys_wait4().  But non of
them seem to have any obvious child processes.

There are also lots of sync() processes.  Many of those seem to be
blocked somewhere scheduling IO.  These kernels were all with the
as-isoched IO scheduler.  I may retry with deadline scheduler, just
to rule out IO scheduler. Is there any link between the sync()
processes and the reaim waiting for children?

Could there be a problem with IO not completing for the sync()
tasks that causes the reaim tasks to not complete?

Attached is a console output from a system hung in this state.
Included (towards the bottom) is a sysrq t output.

I'm hoping to investigate this more closely over the week end.

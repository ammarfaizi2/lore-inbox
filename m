Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTIKXcx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 19:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbTIKXcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 19:32:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:47027 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261631AbTIKXc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 19:32:27 -0400
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
From: Craig Thomas <craiger@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: piggin@cyberone.com.au, kernel@colivas.org, akpm@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1063323132.3255.12.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Sep 2003 16:32:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the request of Cliff White, I have run DBT-2 tests agains patches
from Nick Piggin.  Below are some test results running an OLTP
transaction database workload with two of Nick Piggin's patches:

PLM ID 2117 - sched_rollup (2.6.0-test5-sched-rollup)
PLM ID 2119 - sched_rollup_nopolicy (2.6.0-tst5-nick.v14)

I believe, Cliff has run or is running tests on these patches
using the reaim-7 tests.

These were run on OSDL's STP framework and the kernel patches are
archived in PLM.  The database tests were configured to run where
the database was entirely cached in memory and to run where
the database was larger than memory, forcing I/O activit.


Cached Runs:
------------
These tests run database transactions of an OLTP variety.  The
test is set up so that the entire database resides in memory
and thus avoids I/O where possible.  This test is useful for
determining the overall capababilities of the CPU and memory
features.

STP4-000

   Kernel                NOTPM         test id
-----------------------  -----  ---------------------------------
linux-2.6.0-test5         2914  http://khack.osdl.org/stp/279496/
linux-2.6.0-test3         2642  http://khack.osdl.org/stp/279430/
2.6.0-test5-sched-rollup  2822  http://khack.osdl.org/stp/279670/
2.6.0-test5-nick.v14      2839  http://khack.osdl.org/stp/279686/

These results show that Nick's patches are not quite up to the
overall throughput capability of the standard Linus kernel.
However, they are better than the last -mm kernel I was able to
get runs on (2.6.0-test3-mm1), so the changes are heading in the
right direction.  Unfortunately, I could not get more runs for
this report, but I could perform more in order to get an average,
if you'd like.


Non Cached (disk intensive) runs:

---------------------------------
These tests run a larger version of the same database, but because
of its larger size and queries over a larger table, I/O is used
heavily.

These runs were taken on two different machines.  One system is
slightly faster all around than the other.  Thus, the runs are broken
down by system, rather than lumped all together.

STP4-001

   Kernel                NOTPM         test id
-----------------------  -----   ---------------------------------
linux-2.6.0-test5         1185   http://khack.osdl.org/stp/279495/
2.6.0-test5-nick.v14      1187   http://khack.osdl.org/stp/279693/
2.6.0-test5-nick.v14      1226   http://khack.osdl.org/stp/279689/
2.6.0-test5-sched-rollup  1214   http://khack.osdl.org/stp/279691/


stp4-002

   Kernel                NOTPM         test id
-----------------------  -----  --------------------------------
linux-2.6.0-test5         1317  http://khack.osdl.org/stp/279500/
linux-2.6.0-test5         1336  http://khack.osdl.org/stp/279494/
2.6.0-test5-nick.v14      1348  http://khack.osdl.org/stp/279692/
2.6.0-test5-sched-rollup  1329  http://khack.osdl.org/stp/279688/
2.6.0-test5-sched-rollup  1333  http://khack.osdl.org/stp/279690/


It appears that for non-cached runs, where I/O us used, the
numbers start looking the same as the Linus kernel.  This implies
that the patches from Andrew and Nick are not intrusive.  I don't
beliefve the difference in the numbers are significant in these
cases.

So, overall, the scheduler changes of each kernel don't seem to
have an impact on OLTP transaction database processes where I/O
is involved.

The test id URL, point to information about the system resources
(vmstat, sar, etc.) if anybody really wants to dig down into the
details.

-- 
Craig Thomas
craiger@osdl.org


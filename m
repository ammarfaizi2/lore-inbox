Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbTFLTDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbTFLTDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:03:54 -0400
Received: from mta4.adelphia.net ([64.8.50.184]:4805 "EHLO mta4.adelphia.net")
	by vger.kernel.org with ESMTP id S264960AbTFLTDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:03:51 -0400
Subject: [RFC] Multiprocessor Control Interfaces (v2.0)
From: Jason Baietto <jason@baietto.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1055445453.6598.42.camel@snowpea>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 15:17:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Version 2.0 of Concurrent's multiprocessor control library (mpadvise)
and user-level tool (run) are now available.  A source tarball, README
and ChangeLog can be found here:

   http://www.ccur.com/realtime/oss

These are GPL'd clean-room implementations of similar tools that
have been available in our proprietary *nix for quite some time,
and so the interfaces have a fair amount of mileage under their
belts.  Note that the scope is somewhat wider than just MP.

Briefly, it works like this:

   # run -b 0 foobar
   (runs foobar biased to cpu 0)

   # run --negate --bias 0 foobar
   (runs foobar anywhere but cpu 0)

but it can combine MP and scheduler parameters easily too:

   # run --bias 0-2,5 --policy rr --priority 50 autopilot

Here's the full help output.  See the man pages in the tarball
for details on using the mpadvise(3) library service.

# run --help
Usage: run [OPTIONS] { COMMAND [ARGS] | PROCESS_SPECIFIER }
Set scheduling parameters and CPU bias for a new process or a list
of existing processes.

OPTIONS can be one or more of the following options:

   -b, --bias=LIST        Set the CPU bias to the LIST of CPUs;
                          CPUs are numbered starting from 0
   -s, --policy=POLICY    Set the scheduling policy to POLICY
                          (SCHED_OTHER, SCHED_RR or SCHED_FIFO)
   -P, --priority=LEVEL   Set the scheduling priority to LEVEL;
                          SCHED_FIFO and SCHED_RR range: 1 to 99
                          SCHED_OTHER: only priority 0 is valid
   -q, --quantum=QUANTUM  Set the SCHED_RR quantum to QUANTUM;
                          use --quantum=list for valid settings
   -N, --negate           Negate the CPU bias list; all CPUs
                          except those listed will be selected
   -f, --fork             Fork COMMAND and return immediately
   -c, --copies=COUNT     Run COUNT identical copies of COMMAND
   -i, --info             Output process environment information
   -V, --version          Output version information and exit
   -v, --verbose          Output information before each action
   -h, --help             Display this help and exit

PROCESS_SPECIFIER is exactly one of the following options:

   -p, --pid=LIST         Specify LIST of existing PIDs to modify
   -g, --group=LIST       Specify LIST of process groups to modify; all
                          existing processes in the groups will be modified
   -u, --user=LIST        Specify LIST of users to modify; all existing
                          processes owned by the users will be modified
   -n, --name=LIST        Specify LIST of existing process names to modify

Multiple comma separated values can be specified for all LISTs and ranges
are allowed where appropriate (e.g. "run -b 0,2-5 autopilot").

See the run(1) man page for more information.

Take care,
Jason
--
Jason Baietto
jason.baietto@ccur.com



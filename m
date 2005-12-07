Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbVLGWIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVLGWIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbVLGWIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:08:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:53391 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030385AbVLGWIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:08:15 -0500
Message-ID: <43975D45.3080801@watson.ibm.com>
Date: Wed, 07 Dec 2005 22:08:05 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
Subject: [RFC][Patch 0/5] Per-task delay accounting 
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add accounting for the delays seen by a task in
a) waiting for a CPU (while being runnable)
b) completion of synchronous block I/O initiated by the task
c) swapping in pages (i.e. capacity misses).

Such delays provide feedback for a task's cpu priority, io priority and
rss limit values. Long delays, especially relative to other tasks, can be
a trigger for changing a task's cpu/io priorities and modifying its rss usage
(either directly through sys_getprlimit() that was proposed earlier on lkml or
by throttling cpu consumption or process calling sys_setrlimit etc.)

There are quite a few differences from the earlier posting of these patches
(http://www.uwsg.indiana.edu/hypermail/linux/kernel/0511.1/2275.html):

- block I/O is (hopefully) being accounted properly now  instead of just counting the
time spent in io_schedule() as done earlier.

- instead of accounting for time spent in all page faults, only swapping in of pages
is being counted since thats the only part that one can really control (capacity misses
vs. compulsory misses)

- a /proc interface is being used instead of connector-based interface. Andrew Morton
suggested a generic connector-based interface useful for future usage of
connectors fo stats. This revised connector-based interface will be posted separately
since its useful for efficient delivery of any per-task statistics, not just the ones
being introduced by these patches.

- the timestamping code has been made generic (following the suggestions to Matt Helsley's
patches to add timestamps to process events connectors)


More comments in individual patches.

Series

nstimestamp-diff.patch
delayacct-init.patch
delayacct-blkio.patch
delayacct-swapin.patch
delayacct-procfs.patch


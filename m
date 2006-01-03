Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWACXRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWACXRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWACXRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:17:04 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:27308 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964802AbWACXRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:17:00 -0500
Message-ID: <43BB05D8.6070101@watson.ibm.com>
Date: Tue, 03 Jan 2006 23:16:40 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
CC: elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: [Patch 0/6] Per-task delay accounting
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Could you please consider these patches for inclusion in -mm ?
The comments from earlier postings of these patches have been addressed,
including the one you made about making the connector interface generic
(more about that in the connector patch).

Thanks,
Shailabh


The following patches add accounting for the delays seen by tasks in
a) waiting for a CPU (while being runnable)
b) completion of synchronous block I/O initiated by the task
c) swapping in pages (i.e. capacity misses).

Such delays provide feedback for a task's cpu priority, io priority and
rss limit values. Long delays, especially relative to other tasks, can
be a trigger for changing a task's cpu/io priorities and modifying its
rss usage (either directly through sys_getprlimit() that was proposed
earlier on lkml or by throttling cpu consumption or process calling
sys_setrlimit etc.)

The major change since the previous posting of these patches
(http://www.ussg.iu.edu/hypermail/linux/kernel/0512.0/2152.html)
is the resurrection of the connector interface (in addition to /proc)
and, as part of the same patch, the ability to get stats per-tgid in
addition to per-pid.

More comments in individual patches.

Series

nstimestamp-diff.patch
delayacct-init.patch
delayacct-blkio.patch
delayacct-swapin.patch
delayacct-procfs.patch
delayacct-connector.patch




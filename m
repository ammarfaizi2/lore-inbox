Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWB0H4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWB0H4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWB0H4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:56:40 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:42460 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751648AbWB0H4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:56:39 -0500
Subject: [Patch 0/7] Per-task delay accounting
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: lse-tech <lse-tech@lists.sourceforge.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1141026996.5785.38.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 27 Feb 2006 02:56:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

The major changes since the previous posting of these patches are

- use of the new generic netlink interface (NETLINK_GENERIC family)
with provision for reuse by other (non-delay accounting) kernel
components
- sysctl option for turning delay accounting collection on/off
dynamically
- similar sysctl option for schedstats. Delay accounting leverages
schedstats code for cpu delays.
- dynamic allocation of delay accounting structures

More comments in individual patches. Please give feedback.

--Shailabh

Series
nstimestamp-diff.patch
schedstats-sysctl.patch
delayacct-setup.patch
delayacct-sysctl.patch
delayacct-blkio.patch
delayacct-swapin.patch
delayacct-genetlink.patch



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWEZEU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWEZEU0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWEZEUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:20:25 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:15770 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030335AbWEZEUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:20:23 -0400
From: Peter Williams <pwil3058@bigpond.net.au>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Date: Fri, 26 May 2006 14:20:21 +1000
Message-Id: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
Subject: [RFC 0/5] sched: Add CPU rate caps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches implement CPU usage rate limits for tasks.

Although the rlimit mechanism already has a CPU usage limit (RLIMIT_CPU)
it is a total usage limit and therefore (to my mind) not very useful.
These patches provide an alternative whereby the (recent) average CPU
usage rate of a task can be limited to a (per task) specified proportion
of a single CPU's capacity.  The limits are specified in parts per
thousand and come in two varieties -- hard and soft.  The difference
between the two is that the system tries to enforce hard caps regardless
of the other demand for CPU resources but allows soft caps to be
exceeded if there are spare CPU resources available.  By default, tasks
will have both caps set to 1000 (i.e. no limit) but newly forked tasks
will inherit any caps that have been imposed on their parent from the
parent.  The mimimim soft cap allowed is 0 (which effectively puts the
task in the background) and the minimim hard cap allowed is 1.

Care has been taken to minimize the overhead inflicted on tasks that
have no caps and my tests using kernbench indicate that it is hidden in
the noise.

Note:

The first patch in this series fixes some problems with priority
inheritance that are present in 2.6.17-rc4-mm3 but will be fixed in
the next -mm kernel.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce

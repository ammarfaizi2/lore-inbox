Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946130AbWJ0DS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946130AbWJ0DS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 23:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161484AbWJ0DS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 23:18:26 -0400
Received: from pat.uio.no ([129.240.10.4]:34256 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161483AbWJ0DSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 23:18:25 -0400
Date: Fri, 27 Oct 2006 05:18:17 +0200 (CEST)
From: Martin Tostrup Setek <martitse@student.matnat.uio.no>
To: nagar@watson.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH: 2.6.18.1] delayacct: cpu_count in taskstats updated correctly
Message-ID: <Pine.LNX.4.63.0610270440500.21448@honbori.ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.401, required 12,
	autolearn=disabled, AWL -0.40, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from: Martin T. Setek <martitse@ifi.uio.no>

cpu_count in struct taskstats should be the same as the corresponding 
(third) value found in /proc/<pid>/schedstat
Signed-off-by: <martitse@ifi.uio.no>
---
Index: linux-2.6.18.1/kernel/delayacct.c
===================================================================
--- linux-2.6.18.1.orig/kernel/delayacct.c
+++ linux-2.6.18.1/kernel/delayacct.c
@@ -124,7 +124,7 @@ int __delayacct_add_tsk(struct taskstats
  	t2 = tsk->sched_info.run_delay;
  	t3 = tsk->sched_info.cpu_time;

-	d->cpu_count += t1;
+	d->cpu_count = t1;

  	jiffies_to_timespec(t2, &ts);
  	tmp = (s64)d->cpu_delay_total + timespec_to_ns(&ts);

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUDTHFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUDTHFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 03:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbUDTHFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 03:05:52 -0400
Received: from tumsa.unibanka.lv ([193.178.151.91]:10121 "EHLO as.unibanka.lv")
	by vger.kernel.org with ESMTP id S262194AbUDTHF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 03:05:29 -0400
From: Aivils <aivils@unibanka.lv>
Reply-To: aivils@unibanka.lv
Organization: Unibanka
To: linux-kernel@vger.kernel.org
Subject: kernel/softirq.c issues under 2.6.5
Date: Tue, 20 Apr 2004 10:58:12 +0300
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404201058.12830.aivils@unibanka.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

	My 2.6.5 will not start until i applay patch bellow:
--- linux-2.6.5/kernel/softirq.c        2004-04-04 06:36:47.000000000 +0300
+++ linux-2.6.5/kernel/softirq.chg.c    2004-04-20 10:48:28.000000000 +0300
@@ -409,8 +409,8 @@ static int __devinit cpu_callback(struct

        switch (action) {
        case CPU_UP_PREPARE:
-               BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
-               BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
+               per_cpu(tasklet_vec, cpu).list = NULL;
+               per_cpu(tasklet_hi_vec, cpu).list = NULL;
                p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
                if (IS_ERR(p)) {
                        printk("ksoftirqd for %i failed\n", hotcpu);

What mean that? Mr. akpm will check out how good is our c compilers?

Aivils Stoss

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbUKEMCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbUKEMCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbUKEMCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:02:11 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:63678 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262654AbUKEMCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:02:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=bLjjXl6bQKpfChhdSHh2MQ9v+F50d5UElnIHgvhYuFM4Gve9F1YVf6coq30ZemW1KD1NsSeMcdayhDNXiANNOCCthhRFsRIZhJA5uAk2H1y6fVQJM5SyxLRvOM69Neu6tMC9qhu797BbV+geApK1kkz3SVL3Z0OcFnGkp/093N8=
Message-ID: <aad1205e04110504023d53ce65@mail.gmail.com>
Date: Fri, 5 Nov 2004 20:02:00 +0800
From: andyliu <liudeyan@gmail.com>
Reply-To: andyliu <liudeyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]add an ifdef in sched.c
Cc: mingo@elte.hu, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I have found that in sched.c. the macro for_each_domain only useful
for the config
that has CONFIG_SMP defined. so i add an ifdef in sched.c.

below is the patch

--- linux-2.6.10-rc1/kernel/sched.c     2004-10-23 05:40:05.000000000 +0800
+++ linux-2.6.10-rc1-new/kernel/sched.c 2004-11-04 16:34:55.000000000 +0800
@@ -281,8 +281,10 @@

 static DEFINE_PER_CPU(struct runqueue, runqueues);

-#define for_each_domain(cpu, domain) \
+#ifdef CONFIG_SMP
+# define for_each_domain(cpu, domain) \
        for (domain = cpu_rq(cpu)->sd; domain; domain = domain->parent)
+#endif

 #define cpu_rq(cpu)            (&per_cpu(runqueues, (cpu)))
 #define this_rq()              (&__get_cpu_var(runqueues))




thanks for reading.
-- 
Yours andyliu

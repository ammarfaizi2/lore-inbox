Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUEZXCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUEZXCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 19:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUEZXCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 19:02:23 -0400
Received: from mail.tpgi.com.au ([203.12.160.59]:36564 "EHLO mail3.tpgi.com.au")
	by vger.kernel.org with ESMTP id S261156AbUEZXCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 19:02:21 -0400
Message-ID: <40B520A2.2060508@linuxmail.org>
Date: Thu, 27 May 2004 08:56:34 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] SMP support for drain local pages v2.
References: <40B473F7.4000100@linuxmail.org> <20040526223255.GB15278@redhat.com>
In-Reply-To: <20040526223255.GB15278@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dave for educating the ignorant :>.

Is this better?

--- 2.6.6-current-bk/mm/page_alloc.c    2004-05-26 19:47:15.000000000 +1000
+++ smp-drain-local-pages/mm/page_alloc.c       2004-05-27 08:50:36.000000000 +1000
@@ -459,6 +459,20 @@
         __drain_pages(smp_processor_id());
         local_irq_restore(flags);
  }
+
+/*
+ * Spill per-cpu pages on all CPUs back into the buddy allocator.
+ * The first function is just to avoid a compiler warning.
+ */
+static void __smp_drain_local_pages(void * data)
+{
+       drain_local_pages();
+}
+
+void smp_drain_local_pages(void)
+{
+       on_each_cpu(__smp_drain_local_pages, NULL, 0, 1);
+}
  #endif /* CONFIG_PM */

  static void zone_statistics(struct zonelist *zonelist, struct zone *z)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbVLKXYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVLKXYj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 18:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVLKXYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 18:24:39 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:60553 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750907AbVLKXYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 18:24:38 -0500
Date: Sun, 11 Dec 2005 15:24:29 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Dave Jones <davej@redhat.com>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Andi Kleen <ak@suse.de>, Raj Ashok <ashok.raj@intel.com>,
       Paul Jackson <pj@sgi.com>
Message-Id: <20051211232428.18286.40968.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH] alpha build pm_power_off hack
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This follows up Eric W. Biederman's patch of Dec 8, 2005:
  [PATCH] Don't attempt to power off if power off is not implemented.

To avoid having problems with one arch break the crosstool
builds which developers for other arch's do to ensure they
haven't added an arch-specific build bug, add a NULL
pm_power_off() function pointer definition to the alpha build.

Without this change, an alpha build fails in the final link
stage, for the missing 'pm_power_off' symbol that is used
in kernel/sys.c

If the alpha developers don't like the behaviour of '/sbin/halt'
on their kernel, I will leave that to them to figure out.

Signed-off-by: Paul Jackson

---

 arch/alpha/kernel/process.c |    5 +++++
 1 files changed, 5 insertions(+)

--- 2.6.15-rc5-mm2.orig/arch/alpha/kernel/process.c	2005-12-11 15:07:52.000000000 -0800
+++ 2.6.15-rc5-mm2/arch/alpha/kernel/process.c	2005-12-11 15:09:33.000000000 -0800
@@ -43,6 +43,11 @@
 #include "proto.h"
 #include "pci_impl.h"
 
+/*
+ * Power off function, if any
+ */
+void (*pm_power_off)(void);
+
 void
 cpu_idle(void)
 {

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401

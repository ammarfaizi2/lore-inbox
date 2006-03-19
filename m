Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWCSI6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWCSI6W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 03:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWCSI6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 03:58:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15745 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751461AbWCSI6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 03:58:11 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Date: Sun, 19 Mar 2006 00:58:07 -0800
Message-Id: <20060319085807.18849.66634.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Cpuset: remove useless local variable initialization
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Remove a useless variable initialization in cpuset
__cpuset_zone_allowed().  The local variable 'allowed' is
unconditionally set before use, later on in the code, so does
not need to be initialized.

Not that it seems to matter to the code generated any, as the
compiler optimizes out the superfluous assignment anyway.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.16-rc6-mm2.orig/kernel/cpuset.c	2006-03-18 21:50:34.801260046 -0800
+++ 2.6.16-rc6-mm2/kernel/cpuset.c	2006-03-18 21:50:47.036753643 -0800
@@ -2205,7 +2205,7 @@ int __cpuset_zone_allowed(struct zone *z
 {
 	int node;			/* node that zone z is on */
 	const struct cpuset *cs;	/* current cpuset ancestors */
-	int allowed = 1;		/* is allocation in zone z allowed? */
+	int allowed;			/* is allocation in zone z allowed? */
 
 	if (in_interrupt())
 		return 1;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

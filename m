Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271677AbTGRByw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 21:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271680AbTGRByw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 21:54:52 -0400
Received: from dsl027-161-083.atl1.dsl.speakeasy.net ([216.27.161.83]:32774
	"EHLO hoist") by vger.kernel.org with ESMTP id S271677AbTGRByt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 21:54:49 -0400
Date: Thu, 17 Jul 2003 22:09:43 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0 build alsa without procfs
Message-ID: <20030718020943.GA23272@suburbanjihad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: nick black <dank@suburbanjihad.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the attached/following fixes a compilation issue with alsa + !procfs.
applies to 2.6.0-test1-ac2 and 2.6.0-test1.

--- linux-2.6.0-test1-pristine/sound/core/memalloc.c	2003-07-17 20:28:36.000000000 -0400
+++ linux-2.6.0-test1/sound/core/memalloc.c	2003-07-17 22:03:41.000000000 -0400
@@ -886,7 +886,9 @@
 
 static int __init snd_mem_init(void)
 {
+#ifdef CONFIG_PROC_FS
 	create_proc_read_entry("driver/snd-page-alloc", 0, 0, snd_mem_proc_read, NULL);
+#endif
 #ifdef ENABLE_PREALLOC
 	preallocate_cards();
 #endif
-- 
nick black <dank@reflexsecurity.com>
"np:  nondeterministic polynomial-time
the class of dashed hopes and idle dreams." - the complexity zoo

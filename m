Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281138AbRKKWkX>; Sun, 11 Nov 2001 17:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281153AbRKKWkN>; Sun, 11 Nov 2001 17:40:13 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:57333 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S281138AbRKKWkE>;
	Sun, 11 Nov 2001 17:40:04 -0500
Date: Sun, 11 Nov 2001 23:40:02 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200111112240.XAA25982@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] proc_misc.c compile fix for 2.4.15-pre3
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

proc_misc.c won't compile in 2.4.15-pre3 if CONFIG_MODULES
is disabled. Obvious fix below.

/Mikael

--- linux-2.4.15-pre3/fs/proc/proc_misc.c.~1~	Sun Nov 11 22:17:54 2001
+++ linux-2.4.15-pre3/fs/proc/proc_misc.c	Sun Nov 11 22:31:35 2001
@@ -568,9 +568,11 @@
 	entry = create_proc_entry("mounts", 0, NULL);
 	if (entry)
 		entry->proc_fops = &proc_mounts_operations;
+#ifdef CONFIG_MODULES
 	entry = create_proc_entry("ksyms", 0, NULL);
 	if (entry)
 		entry->proc_fops = &proc_ksyms_operations;
+#endif
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {
 		proc_root_kcore->proc_fops = &proc_kcore_operations;

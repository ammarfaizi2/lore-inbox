Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275843AbRKFADO>; Mon, 5 Nov 2001 19:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbRKFADE>; Mon, 5 Nov 2001 19:03:04 -0500
Received: from zero.tech9.net ([209.61.188.187]:16399 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S275843AbRKFAC6>;
	Mon, 5 Nov 2001 19:02:58 -0500
Subject: [PATCH] 2.4.13-ac8: procfs compile fix
From: Robert Love <rml@tech9.net>
To: laughing@shared-source.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.31 (Preview Release)
Date: 05 Nov 2001 19:02:53 -0500
Message-Id: <1005004974.890.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel fails to compile with procfs enabled and modules disabled.

2.4.13-ac8 adds a fops structure for /proc/ksyms, which is only defined
if CONFIG_MODULES is set.  However, the proc entry is still created if
CONFIG_MODULES is not set.

--- linux-2.4.13-ac8/fs/proc/proc_misc.c	Mon Nov  5 17:34:08 2001
+++ linux/fs/proc/proc_misc.c	Mon Nov  5 18:29:55 2001
@@ -619,9 +619,11 @@
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

	Robert Love


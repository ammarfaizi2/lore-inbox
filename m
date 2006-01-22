Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWAVWT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWAVWT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWAVWT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:19:28 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:12301 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id S932197AbWAVWT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:19:28 -0500
Date: Sun, 22 Jan 2006 17:19:03 -0500 (EST)
Message-Id: <200601222219.k0MMJ3Qg209555@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org
Subject: [PATCH 4/4] pmap: reduced permissions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch changes all 3 remaining maps files to be readable
only for the file owner. There have been privacy concerns.

Fedora Core 4 has been shipping with such permissions on
the /proc/*/maps file already. General system monitoring
tools seldom use these files.

Signed-off-by: Albert Cahalan <acahalan@gmail.com>

---

This applies to -git4, grabbed Saturday night.


diff -Naurd 3/fs/proc/base.c 4/fs/proc/base.c
--- 3/fs/proc/base.c	2006-01-22 15:23:13.000000000 -0500
+++ 4/fs/proc/base.c	2006-01-22 15:44:16.000000000 -0500
@@ -202,7 +202,7 @@
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_MMU
-	E(PROC_TGID_PMAP,      "pmap",   S_IFREG|S_IRUGO),
+	E(PROC_TGID_PMAP,      "pmap",   S_IFREG|S_IRUSR),
 #endif
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
@@ -231,9 +231,9 @@
 	E(PROC_TID_CMDLINE,    "cmdline", S_IFREG|S_IRUGO),
 	E(PROC_TID_STAT,       "stat",    S_IFREG|S_IRUGO),
 	E(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO),
-	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO),
+	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUSR),
 #ifdef CONFIG_NUMA
-	E(PROC_TID_NUMA_MAPS,  "numa_maps",    S_IFREG|S_IRUGO),
+	E(PROC_TID_NUMA_MAPS,  "numa_maps",    S_IFREG|S_IRUSR),
 #endif
 	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 #ifdef CONFIG_SECCOMP

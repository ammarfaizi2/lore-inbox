Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753976AbWKRF61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbWKRF61 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbWKRF61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:58:27 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:56565 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1753976AbWKRF60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:58:26 -0500
Date: Fri, 17 Nov 2006 21:56:05 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH -mm] profile_likely: export do_check_likely
Message-Id: <20061117215605.40226e71.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

I see MODPOST warnings for all modules in some (random) configs; e.g.:
(This is a short list; I see >100 of these.)

WARNING: "do_check_likely" [net/sched/cls_basic.ko] undefined!
WARNING: "do_check_likely" [net/netfilter/x_tables.ko] undefined!
WARNING: "do_check_likely" [net/key/af_key.ko] undefined!
WARNING: "do_check_likely" [kernel/rcutorture.ko] undefined!
WARNING: "do_check_likely" [fs/xfs/xfs.ko] undefined!
WARNING: "do_check_likely" [fs/sysv/sysv.ko] undefined!
WARNING: "do_check_likely" [fs/reiserfs/reiserfs.ko] undefined!
WARNING: "do_check_likely" [fs/ntfs/ntfs.ko] undefined!
WARNING: "do_check_likely" [fs/minix/minix.ko] undefined!

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 lib/likely_prof.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2619-rc5mm2.orig/lib/likely_prof.c
+++ linux-2619-rc5mm2/lib/likely_prof.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
@@ -50,6 +51,7 @@ int do_check_likely(struct likeliness *l
 
 	return ret;
 }
+EXPORT_SYMBOL(do_check_likely);
 
 static void * lp_seq_start(struct seq_file *out, loff_t *pos)
 {


---

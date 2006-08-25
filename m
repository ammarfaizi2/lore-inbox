Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWHYBzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWHYBzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 21:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWHYBzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 21:55:20 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:27861 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751312AbWHYBzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 21:55:19 -0400
Date: Fri, 25 Aug 2006 10:57:55 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [BUG[[PATCH] register_one_node compile fix.
Message-Id: <20060825105755.55b15220.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

register_one_node()'s should be defined under CONFIG_NUMA=n.
fixes following bug.
--
  CC	  init/version.o
  LD	  init/built-in.o
  LD	  .tmp_vmlinux1
mm/built-in.o: In function `add_memory':
: undefined reference to `register_one_node'
--

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.18-rc4/include/linux/node.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/node.h
+++ linux-2.6.18-rc4/include/linux/node.h
@@ -30,12 +30,20 @@ extern struct node node_devices[];
 
 extern int register_node(struct node *, int, struct node *);
 extern void unregister_node(struct node *node);
+#ifdef CONFIG_NUMA
 extern int register_one_node(int nid);
 extern void unregister_one_node(int nid);
-#ifdef CONFIG_NUMA
 extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
 #else
+static inline int register_one_node(int nid)
+{
+	return 0;
+}
+static inline int unregister_one_node(int nid)
+{
+	return 0;
+}
 static inline int register_cpu_under_node(unsigned int cpu, unsigned int nid)
 {
 	return 0;


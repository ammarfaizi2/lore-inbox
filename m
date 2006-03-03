Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752096AbWCCApH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbWCCApH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 19:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbWCCApH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 19:45:07 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:58785 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752096AbWCCApF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 19:45:05 -0500
Date: Fri, 3 Mar 2006 09:44:56 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc5-mm1 memory-hotplug compile fix
Message-Id: <20060303094456.bd3f146c.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because zone_mem_map is removed, this warning appers at compile time.

include/linux/memory_hotplug.h:53: warning: 'struct page' declared inside parameter list

If CONFIG_FLAT_NODE_MEM_MAP==n (means CONFIG_FLATMEM || CONFIG_DISCONTIGMEM),
node_mem_map doesn't exist either. So this happens.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Index: testtree/include/linux/memory_hotplug.h
===================================================================
--- testtree.orig/include/linux/memory_hotplug.h
+++ testtree/include/linux/memory_hotplug.h
@@ -7,6 +7,7 @@
 #include <linux/notifier.h>
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+struct page;
 /*
  * pgdat resizing functions
  */

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVKRGvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVKRGvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 01:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVKRGvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 01:51:07 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57066 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932347AbVKRGvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 01:51:06 -0500
Message-ID: <437D79F3.9070301@jp.fujitsu.com>
Date: Fri, 18 Nov 2005 15:51:31 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: compile fix 2.6.15-rc1-mm1 + EXPERIMENTAL+  CONFIG_SPARSEMEM + X86_PC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a compile fix for
X86_PC && EXPERIMENTAL && CONFIG_SPARSEMEM=y && !CONFIG_NEED_MULTIPLE_NODES

BTW, on x86, it looks I can select CONFIG_NUMA=y but will not set
CONFIG_NEED_MULTIPLE_NODES. It this expected ?

-- Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Signed-Off-By KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com
--
Index: linux-2.6.15-rc1-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc1-mm1.orig/include/linux/mmzone.h
+++ linux-2.6.15-rc1-mm1/include/linux/mmzone.h
@@ -596,12 +596,13 @@ static inline int pfn_valid(unsigned lon
  		return 0;
  	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
  }
-
+#ifdef CONFIG_NEED_MULTIPLE_NODES
  #define pfn_to_nid(pfn)							\
  ({									\
   	unsigned long __pfn = (pfn);                                    \
  	page_to_nid(pfn_to_page(pfn));					\
  })
+#endif

  #define early_pfn_valid(pfn)	pfn_valid(pfn)
  void sparse_init(void);
Index: linux-2.6.15-rc1-mm1/drivers/base/memory.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/drivers/base/memory.c
+++ linux-2.6.15-rc1-mm1/drivers/base/memory.c
@@ -25,7 +25,7 @@

  #define MEMORY_CLASS_NAME	"memory"

-static struct sysdev_class memory_sysdev_class = {
+struct sysdev_class memory_sysdev_class = {
  	set_kset_name(MEMORY_CLASS_NAME),
  };
  EXPORT_SYMBOL(memory_sysdev_class);


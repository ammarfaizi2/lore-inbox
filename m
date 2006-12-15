Return-Path: <linux-kernel-owner+w=401wt.eu-S1751743AbWLODk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbWLODk5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 22:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWLODk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 22:40:57 -0500
Received: from fms-01.valinux.co.jp ([210.128.90.1]:45313 "EHLO
	mail.valinux.co.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751740AbWLODk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 22:40:57 -0500
From: Magnus Damm <damm@opensource.se>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Magnus Damm <damm@opensource.se>, Christoph Lameter <clameter@sgi.com>
Date: Fri, 15 Dec 2006 12:06:10 +0900
Message-Id: <20061215030610.24898.8839.sendpatchset@localhost>
Subject: [PATCH 2.6.20-rc1] fix vm_events_fold_cpu() build breakage
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix vm_events_fold_cpu() build breakage

2.6.20-rc1 does not build properly if CONFIG_VM_EVENT_COUNTERS is set
and CONFIG_HOTPLUG is unset:

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
mm/built-in.o: In function `page_alloc_cpu_notify':
page_alloc.c:(.text+0x56eb): undefined reference to `vm_events_fold_cpu'
make: *** [.tmp_vmlinux1] Error 1

Signed-Off-By: Magnus Damm <magnus@valinux.co.jp>
---

 Applies on top of linux-2.6.20-rc1.

 include/linux/vmstat.h |    4 ++++
 1 file changed, 4 insertions(+)

--- 0001/include/linux/vmstat.h
+++ 0003/include/linux/vmstat.h	2006-12-15 11:46:23.000000000 +0900
@@ -73,7 +73,11 @@ static inline void count_vm_events(enum 
 }
 
 extern void all_vm_events(unsigned long *);
+#ifdef CONFIG_HOTPLUG
 extern void vm_events_fold_cpu(int cpu);
+#else
+#define vm_events_fold_cpu(x)	do { } while (0)
+#endif
 
 #else
 

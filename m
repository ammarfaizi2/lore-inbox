Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbTIYRhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbTIYRgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:36:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:38080 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261346AbTIYReO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:34:14 -0400
Date: Thu, 25 Sep 2003 10:33:47 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] check_mem_region should be deprecated
Message-Id: <20030925103347.38f5a78a.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For 2.6.0-test, check_mem_region has the same races as check_region so it should
be marked deprecated as well.

diff -Nru a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h	Thu Sep 25 10:32:22 2003
+++ b/include/linux/ioport.h	Thu Sep 25 10:32:22 2003
@@ -107,7 +107,6 @@
 
 /* Compatibility cruft */
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
-#define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
 extern int __check_region(struct resource *, unsigned long, unsigned long);
@@ -116,5 +115,9 @@
 static inline int __deprecated check_region(unsigned long s, unsigned long n)
 {
 	return __check_region(&ioport_resource, s, n);
+}
+static inline int __deprecated check_mem_region(unsigned long s, unsigned long n)
+{
+	return __check_region(&iomem_resource, s, n);
 }
 #endif	/* _LINUX_IOPORT_H */

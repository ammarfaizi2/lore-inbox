Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424755AbWLHGRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424755AbWLHGRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 01:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424760AbWLHGRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 01:17:07 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:49552 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424745AbWLHGRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 01:17:03 -0500
Date: Thu, 7 Dec 2006 22:13:43 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] freezer.h uses task_struct fields
Message-Id: <20061207221343.82271a53.randy.dunlap@oracle.com>
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

freezer.h uses task_struct fields so it should include sched.h.

  CC [M]  fs/jfs/jfs_txnmgr.o
In file included from fs/jfs/jfs_txnmgr.c:49:
include/linux/freezer.h: In function 'frozen':
include/linux/freezer.h:9: error: dereferencing pointer to incomplete type
include/linux/freezer.h:9: error: 'PF_FROZEN' undeclared (first use in this function)
include/linux/freezer.h:9: error: (Each undeclared identifier is reported only once
include/linux/freezer.h:9: error: for each function it appears in.)
include/linux/freezer.h: In function 'freezing':
include/linux/freezer.h:17: error: dereferencing pointer to incomplete type
include/linux/freezer.h:17: error: 'PF_FREEZE' undeclared (first use in this function)
include/linux/freezer.h: In function 'freeze':
include/linux/freezer.h:26: error: dereferencing pointer to incomplete type
include/linux/freezer.h:26: error: 'PF_FREEZE' undeclared (first use in this function)
include/linux/freezer.h: In function 'do_not_freeze':
include/linux/freezer.h:34: error: dereferencing pointer to incomplete type
include/linux/freezer.h:34: error: 'PF_FREEZE' undeclared (first use in this function)
include/linux/freezer.h: In function 'thaw_process':
include/linux/freezer.h:43: error: dereferencing pointer to incomplete type
include/linux/freezer.h:43: error: 'PF_FROZEN' undeclared (first use in this function)
include/linux/freezer.h:44: warning: implicit declaration of function 'wake_up_process'
include/linux/freezer.h: In function 'frozen_process':
include/linux/freezer.h:55: error: dereferencing pointer to incomplete type
include/linux/freezer.h:55: error: dereferencing pointer to incomplete type
include/linux/freezer.h:55: error: 'PF_FREEZE' undeclared (first use in this function)
include/linux/freezer.h:55: error: 'PF_FROZEN' undeclared (first use in this function)
fs/jfs/jfs_txnmgr.c: In function 'freezing':
include/linux/freezer.h:18: warning: control reaches end of non-void function
make[2]: *** [fs/jfs/jfs_txnmgr.o] Error 1

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 include/linux/freezer.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.19-git11.orig/include/linux/freezer.h
+++ linux-2.6.19-git11/include/linux/freezer.h
@@ -1,5 +1,7 @@
 /* Freezer declarations */
 
+#include <linux/sched.h>
+
 #ifdef CONFIG_PM
 /*
  * Check if a process has been frozen


---

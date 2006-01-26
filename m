Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWAZD5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWAZD5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWAZDtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:31 -0500
Received: from [202.53.187.9] ([202.53.187.9]:18667 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932245AbWAZDtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:20 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 08/23] [Suspend2] New freezer explanation for kernel/power/process.c
Date: Thu, 26 Jan 2006 13:45:44 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034543.3178.22323.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Modify kernel/power/process.c header to describe how the new freezer
implementation works.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index a788186..6da0445 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -1,8 +1,28 @@
 /*
- * drivers/power/process.c - Functions for starting/stopping processes on 
- *                           suspend transitions.
+ * kernel/power/process.c
  *
- * Originally from swsusp.
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains the routines used to freeze processes during a suspend
+ * cycle (or perhaps in future, a process migration).
+ *
+ * When quiescing the whole system, one process initiates this
+ * functionality by calling freeze_processes(). First, userspace
+ * is frozen. Then bdevs for mounted filesystems are frozen so
+ * as to ensure pending I/O is flushed and stopped. Finally,
+ * kernel threads which are no marked as unfreezeable (perhaps
+ * because they're needed for doing I/O) are frozen. Splitting
+ * kernel threads from userspace also improves reliability,
+ * because it ensures that a userspace thread doesn't deadlock,
+ * waiting for a kernel thread that has already been frozen to
+ * process some request, and because it stops the cause of most
+ * work for kernel threads (ie userspace), allowing those thread
+ * to complete their work more quickly.
  */
 
 

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWAZDyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWAZDyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWAZDxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:53:13 -0500
Received: from [202.53.187.9] ([202.53.187.9]:24811 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932224AbWAZDtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:40 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 20/23] [Suspend2] Modify process.c includes and export freezer state.
Date: Thu, 26 Jan 2006 13:46:07 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034606.3178.13356.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Modify kernel/power/process #includes and add the exported freezer_state
variable. (The symbol is exported so that modules can use the
freezer_is_on() macro).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 711ac1a..aad2aa5 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -28,10 +28,15 @@
 
 #undef DEBUG
 
-#include <linux/smp_lock.h>
-#include <linux/interrupt.h>
 #include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/module.h>
+#include <linux/mount.h>
+#include <linux/namespace.h>
+#include <linux/buffer_head.h>
+#include <asm/tlbflush.h>
+
+unsigned long freezer_state = 0;
 
 #if 0
 //#ifdef CONFIG_PM_DEBUG
@@ -420,3 +425,4 @@ int freeze_processes(void)
 	return 0;
 }
 
+EXPORT_SYMBOL(freezer_state);

--
Nigel Cunningham		nigel at suspend2 dot net

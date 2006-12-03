Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424982AbWLCFvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424982AbWLCFvF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 00:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424983AbWLCFvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 00:51:04 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:722 "EHLO adelie.ubuntu.com")
	by vger.kernel.org with ESMTP id S1424982AbWLCFvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 00:51:02 -0500
Subject: [PATCH] Export current_is_keventd() for libphy
From: Ben Collins <ben.collins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 03 Dec 2006 00:50:55 -0500
Message-Id: <1165125055.5320.14.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes this problem when libphy is compiled as module:

WARNING: "current_is_keventd" [drivers/net/phy/libphy.ko] undefined!

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 17c2f03..1cf226b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -608,6 +608,7 @@ int current_is_keventd(void)
 	return ret;
 
 }
+EXPORT_SYMBOL_GPL(current_is_keventd);
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* Take the work from this (downed) CPU. */


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVESQn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVESQn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 12:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVESQn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 12:43:29 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:23959 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261151AbVESQnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 12:43:25 -0400
Date: Thu, 19 May 2005 09:43:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc4] Add EXPORT_SYMBOL for hotplug_path
Message-ID: <20050519164323.GK3771@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_INPUT is set as a module, it will not load as hotplug_path is
not a defined symbol.  Trivial fix is to EXPORT_SYMBOL hotplug_path.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: lib/kobject_uevent.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/lib/kobject_uevent.c  (mode:100644)
+++ uncommitted/lib/kobject_uevent.c  (mode:100644)
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/kobject_uevent.h>
 #include <linux/kobject.h>
+#include <linux/module.h>
 #include <net/sock.h>
 
 #define BUFFER_SIZE	1024	/* buffer for the hotplug env */
@@ -178,6 +179,7 @@
 
 #ifdef CONFIG_HOTPLUG
 char hotplug_path[HOTPLUG_PATH_LEN] = "/sbin/hotplug";
+EXPORT_SYMBOL(hotplug_path);
 u64 hotplug_seqnum;
 static DEFINE_SPINLOCK(sequence_lock);
 

-- 
Tom Rini
http://gate.crashing.org/~trini/

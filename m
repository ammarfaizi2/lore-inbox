Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVBAQII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVBAQII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 11:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVBAQHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 11:07:41 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:60312 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262057AbVBAQGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 11:06:43 -0500
Date: Tue, 1 Feb 2005 09:06:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc2] Move <linux/prio_tree.h> down in <linux/fs.h>
Message-ID: <20050201160642.GA15359@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/prio_tree.h> is unsafe for inclusion by userland apps, but it is
in the userland-exposed portion of <linux/fs.h>.  It's only needed in
the __KERNEL__ protected portion of the file, so move the #include down
to there.

lmbench-2.0.4 runs into this issue in 'flushdisk'.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.377/include/linux/fs.h	2005-01-25 14:43:48 -07:00
+++ edited/include/linux/fs.h	2005-02-01 09:04:28 -07:00
@@ -16,7 +16,6 @@
 #include <linux/dcache.h>
 #include <linux/stat.h>
 #include <linux/cache.h>
-#include <linux/prio_tree.h>
 #include <linux/kobject.h>
 #include <asm/atomic.h>
 
@@ -219,6 +218,7 @@
 
 #include <linux/list.h>
 #include <linux/radix-tree.h>
+#include <linux/prio_tree.h>
 #include <linux/audit.h>
 #include <linux/init.h>
 #include <asm/semaphore.h>

-- 
Tom Rini
http://gate.crashing.org/~trini/

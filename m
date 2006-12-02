Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162474AbWLBTkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162474AbWLBTkT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 14:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759457AbWLBTkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 14:40:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35078 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758504AbWLBTkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 14:40:17 -0500
Date: Sat, 2 Dec 2006 20:40:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] FW_LOADER should select HOTPLUG
Message-ID: <20061202194022.GY11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since FW_LOADER is an option that is always select'ed by the code using 
it, it mustn't depend on HOTPLUG.

It's only relevant in the EMBEDDED=y case, but this might have resulted 
in illegal FW_LOADER=, HOTPLUG=n configurations.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm2/drivers/base/Kconfig.old	2006-12-02 20:36:49.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/base/Kconfig	2006-12-02 20:37:03.000000000 +0100
@@ -19,8 +19,8 @@
 	  If unsure say Y here.
 
 config FW_LOADER
-	tristate "Userspace firmware loading support"
-	depends on HOTPLUG
+	tristate
+	select HOTPLUG
 	---help---
 	  This option is provided for the case where no in-kernel-tree modules
 	  require userspace firmware loading support, but a module built outside


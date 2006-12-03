Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031795AbWLCHQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031795AbWLCHQc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 02:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031796AbWLCHQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 02:16:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14858 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031795AbWLCHQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 02:16:32 -0500
Date: Sun, 3 Dec 2006 08:16:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] FW_LOADER should select HOTPLUG
Message-ID: <20061203071637.GA11084@stusta.de>
References: <20061202194022.GY11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061202194022.GY11084@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ fixed patch below ]

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
--- linux-2.6.19-rc6-mm2/drivers/pcmcia/Kconfig.old	2006-12-02 21:16:39.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/pcmcia/Kconfig	2006-12-02 21:16:46.000000000 +0100
@@ -6,7 +6,7 @@
 
 config PCCARD
 	tristate "PCCard (PCMCIA/CardBus) support"
-	depends on HOTPLUG
+	select HOTPLUG
 	---help---
 	  Say Y here if you want to attach PCMCIA- or PC-cards to your Linux
 	  computer.  These are credit-card size devices such as network cards,

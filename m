Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVGWWFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVGWWFU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 18:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVGWWFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 18:05:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22788 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261899AbVGWWFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 18:05:18 -0400
Date: Sun, 24 Jul 2005 00:05:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] DLM must depend on SYSFS
Message-ID: <20050723220511.GK3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DLM=y and CONFIG_SYSFS=n results in the following compile error:

<--  snip  -->

...
  LD      vmlinux
drivers/built-in.o:(.data+0x271e80): undefined reference to `kernel_subsys'
make: *** [vmlinux] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/drivers/dlm/Kconfig.old	2005-07-23 22:24:35.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/dlm/Kconfig	2005-07-23 22:26:00.000000000 +0200
@@ -3,6 +3,7 @@
 
 config DLM
 	tristate "Distributed Lock Manager (DLM)"
+	depends on SYSFS
 	select IP_SCTP
 	help
 	A general purpose distributed lock manager for kernel or userspace


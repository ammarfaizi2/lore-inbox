Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVHVUgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVHVUgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVHVUgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:36:04 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:62181 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751146AbVHVUgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:36:03 -0400
Date: Mon, 22 Aug 2005 18:20:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] DLM must depend on SYSFS
Message-ID: <20050822162047.GB9927@stusta.de>
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
drivers/built-in.o:(.data+0x282340): undefined reference to `kernel_subsys'
make: *** [vmlinux] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/drivers/dlm/Kconfig.old	2005-08-22 01:56:18.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/drivers/dlm/Kconfig	2005-08-22 01:56:38.000000000 +0200
@@ -3,6 +3,7 @@
 
 config DLM
 	tristate "Distributed Lock Manager (DLM)"
+	depends on SYSFS
 	depends on IPV6 || IPV6=n
 	select IP_SCTP
 	select CONFIGFS_FS


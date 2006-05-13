Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWEMLw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWEMLw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWEMLw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:52:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:31123 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932383AbWEMLw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:52:58 -0400
Date: Sat, 13 May 2006 13:52:56 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: [PATCH] add raw driver Kconfig entry for s390
Message-ID: <20060513115255.GA11955@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ihno Krumreich <ihno@suse.de>

The raw module is not enabled on s390/s390x
During SLES9 and SLES10 development IBM filed bugs about the missing raw
driver. Avoid that for SLES11 by adding it to the other char driver
entries.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 drivers/s390/Kconfig |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: linux-2.6.16/drivers/s390/Kconfig
===================================================================
--- linux-2.6.16.orig/drivers/s390/Kconfig
+++ linux-2.6.16/drivers/s390/Kconfig
@@ -51,6 +51,26 @@ config UNIX98_PTY_COUNT
 	  When not in use, each additional set of 256 PTYs occupy
 	  approximately 8 KB of kernel memory on 32-bit architectures.
 
+config RAW_DRIVER
+	tristate "RAW driver (/dev/raw/rawN) (OBSOLETE)"
+	help
+	  The raw driver permits block devices to be bound to /dev/raw/rawN.
+	  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O.
+	  See the raw(8) manpage for more details.
+
+          The raw driver is deprecated and may be removed from 2.7
+          kernels.  Applications should simply open the device (eg /dev/hda1)
+          with the O_DIRECT flag.
+
+config MAX_RAW_DEVS
+	int "Maximum number of RAW devices to support (1-8192)"
+	depends on RAW_DRIVER
+	default "256"
+	help
+	  The maximum number of RAW devices that are supported.
+	  Default is 256. Increase this number in case you need lots of
+	  raw devices.
+
 config HANGCHECK_TIMER
 	tristate "Hangcheck timer"
 	help

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWFZQrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWFZQrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWFZQrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:47:03 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:31205 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750808AbWFZQqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:46:38 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 1/4] [Suspend2] Suspend2 Kconfig modifications.
Date: Tue, 27 Jun 2006 02:46:41 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164639.10641.73525.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164637.10641.63979.stgit@nigel.suspend2.net>
References: <20060626164637.10641.63979.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add Suspend2 Kconfig entries to the kernel/power/Kconfig file.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/Kconfig |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index e8d57d1..cb5475a 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -98,6 +98,67 @@ config SUSPEND_SMP
 	bool
 	depends on HOTPLUG_CPU && X86 && PM
 	default y
+
+config SUSPEND2_CRYPTO
+	bool
+	depends on SUSPEND2 && CRYPTO
+	default y
+
+menuconfig SUSPEND2
+	bool "Suspend2"
+	depends on PM
+	select DYN_PAGEFLAGS
+	select HOTPLUG_CPU if SMP
+	---help---
+	  Suspend2 is the 'new and improved' suspend support.
+	  
+	  See the Suspend2 home page (suspend2.net)
+	  for FAQs, HOWTOs and other documentation.
+
+	comment 'Image Storage (you need at least one writer)'
+		depends on SUSPEND2
+	
+	config SUSPEND2_FILEWRITER
+		bool '  File Writer'
+		depends on SUSPEND2
+		---help---
+		  This option enables support for storing an image in a
+		  simple file. This should be possible, but we're still
+		  testing it.
+
+	config SUSPEND2_SWAPWRITER
+		bool '  Swap Writer'
+		depends on SUSPEND2
+		select SWAP
+		---help---
+		  This option enables support for storing an image in your
+		  swap space.
+
+	comment 'General Options'
+		depends on SUSPEND2
+
+	config SUSPEND2_DEFAULT_RESUME2
+		string '  Default resume device name'
+		depends on SUSPEND2
+		---help---
+		  You normally need to add a resume2= parameter to your lilo.conf or
+		  equivalent. With this option properly set, the kernel has a value
+		  to default. No damage will be done if the value is invalid.
+
+	config SUSPEND2_KEEP_IMAGE
+		bool '  Allow Keep Image Mode'
+		depends on SUSPEND2
+		---help---
+		  This option allows you to keep and image and reuse it. It is intended
+		  __ONLY__ for use with systems where all filesystems are mounted read-
+		  only (kiosks, for example). To use it, compile this option in and boot
+		  normally. Set the KEEP_IMAGE flag in /proc/suspend2 and suspend.
+		  When you resume, the image will not be removed. You will be unable to turn
+		  off swap partitions (assuming you are using the swap writer), but future
+		  suspends simply do a power-down. The image can be updated using the
+		  kernel command line parameter suspend_act= to turn off the keep image
+		  bit. Keep image mode is a little less user friendly on purpose - it
+		  should not be used without thought!
  
 config SUSPEND_SHARED
 	bool

--
Nigel Cunningham		nigel at suspend2 dot net

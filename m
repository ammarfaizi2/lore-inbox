Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWBUOiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWBUOiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWBUOiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:38:06 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:62391 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932732AbWBUOiF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:38:05 -0500
Message-ID: <43FB25C8.1070303@us.ibm.com>
Date: Tue, 21 Feb 2006 09:38:00 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: xen-devel@lists.xensource.com
CC: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [ PATCH 2.6.16-rc3-xen 2/3] sysfs: export Xen hypervisor attributes
 to sysfs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# HG changeset patch
# User mdday@dual.silverwood.home
# Node ID f5f32dc60121c32fab158a814c914aae3b77ba06
# Parent  d296aaf07bcb4141c6dc2a1bfa7d183f919c2167
Add tri-state Kconfig option for building xen-sysfs module. 

signed-off-by: Mike D. Day <ncmike@us.ibm.com>

diff -r d296aaf07bcb -r f5f32dc60121 linux-2.6-xen-sparse/drivers/xen/Kconfig
--- a/linux-2.6-xen-sparse/drivers/xen/Kconfig	Tue Feb 21 08:11:03 2006 -0500
+++ b/linux-2.6-xen-sparse/drivers/xen/Kconfig	Tue Feb 21 08:12:11 2006 -0500
@@ -173,12 +173,20 @@ config XEN_SCRUB_PAGES
	  saying N.

config XEN_DISABLE_SERIAL
-	bool "Disable serial port drivers"
+	bool "Disable serial port drivers"	
	default y
	help
	  Disable serial port drivers, allowing the Xen console driver
	  to provide a serial console at ttyS0.

+config XEN_SYSFS
+	tristate "Export Xen attributes in sysfs"
+	depends on XEN
+	depends on SYSFS
+	default y
+	help
+		Xen hypervisor attributes will show up under /sys/hypervisor/.
+
endmenu

config HAVE_ARCH_ALLOC_SKB
diff -r d296aaf07bcb -r f5f32dc60121 linux-2.6-xen-sparse/drivers/xen/Makefile
--- a/linux-2.6-xen-sparse/drivers/xen/Makefile	Tue Feb 21 08:11:03 2006 -0500
+++ b/linux-2.6-xen-sparse/drivers/xen/Makefile	Tue Feb 21 08:12:11 2006 -0500
@@ -19,4 +19,3 @@ obj-$(CONFIG_XEN_TPMDEV_FRONTEND)	+= tpm
obj-$(CONFIG_XEN_TPMDEV_FRONTEND)	+= tpmfront/
obj-$(CONFIG_XEN_PCIDEV_BACKEND)	+= pciback/
obj-$(CONFIG_XEN_PCIDEV_FRONTEND)	+= pcifront/
-

-- 



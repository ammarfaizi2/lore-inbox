Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbSJHXSb>; Tue, 8 Oct 2002 19:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbSJHXRe>; Tue, 8 Oct 2002 19:17:34 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:53513 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261490AbSJHXRH>;
	Tue, 8 Oct 2002 19:17:07 -0400
Date: Tue, 8 Oct 2002 16:19:03 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB and driver core changes for 2.5.41
Message-ID: <20021008231903.GF11337@kroah.com>
References: <20021008231511.GA11337@kroah.com> <20021008231557.GB11337@kroah.com> <20021008231646.GC11337@kroah.com> <20021008231747.GD11337@kroah.com> <20021008231832.GE11337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008231832.GE11337@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.573.92.16 -> 1.573.92.17
#	include/linux/device.h	1.39    -> 1.40   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/08	dsteklof@us.ibm.com	1.573.92.17
# driver core: add generic logging macros for devices.
# --------------------------------------------
#
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Oct  8 15:53:41 2002
+++ b/include/linux/device.h	Tue Oct  8 15:53:41 2002
@@ -421,4 +421,23 @@
 extern void device_resume(u32 level);
 extern void device_shutdown(void);
 
+/* debugging and troubleshooting/diagnostic helpers. */
+#ifdef DEBUG
+#define dev_dbg(dev, format, arg...)		\
+	printk (KERN_DEBUG "%s %s: " format ,	\
+		dev.driver->name , dev.bus_id , ## arg)
+#else
+#define dev_dbg(dev, format, arg...) do {} while (0)
+#endif
+
+#define dev_err(dev, format, arg...)		\
+	printk (KERN_ERR "%s %s: " format ,	\
+		dev.driver->name , dev.bus_id , ## arg)
+#define dev_info(dev, format, arg...)		\
+	printk (KERN_INFO "%s %s: " format ,	\
+		dev.driver->name , dev.bus_id , ## arg)
+#define dev_warn(dev, format, arg...)		\
+	printk (KERN_WARN "%s %s: " format ,	\
+		dev.driver->name , dev.bus_id , ## arg)
+
 #endif /* _DEVICE_H_ */

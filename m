Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbSJHXSb>; Tue, 8 Oct 2002 19:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbSJHXRk>; Tue, 8 Oct 2002 19:17:40 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:52745 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261404AbSJHXQh>;
	Tue, 8 Oct 2002 19:16:37 -0400
Date: Tue, 8 Oct 2002 16:18:32 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB and driver core changes for 2.5.41
Message-ID: <20021008231832.GE11337@kroah.com>
References: <20021008231511.GA11337@kroah.com> <20021008231557.GB11337@kroah.com> <20021008231646.GC11337@kroah.com> <20021008231747.GD11337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008231747.GD11337@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.573.92.15 -> 1.573.92.16
#	drivers/media/video/cpia_usb.c	1.9     -> 1.10   
#	drivers/media/video/cpia.h	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/07	rddunlap@osdl.org	1.573.92.16
# [PATCH] build cpia video driver
# 
# This patch enables the cpia driver to build on 2.5.41.
# --------------------------------------------
#
diff -Nru a/drivers/media/video/cpia.h b/drivers/media/video/cpia.h
--- a/drivers/media/video/cpia.h	Tue Oct  8 15:53:44 2002
+++ b/drivers/media/video/cpia.h	Tue Oct  8 15:53:44 2002
@@ -378,8 +378,8 @@
 /* ErrorCode */
 #define ERROR_FLICKER_BELOW_MIN_EXP     0x01 /*flicker exposure got below minimum exposure */
 
-#define ALOG(lineno,fmt,args...) printk(fmt,lineno,##args)
-#define LOG(fmt,args...) ALOG((__LINE__),KERN_INFO __FILE__":"__FUNCTION__"(%d):"fmt,##args)
+#define ALOG(fmt,args...) printk(fmt, ##args)
+#define LOG(fmt,args...) ALOG(KERN_INFO __FILE__ ":%s(%d):" fmt, __FUNCTION__, __LINE__, ##args)
 
 #ifdef _CPIA_DEBUG_
 #define ADBG(lineno,fmt,args...) printk(fmt, jiffies, lineno, ##args)
diff -Nru a/drivers/media/video/cpia_usb.c b/drivers/media/video/cpia_usb.c
--- a/drivers/media/video/cpia_usb.c	Tue Oct  8 15:53:44 2002
+++ b/drivers/media/video/cpia_usb.c	Tue Oct  8 15:53:44 2002
@@ -167,7 +167,7 @@
 	/* resubmit */
 	urb->dev = ucpia->dev;
 	if ((i = usb_submit_urb(urb, GFP_ATOMIC)) != 0)
-		printk(KERN_ERR __FUNCTION__ ": usb_submit_urb ret %d\n", i);
+		printk(KERN_ERR "%s: usb_submit_urb ret %d\n", __FUNCTION__,  i);
 }
 
 static int cpia_usb_open(void *privdata)

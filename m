Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262549AbSI0RXr>; Fri, 27 Sep 2002 13:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbSI0RXr>; Fri, 27 Sep 2002 13:23:47 -0400
Received: from [216.40.201.6] ([216.40.201.6]:62993 "EHLO
	www.businesssite.com.br") by vger.kernel.org with ESMTP
	id <S262549AbSI0RXB>; Fri, 27 Sep 2002 13:23:01 -0400
Date: Fri, 27 Sep 2002 14:18:38 -0300
To: sbertin@mindspring.com, Peter_Pregler@email.com, jerdfelt@valinux.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] __FUNCTION__ issue (cpia)
Message-ID: <20020927171838.GP20649@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


-- 
aris

--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpia.patch"

--- linux-2.5.38-vanilla/drivers/media/video/cpia.h	2002-09-22 01:25:18.000000000 -0300
+++ linux-2.5.38/drivers/media/video/cpia.h	2002-09-27 10:14:28.000000000 -0300
@@ -378,12 +378,12 @@
 /* ErrorCode */
 #define ERROR_FLICKER_BELOW_MIN_EXP     0x01 /*flicker exposure got below minimum exposure */
 
-#define ALOG(lineno,fmt,args...) printk(fmt,lineno,##args)
-#define LOG(fmt,args...) ALOG((__LINE__),KERN_INFO __FILE__":"__FUNCTION__"(%d):"fmt,##args)
+#define ALOG(lineno,func,fmt,args...) printk(fmt,func,lineno,##args)
+#define LOG(fmt,args...) ALOG((__LINE__),__FUNCTION__,KERN_INFO __FILE__":%s(%d):"fmt,##args)
 
 #ifdef _CPIA_DEBUG_
-#define ADBG(lineno,fmt,args...) printk(fmt, jiffies, lineno, ##args)
-#define DBG(fmt,args...) ADBG((__LINE__),KERN_DEBUG __FILE__"(%ld):"__FUNCTION__"(%d):"fmt,##args)
+#define ADBG(lineno,func,fmt,args...) printk(fmt, jiffies, func, lineno, ##args)
+#define DBG(fmt,args...) ADBG((__LINE__),__FUNCTION__, KERN_DEBUG __FILE__"(%ld):%s(%d):"fmt,##args)
 #else
 #define DBG(fmn,args...) do {} while(0)
 #endif
--- linux-2.5.38-vanilla/drivers/media/video/cpia_usb.c	2002-09-22 01:24:58.000000000 -0300
+++ linux-2.5.38/drivers/media/video/cpia_usb.c	2002-09-27 10:22:24.000000000 -0300
@@ -167,7 +167,7 @@
 	/* resubmit */
 	urb->dev = ucpia->dev;
 	if ((i = usb_submit_urb(urb, GFP_ATOMIC)) != 0)
-		printk(KERN_ERR __FUNCTION__ ": usb_submit_urb ret %d\n", i);
+		printk(KERN_ERR "%s: usb_submit_urb ret %d\n", __FUNCTION__, i);
 }
 
 static int cpia_usb_open(void *privdata)

--yZnyZsPjQYjG7xG7--

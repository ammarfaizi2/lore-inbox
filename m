Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVAFBaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVAFBaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 20:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVAFBap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 20:30:45 -0500
Received: from lakermmtao11.cox.net ([68.230.240.28]:44467 "EHLO
	lakermmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262693AbVAFBa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 20:30:26 -0500
Mime-Version: 1.0 (Apple Message framework v619)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <8A1C5ED3-5F82-11D9-B39F-000393ACC76E@mac.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-7--33710008
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [PATCH] [2.6] Clean up SL811 headers
Date: Wed, 5 Jan 2005 20:30:25 -0500
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-7--33710008
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

The USB SL811 host has a structure stuck in linux/usb_sl811.h  As this
structure is kernel private and only used by a single piece of code, 
this
patch moves it to the header file from which it is used, deleting the 
old one.

Signed-off-by: Kyle Moffett <mrmacman_g4@mac.com>


--Apple-Mail-7--33710008
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="cleanup-sl811-headers.patch"
Content-Disposition: attachment;
	filename=cleanup-sl811-headers.patch

Index: drivers/usb/host/sl811.h
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/drivers/usb/host/sl811.h,v
retrieving revision 1.2
diff -u -r1.2 sl811.h
--- drivers/usb/host/sl811.h	9 Dec 2004 20:35:50 -0000	1.2
+++ drivers/usb/host/sl811.h	6 Jan 2005 01:13:59 -0000
@@ -117,6 +117,30 @@
 #define	LOG2_PERIODIC_SIZE	5	/* arbitrary; this matches OHCI */
 #define	PERIODIC_SIZE		(1 << LOG2_PERIODIC_SIZE)
 
+/*
+ * board initialization should put one of these into dev->platform_data
+ * and place the sl811hs onto platform_bus named "sl811-hcd".
+ */
+struct sl811_platform_data {
+	unsigned	can_wakeup:1;
+
+	/* given port_power, msec/2 after power on till power good */
+	u8		potpg;
+
+	/* mA/2 power supplied on this port (max = default = 250) */
+	u8		power;
+
+	/* sl811 relies on an external source of VBUS current */
+	void 		(*port_power)(struct device *dev, int is_on);
+
+	/* pulse sl811 nRST (probably with a GPIO) */
+	void 		(*reset)(struct device *dev);
+
+	// some boards need something like these:
+ 	// int 		(*check_overcurrent)(struct device *dev);
+ 	// void 	(*clock_enable)(struct device *dev, int is_on);
+};
+
 struct sl811 {
 	struct usb_hcd		hcd;
 	spinlock_t		lock;
Index: include/linux/usb_sl811.h
===================================================================
RCS file: include/linux/usb_sl811.h
diff -N include/linux/usb_sl811.h
--- include/linux/usb_sl811.h	9 Dec 2004 20:35:50 -0000	1.2
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,26 +0,0 @@
-
-/*
- * board initialization should put one of these into dev->platform_data
- * and place the sl811hs onto platform_bus named "sl811-hcd".
- */
-
-struct sl811_platform_data {
-	unsigned	can_wakeup:1;
-
-	/* given port_power, msec/2 after power on till power good */
-	u8		potpg;
-
-	/* mA/2 power supplied on this port (max = default = 250) */
-	u8		power;
-
-	/* sl811 relies on an external source of VBUS current */
-	void 		(*port_power)(struct device *dev, int is_on);
-
-	/* pulse sl811 nRST (probably with a GPIO) */
-	void 		(*reset)(struct device *dev);
-
-	// some boards need something like these:
- 	// int 		(*check_overcurrent)(struct device *dev);
- 	// void 	(*clock_enable)(struct device *dev, int is_on);
-};
-

--Apple-Mail-7--33710008
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


--Apple-Mail-7--33710008--


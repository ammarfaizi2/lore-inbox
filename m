Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUGBSOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUGBSOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUGBSOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:14:17 -0400
Received: from unknown-raq-customer.dca1.superb.net ([207.228.240.52]:21267
	"EHLO allied.allied-universal.com") by vger.kernel.org with ESMTP
	id S264858AbUGBSOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:14:00 -0400
To: linux-kernel@vger.kernel.org
From: Paul King <paul@allied-universal.com>
Subject: [PATCH] 2.6.7 Telephony support devfs
Reply-To: paul@allied-universal.com
Date: Fri, 2 Jul 2004 19:06:12 +0100
X-Originating-Host: cache5-lutn.server.ntli.net [62.252.64.16]; Fri, 2 Jul 2004 17:43:09 GMT
X-Mailer: Mailreader.com v2.3.29 (2001-07-20)
X-Browser: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.1.4322), JavaScript: On
Message-ID: <jUsT.aNoTheR.mEsSaGe.iD.108879018915930@mail.allied-universal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add devfs support to telephony devices. Only tested with a single 
telephony device. Devices name phone/<minor>. Patch against 2.6.7.



--- phonedev.c  2004-06-16 05:19:37.000000000 +0000
+++ /usr/src/linux/drivers/telephony/phonedev.c 2004-07-02 19:09:
46.951837584 +0000
@@ -28,7 +28,7 @@

 #include <linux/kmod.h>
 #include <linux/sem.h>
-
+#include <linux/devfs_fs_kernel.h>

 #define PHONE_NUM_DEVICES      256

@@ -105,6 +105,7 @@
                if (phone_device[i] == NULL) {
                        phone_device[i] = p;
                        p->minor = i;
+                       devfs_mk_cdev(MKDEV(PHONE_MAJOR,i),S_IFCHR|S_IRUSR|S_IWUSR,
"phone/%d",i);
                        up(&phone_lock);
                        return 0;
                }
@@ -122,6 +123,7 @@
        down(&phone_lock);
        if (phone_device[pfd->minor] != pfd)
                panic("phone: bad unregister");
+       devfs_remove("phone/%d",pfd->minor);
        phone_device[pfd->minor] = NULL;
        up(&phone_lock);
 }








Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263988AbTDJHJo (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 03:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263989AbTDJHJo (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 03:09:44 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.29]:13353 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263988AbTDJHJn (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 03:09:43 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH] USB speedtouch (2.4): move MOD_INC_USE_COUNT
Date: Thu, 10 Apr 2003 09:21:18 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200304042115.00706.baldrick@wanadoo.fr> <20030410001915.GB3542@kroah.com>
In-Reply-To: <20030410001915.GB3542@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304100921.18085.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 speedtouch.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/speedtouch.c b/drivers/usb/speedtouch.c
--- a/drivers/usb/speedtouch.c	Thu Apr 10 09:18:28 2003
+++ b/drivers/usb/speedtouch.c	Thu Apr 10 09:18:28 2003
@@ -938,15 +938,19 @@
 		return -EAGAIN;
 	}
 
+	MOD_INC_USE_COUNT;
+
 	down (&instance->serialize); /* vs self, udsl_atm_close */
 
 	if (udsl_find_vcc (instance, vpi, vci)) {
 		up (&instance->serialize);
+		MOD_DEC_USE_COUNT;
 		return -EADDRINUSE;
 	}
 
 	if (!(new = kmalloc (sizeof (struct udsl_vcc_data), GFP_KERNEL))) {
 		up (&instance->serialize);
+		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 
@@ -975,8 +979,6 @@
 	udsl_fire_receivers (instance);
 
 	dbg ("udsl_atm_open successful");
-
-	MOD_INC_USE_COUNT;
 
 	return 0;
 }


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVKFAfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVKFAfV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVKFAfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:35:21 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:54402 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932240AbVKFAfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:35:20 -0500
Message-ID: <436D50E1.2020007@student.ltu.se>
Date: Sun, 06 Nov 2005 01:40:01 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ballabio_dario@emc.com
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] eisa.h - implement stub-functions if !CONFIG_EISA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement stub-functions if !CONFIG_EISA.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

To reduce the need for #ifdef CONFIG_EISA in drivers.
2.6.14-git8

diff -Narup a/include/linux/eisa.h b/include/linux/eisa.h
--- a/include/linux/eisa.h	2005-11-05 22:02:08.000000000 +0200
+++ b/include/linux/eisa.h	2005-11-06 00:49:38.000000000 +0100
@@ -68,8 +68,14 @@ struct eisa_driver {
 #define to_eisa_driver(drv) container_of(drv,struct eisa_driver, driver)
 
 extern struct bus_type eisa_bus_type;
+
+#ifdef CONFIG_EISA
 int eisa_driver_register (struct eisa_driver *edrv);
 void eisa_driver_unregister (struct eisa_driver *edrv);
+#else
+static inline int eisa_driver_register (struct eisa_driver *edrv) { return 0; }
+static inline void eisa_driver_unregister (struct eisa_driver *edrv) { }
+#endif
 
 /* Mimics pci.h... */
 static inline void *eisa_get_drvdata (struct eisa_device *edev)
@@ -96,7 +102,11 @@ struct eisa_root_device {
 	struct resource  eisa_root_res;	/* ditto */
 };
 
+#ifdef CONFIG_EISA
 int eisa_root_register (struct eisa_root_device *root);
+#else
+static inline int eisa_root_register (struct eisa_root_device *root) { return 0; }
+#endif
 
 #ifdef CONFIG_EISA
 extern int EISA_bus;



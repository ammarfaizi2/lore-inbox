Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVIMUxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVIMUxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVIMUxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:53:35 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:19463 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932345AbVIMUxe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:53:34 -0400
Date: Tue, 13 Sep 2005 22:54:19 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>, Joern Engel <joern@infradead.org>
Subject: [PATCH 2.6] I2C: Kill an unused i2c_adapter struct member
Message-Id: <20050913225419.59aac16f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, all,

Kill an unused member of the i2c_adapter structure. This additionally
fixes a potential bug, because <linux/i2c.h> doesn't include
<linux/config.h>, so different files including <linux/i2c.h> could see
a different definition of the i2c_adapter structure, depending on them
including <linux/config.h> (or other header files themselves including
<linux/config.h>) before <linux/i2c.h>, or not.

Credits go to Jörn Engel for pointing me to the problem.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 include/linux/i2c.h |    5 -----
 1 file changed, 5 deletions(-)

--- linux-2.6.14-rc1.orig/include/linux/i2c.h	2005-09-13 21:21:25.000000000 +0200
+++ linux-2.6.14-rc1/include/linux/i2c.h	2005-09-13 22:05:32.000000000 +0200
@@ -230,11 +230,6 @@
 	struct device dev;		/* the adapter device */
 	struct class_device class_dev;	/* the class device */
 
-#ifdef CONFIG_PROC_FS 
-	/* No need to set this when you initialize the adapter          */
-	int inode;
-#endif /* def CONFIG_PROC_FS */
-
 	int nr;
 	struct list_head clients;
 	struct list_head list;



-- 
Jean Delvare

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130321AbQLKA2I>; Sun, 10 Dec 2000 19:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130560AbQLKA16>; Sun, 10 Dec 2000 19:27:58 -0500
Received: from rmx470-mta.mail.com ([165.251.48.48]:47025 "EHLO
	rmx470-mta.mail.com") by vger.kernel.org with ESMTP
	id <S130321AbQLKA1s>; Sun, 10 Dec 2000 19:27:48 -0500
Message-ID: <386943387.976492639239.JavaMail.root@web395-wra.mail.com>
Date: Sun, 10 Dec 2000 18:57:18 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: torvalds@transmeta.com
Subject: [PATCH]test12-pre8 i2o_lan.c
CC: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.242.214
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   I just downloaded test12-pre8 from ftp.kernel.org and received the following error, as I did in the old test12-pre8. The following error appears to fix the problem.
Regards,
Frank

i2o_lan.c:116: warning: initialization makes integer from pointer
   without a cast
   i2o_lan.c:1404: structure has no member named 'next'
   make[2]: *** [i2o_lan.o] Error 1
   make[2]: *** Leaving directory '/usr/src/linux/drivers/i2o

--- drivers/i2o/i2o_lan.c.old	Sun Dec 10 18:02:22 2000
+++ drivers/i2o/i2o_lan.c	Sun Dec 10 18:35:01 2000
@@ -1401,7 +1401,7 @@
 	atomic_set(&priv->tx_out, 0);
 	priv->tx_count = 0;
 
-	priv->i2o_batch_send_task.next    = NULL;
+	INIT_LIST_HEAD(&priv->i2o_batch_send_task.list);
 	priv->i2o_batch_send_task.sync    = 0;
 	priv->i2o_batch_send_task.routine = (void *)i2o_lan_batch_send;
 	priv->i2o_batch_send_task.data    = (void *)dev;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

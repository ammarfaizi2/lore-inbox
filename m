Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbTIIXKB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265019AbTIIXKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:10:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:11946 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265007AbTIIXJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:09:56 -0400
Date: Tue, 9 Sep 2003 16:09:26 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Philip.Blundell@pobox.com, Frodo Looijaard <frodol@dds.nl>,
       Philip Edelbrock <phil@netroedge.com>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] video/saa5249.c, video/tuner-3036.c get rid of MOD_INC/DEC
Message-Id: <20030909160926.09c5fa69.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of MOD_INC/DEC since ref count comes from owner field on I2C
for these drivers.

Not sure who is maintaining these, maybe no one because they haven't been
purged of MOD stuff  yet.

diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Tue Sep  9 16:04:52 2003
+++ b/drivers/media/video/saa5249.c	Tue Sep  9 16:04:52 2003
@@ -214,7 +214,6 @@
 	}
 	t->client = client;
 	i2c_attach_client(client);
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -237,7 +236,6 @@
 	kfree(vd->priv);
 	kfree(vd);
 	kfree(client);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
diff -Nru a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
--- a/drivers/media/video/tuner-3036.c	Tue Sep  9 16:04:52 2003
+++ b/drivers/media/video/tuner-3036.c	Tue Sep  9 16:04:52 2003
@@ -135,7 +135,6 @@
 	printk("tuner: SAB3036 found, status %02x\n", tuner_getstatus(client));
 
         i2c_attach_client(client);
-	MOD_INC_USE_COUNT;
 
 	if (i2c_master_send(client, buffer, 2) != 2)
 		printk("tuner: i2c i/o error 1\n");
@@ -149,7 +148,6 @@
 static int 
 tuner_detach(struct i2c_client *c)
 {
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 

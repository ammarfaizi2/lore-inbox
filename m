Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUAKPI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 10:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUAKPIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 10:08:25 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:23822 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S265900AbUAKPIX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 10:08:23 -0500
Date: Sun, 11 Jan 2004 16:10:15 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, third wave (6/8)
Message-Id: <20040111161015.06588cb5.khali@linux-fr.org>
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two old, unused functions from i2c-proc, left over from linux 2.2
times.

Original patch by Kyösti Mälkki. Original comment follows:
***
Drop 2.2 code.
***

--- linux-2.4.25-pre4-k5/drivers/i2c/i2c-proc.c	Sat Jan 10 20:27:50 2004
+++ linux-2.4.25-pre4-k6/drivers/i2c/i2c-proc.c	Sun Jan 11 11:50:01 2004
@@ -213,49 +213,6 @@
 	}
 }
 
-/* Monitor access for /proc/sys/dev/sensors; make unloading i2c-proc.o 
-   impossible if some process still uses it or some file in it */
-void i2c_fill_inode(struct inode *inode, int fill)
-{
-	if (fill)
-		MOD_INC_USE_COUNT;
-	else
-		MOD_DEC_USE_COUNT;
-}
-
-/* Monitor access for /proc/sys/dev/sensors/ directories; make unloading
-   the corresponding module impossible if some process still uses it or
-   some file in it */
-void i2c_dir_fill_inode(struct inode *inode, int fill)
-{
-	int i;
-	struct i2c_client *client;
-
-#ifdef DEBUG
-	if (!inode) {
-		printk("i2c-proc.o: Warning: inode NULL in fill_inode()\n");
-		return;
-	}
-#endif				/* def DEBUG */
-
-	for (i = 0; i < SENSORS_ENTRY_MAX; i++)
-		if (i2c_clients[i]
-		    && (i2c_inodes[i] == inode->i_ino)) break;
-#ifdef DEBUG
-	if (i == SENSORS_ENTRY_MAX) {
-		printk
-		    ("i2c-proc.o: Warning: inode (%ld) not found in fill_inode()\n",
-		     inode->i_ino);
-		return;
-	}
-#endif				/* def DEBUG */
-	client = i2c_clients[i];
-	if (fill)
-		client->driver->inc_use(client);
-	else
-		client->driver->dec_use(client);
-}
-
 int i2c_proc_chips(ctl_table * ctl, int write, struct file *filp,
 		       void *buffer, size_t * lenp)
 {


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268683AbUILLcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268683AbUILLcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268689AbUILL3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:29:31 -0400
Received: from aun.it.uu.se ([130.238.12.36]:13564 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268669AbUILLZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:25:42 -0400
Date: Sun, 12 Sep 2004 13:25:30 +0200 (MEST)
Message-Id: <200409121125.i8CBPUNI015192@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: khali@linux-fr.org, marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] I2C driver core gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel's I2C driver core. The i2c-core.c change is from the 2.6 kernel,
the i2c-proc.c changes are new since the 2.6 code is different.

/Mikael

--- linux-2.4.28-pre3/drivers/i2c/i2c-core.c.~1~	2004-02-18 15:16:22.000000000 +0100
+++ linux-2.4.28-pre3/drivers/i2c/i2c-core.c	2004-09-12 01:56:20.000000000 +0200
@@ -750,7 +750,7 @@
 		msg.addr   = client->addr;
 		msg.flags = client->flags & I2C_M_TEN;
 		msg.len = count;
-		(const char *)msg.buf = buf;
+		msg.buf = (char *)buf;
 	
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
 			count,client->adapter->name));
--- linux-2.4.28-pre3/drivers/i2c/i2c-proc.c.~1~	2004-02-18 15:16:22.000000000 +0100
+++ linux-2.4.28-pre3/drivers/i2c/i2c-proc.c	2004-09-12 01:56:20.000000000 +0200
@@ -205,7 +205,7 @@
 		table = i2c_entries[id]->ctl_table;
 		unregister_sysctl_table(i2c_entries[id]);
 		/* 2-step kfree needed to keep gcc happy about const points */
-		(const char *) temp = table[4].procname;
+		temp = (char *) table[4].procname;
 		kfree(temp);
 		kfree(table);
 		i2c_entries[id] = NULL;
@@ -287,7 +287,7 @@
 			if(copy_to_user(buffer, BUF, buflen))
 				return -EFAULT;
 			curbufsize += buflen;
-			(char *) buffer += buflen;
+			buffer += buflen;
 		}
 	*lenp = curbufsize;
 	filp->f_pos += curbufsize;
@@ -318,7 +318,7 @@
 					     sizeof(struct
 						    i2c_chips_data)))
 					return -EFAULT;
-				(char *) oldval +=
+				oldval +=
 				    sizeof(struct i2c_chips_data);
 				nrels++;
 			}
@@ -473,7 +473,7 @@
 		       !((ret=get_user(nextchar, (char *) buffer))) &&
 		       isspace((int) nextchar)) {
 			bufsize--;
-			((char *) buffer)++;
+			buffer++;
 		}
 
 		if (ret)
@@ -492,7 +492,7 @@
 		    && (nextchar == '-')) {
 			min = 1;
 			bufsize--;
-			((char *) buffer)++;
+			buffer++;
 		}
 		if (ret)
 			return -EFAULT;
@@ -503,7 +503,7 @@
 		       isdigit((int) nextchar)) {
 			res = res * 10 + nextchar - '0';
 			bufsize--;
-			((char *) buffer)++;
+			buffer++;
 		}
 		if (ret)
 			return -EFAULT;
@@ -517,7 +517,7 @@
 		if (bufsize && (nextchar == '.')) {
 			/* Skip the dot */
 			bufsize--;
-			((char *) buffer)++;
+			buffer++;
 
 			/* Read digits while they are significant */
 			while (bufsize && (mag > 0) &&
@@ -526,7 +526,7 @@
 				res = res * 10 + nextchar - '0';
 				mag--;
 				bufsize--;
-				((char *) buffer)++;
+				buffer++;
 			}
 			if (ret)
 				return -EFAULT;
@@ -542,7 +542,7 @@
 		       !((ret=get_user(nextchar, (char *) buffer))) &&
 		       isspace((int) nextchar)) {
 			bufsize--;
-			((char *) buffer)++;
+			buffer++;
 		}
 		if (ret)
 			return -EFAULT;
@@ -574,7 +574,7 @@
 			if(put_user(' ', (char *) buffer))
 				return -EFAULT;
 			curbufsize++;
-			((char *) buffer)++;
+			buffer++;
 		}
 
 		/* Fill BUF with the representation of the next string */
@@ -615,7 +615,7 @@
 		if(copy_to_user(buffer, BUF, buflen))
 			return -EFAULT;
 		curbufsize += buflen;
-		(char *) buffer += buflen;
+		buffer += buflen;
 
 		nr++;
 	}

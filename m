Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265869AbUAKN6K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUAKN6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:58:09 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:33290 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S265869AbUAKN5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:57:25 -0500
Date: Sun, 11 Jan 2004 14:59:17 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, third wave (2/8)
Message-Id: <20040111145917.0f29a79f.khali@linux-fr.org>
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove old debugging stuff ("SLO_IO") from two algorithms
(i2c-algo-bit and i2c-algo-ite). This is unused and wouldn't even
compile if commented out.

A similar patch was sent to Greg KH for linux 2.6 and was applied in
2.6.1-rc1.

Note that this patch was voluntarily generated using diff -U2, because
it contains only removals, so much context isn't required.


diff -U2 -rN linux-2.4.24-pre3/drivers/i2c/i2c-algo-bit.c linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-bit.c
--- linux-2.4.24-pre3/drivers/i2c/i2c-algo-bit.c	2003-12-31 14:50:59.000000000 +0100
+++ linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-bit.c	2004-01-05 09:44:26.000000000 +0100
@@ -44,20 +44,7 @@
  	/* debug the protocol by showing transferred bits */
 
-/* debugging - slow down transfer to have a look at the data .. 	*/
-/* I use this with two leds&resistors, each one connected to sda,scl 	*/
-/* respectively. This makes sure that the algorithm works. Some chips   */
-/* might not like this, as they have an internal timeout of some mils	*/
-/*
-#define SLO_IO      jif=jiffies;while(time_before_eq(jiffies, jif+i2c_table[minor].veryslow))\
-                        if (need_resched) schedule();
-*/
-
 
 /* ----- global variables ---------------------------------------------	*/
 
-#ifdef SLO_IO
-	int jif;
-#endif
-
 /* module parameters:
  */
@@ -89,7 +76,4 @@
 	setscl(adap,0);
 	udelay(adap->udelay);
-#ifdef SLO_IO
-	SLO_IO
-#endif
 }
 
@@ -124,7 +108,4 @@
 	}
 	DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
-#ifdef SLO_IO
-	SLO_IO
-#endif
 	return 0;
 } 
diff -U2 -rN linux-2.4.24-pre3/drivers/i2c/i2c-algo-ite.c linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-ite.c
--- linux-2.4.24-pre3/drivers/i2c/i2c-algo-ite.c	2003-12-31 14:50:59.000000000 +0100
+++ linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-ite.c	2004-01-05 09:43:53.000000000 +0100
@@ -61,20 +61,7 @@
 #define DEF_TIMEOUT 16
 
-/* debugging - slow down transfer to have a look at the data .. 	*/
-/* I use this with two leds&resistors, each one connected to sda,scl 	*/
-/* respectively. This makes sure that the algorithm works. Some chips   */
-/* might not like this, as they have an internal timeout of some mils	*/
-/*
-#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
-                        if (need_resched) schedule();
-*/
-
 
 /* ----- global variables ---------------------------------------------	*/
 
-#ifdef SLO_IO
-	int jif;
-#endif
-
 /* module parameters:
  */

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317975AbSGRDB3>; Wed, 17 Jul 2002 23:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317976AbSGRDB3>; Wed, 17 Jul 2002 23:01:29 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:8576 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S317975AbSGRDB2>; Wed, 17 Jul 2002 23:01:28 -0400
Message-ID: <3D363035.E4C0CFB1@bellsouth.net>
Date: Wed, 17 Jul 2002 23:04:21 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.26 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.26 i2c tweeks
Content-Type: multipart/mixed;
 boundary="------------56D7EECA2EEB172E62B2BFF9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------56D7EECA2EEB172E62B2BFF9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Linus,
Reading your latest message with 2.5.26 I see your buried
upto your neck with changes.
Could you please apply these two patches to I2C for
i2c-id.h updates and a compatability issue in
i2c-algo-bit.c

Thanks,
Albert

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------56D7EECA2EEB172E62B2BFF9
Content-Type: text/plain; charset=us-ascii;
 name="47-i2c-5-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="47-i2c-5-patch"

# i2c-algo-bit.c: Added KERNEL_VERSION check around if (current->need_resched) schedule(); and cond_sched();
--- linux/drivers/i2c/i2c-algo-bit.c.orig	2002-07-05 13:08:27.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-bit.c	2002-07-05 13:09:58.000000000 -0400
@@ -119,7 +119,12 @@
 		if (time_after_eq(jiffies, start+adap->timeout)) {
 			return -ETIMEDOUT;
 		}
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+ 		if (current->need_resched)
+ 			schedule();
+#else
 		cond_resched();
+#endif
 	}
 	DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
 #ifdef SLO_IO

--------------56D7EECA2EEB172E62B2BFF9
Content-Type: text/plain; charset=us-ascii;
 name="47-i2c-7-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="47-i2c-7-patch"

--- linux/include/linux/i2c-id.h.orig	2002-07-10 19:12:15.000000000 -0400
+++ linux/include/linux/i2c-id.h	2002-07-10 19:13:42.000000000 -0400
@@ -90,7 +90,11 @@
 #define I2C_DRIVERID_DRP3510	43     /* ADR decoder (Astra Radio)	*/
 #define I2C_DRIVERID_SP5055	44     /* Satellite tuner		*/
 #define I2C_DRIVERID_STV0030	45     /* Multipurpose switch		*/
-#define I2C_DRIVERID_SAA7108    46     /* video decoder, image scaler   */
+#define I2C_DRIVERID_SAA7108	46     /* video decoder, image scaler   */
+#define I2C_DRIVERID_DS1307	47     /* DS1307 real time clock	*/
+#define I2C_DRIVERID_ADV717x	48     /* ADV 7175/7176 video encoder	*/
+#define I2C_DRIVERID_ZR36067	49     /* Zoran 36067 video encoder	*/
+#define I2C_DRIVERID_ZR36120	50     /* Zoran 36120 video encoder	*/
 
 
 

--------------56D7EECA2EEB172E62B2BFF9--


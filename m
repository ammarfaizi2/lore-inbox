Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbUKIFy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUKIFy6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUKIFxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:53:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:5791 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261393AbUKIFZD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:25:03 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778573332@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:17 -0800
Message-Id: <1099977857196@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.19, 2004/11/08 16:38:32-08:00, greg@kroah.com

I2C: delete normal_i2c_range logic from sensors as there are no more users.


 drivers/i2c/i2c-sensor-detect.c |   12 +-----------
 include/linux/i2c-sensor.h      |    6 ------
 2 files changed, 1 insertion(+), 17 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor-detect.c b/drivers/i2c/i2c-sensor-detect.c
--- a/drivers/i2c/i2c-sensor-detect.c	2004-11-08 18:54:49 -08:00
+++ b/drivers/i2c/i2c-sensor-detect.c	2004-11-08 18:54:49 -08:00
@@ -45,7 +45,6 @@
 	int adapter_id =
 	    is_isa ? ANY_I2C_ISA_BUS : i2c_adapter_id(adapter);
 	unsigned short *normal_i2c;
-	unsigned short *normal_i2c_range;
 	unsigned int *normal_isa;
 	unsigned short *probe;
 	unsigned short *ignore;
@@ -56,12 +55,10 @@
 		return -1;
 	
 	/* Use default "empty" list if the adapter doesn't specify any */
-	normal_i2c = normal_i2c_range = probe = ignore = empty;
+	normal_i2c = probe = ignore = empty;
 	normal_isa = empty_isa;
 	if (address_data->normal_i2c)
 		normal_i2c = address_data->normal_i2c;
-	if (address_data->normal_i2c_range)
-		normal_i2c_range = address_data->normal_i2c_range;
 	if (address_data->normal_isa)
 		normal_isa = address_data->normal_isa;
 	if (address_data->probe)
@@ -119,13 +116,6 @@
 				if (addr == normal_i2c[i]) {
 					found = 1;
 					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x", adapter_id, addr);
-				}
-			}
-			for (i = 0; !found && (normal_i2c_range[i] != I2C_CLIENT_END); i += 2) {
-				if ((addr >= normal_i2c_range[i]) &&
-				    (addr <= normal_i2c_range[i + 1])) {
-					dev_dbg(&adapter->dev, "found normal i2c_range entry for adapter %d, addr %04x\n", adapter_id, addr);
-					found = 1;
 				}
 			}
 		}
diff -Nru a/include/linux/i2c-sensor.h b/include/linux/i2c-sensor.h
--- a/include/linux/i2c-sensor.h	2004-11-08 18:54:49 -08:00
+++ b/include/linux/i2c-sensor.h	2004-11-08 18:54:49 -08:00
@@ -42,10 +42,6 @@
 /* A structure containing the detect information.
    normal_i2c: filled in by the module writer. Terminated by I2C_CLIENT_ISA_END.
      A list of I2C addresses which should normally be examined.
-   normal_i2c_range: filled in by the module writer. Terminated by 
-     I2C_CLIENT_ISA_END
-     A list of pairs of I2C addresses, each pair being an inclusive range of
-     addresses which should normally be examined.
    normal_isa: filled in by the module writer. Terminated by SENSORS_ISA_END.
      A list of ISA addresses which should normally be examined.
    probe: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END values.
@@ -62,7 +58,6 @@
 */
 struct i2c_address_data {
 	unsigned short *normal_i2c;
-	unsigned short *normal_i2c_range;
 	unsigned int *normal_isa;
 	unsigned short *probe;
 	unsigned short *ignore;
@@ -83,7 +78,6 @@
                       "List of adapter,address pairs not to scan"); \
 	static struct i2c_address_data addr_data = {			\
 			.normal_i2c =		normal_i2c,		\
-			.normal_i2c_range =	normal_i2c_range,	\
 			.normal_isa =		normal_isa,		\
 			.probe =		probe,			\
 			.ignore =		ignore,			\


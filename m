Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269823AbTGKIUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 04:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269828AbTGKIT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 04:19:59 -0400
Received: from c180224.adsl.hansenet.de ([213.39.180.224]:49846 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S269823AbTGKISv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 04:18:51 -0400
Message-ID: <3F0E7659.8000503@portrix.net>
Date: Fri, 11 Jul 2003 10:33:29 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Convert w83781d i2c chip driver to milli Celsius
Content-Type: multipart/mixed;
 boundary="------------040701000803000401020403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040701000803000401020403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Convert w83781d i2c chip driver to milli Celsius.
Tested on MSI nForce2 Mainboard.

Jan

-- 
Linux rubicon 2.5.74-mm3-jd2 #1 SMP Wed Jul 9 09:38:20 CEST 2003 i686

--------------040701000803000401020403
Content-Type: text/plain;
 name="i2c.w83781d.temp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c.w83781d.temp"

--- linux-mm/drivers/i2c/chips/w83781d.c	2003-07-03 15:17:37.000000000 +0200
+++ 2.5.73-mm3/drivers/i2c/chips/w83781d.c	2003-07-10 13:43:49.000000000 +0200
@@ -496,13 +496,13 @@
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		if (data->type == as99127f) { \
 			return sprintf(buf,"%ld\n", \
-				(long)AS99127_TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
+				(long)AS99127_TEMP_ADD_FROM_REG(data->reg##_add[nr-2])*10); \
 		} else { \
 			return sprintf(buf,"%ld\n", \
-				(long)TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
+				(long)TEMP_ADD_FROM_REG(data->reg##_add[nr-2])*10); \
 		} \
 	} else {	/* TEMP1 */ \
-		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
+		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)*10); \
 	} \
 }
 show_temp_reg(temp);
@@ -516,7 +516,7 @@
 	struct w83781d_data *data = i2c_get_clientdata(client); \
 	u32 val; \
 	 \
-	val = simple_strtoul(buf, NULL, 10); \
+	val = simple_strtoul(buf, NULL, 10)/10; \
 	 \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
 		if (data->type == as99127f) \

--------------040701000803000401020403--


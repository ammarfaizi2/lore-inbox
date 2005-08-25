Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVHYQni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVHYQni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVHYQni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:43:38 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:42765 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932307AbVHYQni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:43:38 -0400
Date: Thu, 25 Aug 2005 18:43:37 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>, Stefan Ott <stefan@desire.ch>,
       Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] hwmon: Off-by-one error in fscpos driver
Message-Id: <20050825184337.5eafe364.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, all,

Coverity uncovered an off-by-one error in the fscpos driver, in function
set_temp_reset(). Writing to the temp3_reset sysfs file will lead to an
array overrun, in turn causing an I2C write to a random register of the
FSC Poseidon chip. Additionally, writing to temp1_reset and temp2_reset
will not work as expected. The fix is straightforward.

This patch is a candidate for 2.6.13 (or 2.6.13.1 if it's too late for
2.6.13.)

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/fscpos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13-rc7.orig/drivers/hwmon/fscpos.c	2005-08-25 18:21:37.000000000 +0200
+++ linux-2.6.13-rc7/drivers/hwmon/fscpos.c	2005-08-25 18:22:09.000000000 +0200
@@ -167,7 +167,7 @@
 				"experience to the module author.\n");
 
 	/* Supported value: 2 (clears the status) */
-	fscpos_write_value(client, FSCPOS_REG_TEMP_STATE[nr], 2);
+	fscpos_write_value(client, FSCPOS_REG_TEMP_STATE[nr - 1], 2);
 	return count;
 }
 

-- 
Jean Delvare

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319108AbSHMVNd>; Tue, 13 Aug 2002 17:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319109AbSHMVNd>; Tue, 13 Aug 2002 17:13:33 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:44493 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S319108AbSHMVNc>; Tue, 13 Aug 2002 17:13:32 -0400
Date: Tue, 13 Aug 2002 16:20:50 -0400
From: Tom Miller <bsdwiz@optonline.net>
Subject: [PATCH] IBMMCA 2.5.31
To: linux-kernel@vger.kernel.org
Cc: langa2@kph.uni-mainz.de
Message-id: <0H0S00J0GU1MOY@mta4.srv.hcvlny.cv.net>
Organization: Trinitor
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very trivial patch, it fixes the two remaining strtok()'s in the Kernel!  I have CC:'d to the maintainer of this driver. 
I don't use this driver, so despite this patch's simplicity, please provide test info, and if i did everything right. 

Thanks,
Tom
-----------------------------------------

--- /usr/src/linux-2.5.31/drivers/scsi/ibmmca.c Sat Aug 10 21:41:20 2002
+++ /usr/src/linux/drivers/scsi/ibmmca.c        Mon Aug 12 23:34:30 2002
@@ -1406,7 +1406,7 @@
    io_base = 0;
    id_base = 0;
    if (str) {
-      token = strtok(str,",");
+      token = strsep(str,",");
       j = 0;
       while (token) {
         if (!strcmp(token,"activity")) display_mode |= LED_ACTIVITY;
@@ -1424,7 +1424,7 @@
              scsi_id[id_base++] = simple_strtoul(token,NULL,0);
            j++;
         }
-        token = strtok(NULL,",");
+        token = strsep(NULL,",");
       }
    } else if (ints) {
       for (i = 0; i < IM_MAX_HOSTS && 2*i+2 < ints[0]; i++) {



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVCBLPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVCBLPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 06:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVCBLPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 06:15:03 -0500
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:42201 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262264AbVCBLO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 06:14:56 -0500
Message-ID: <42259F3A.8000206@mech.kuleuven.ac.be>
Date: Wed, 02 Mar 2005 12:10:50 +0100
From: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] raw1394 missing failure handling
Content-Type: multipart/mixed;
 boundary="------------010902030901040405060308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010902030901040405060308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In the raw1394 driver the failure handling for
a __copy_to_user call is missing.

With friendly regards,
Takis

-- 
  K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
  http://people.mech.kuleuven.ac.be/~pissaris/


--------------010902030901040405060308
Content-Type: text/x-patch;
 name="pi-20050302T114855-linux_2_6_11-raw1394_copy_to_user_failure_handling.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pi-20050302T114855-linux_2_6_11-raw1394_copy_to_user_failure_handling.diff"

diff -pruN linux-2.6.11/drivers/ieee1394/raw1394.c linux-2.6.11-pi/drivers/ieee1394/raw1394.c
--- linux-2.6.11/drivers/ieee1394/raw1394.c	2005-03-02 11:44:26.000000000 +0100
+++ linux-2.6.11-pi/drivers/ieee1394/raw1394.c	2005-03-02 11:47:38.000000000 +0100
@@ -443,7 +443,8 @@ static ssize_t raw1394_read(struct file 
                         req->req.error = RAW1394_ERROR_MEMFAULT;
                 }
         }
-        __copy_to_user(buffer, &req->req, sizeof(req->req));
+        if (__copy_to_user(buffer, &req->req, sizeof(req->req)))
+                return -EFAULT;
 
         free_pending_request(req);
         return sizeof(struct raw1394_request);

--------------010902030901040405060308--

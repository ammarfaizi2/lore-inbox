Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbTCTHaY>; Thu, 20 Mar 2003 02:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263217AbTCTHaY>; Thu, 20 Mar 2003 02:30:24 -0500
Received: from franka.aracnet.com ([216.99.193.44]:53209 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263212AbTCTHaX>; Thu, 20 Mar 2003 02:30:23 -0500
Date: Wed, 19 Mar 2003 23:41:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove warning for 3c509.c
Message-ID: <13950000.1048146080@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get this compile warning:
drivers/net/3c509.c:207: warning: `el3_device_remove' declared `static' but never defined
because the function definition is under 
"#if defined(CONFIG_EISA) || defined(CONFIG_MCA)".

This patch puts the declaration under the same conditions. 
I'd be shocked if it wasn't correct ;-)

M.

diff -urpN -X /home/fletch/.diff.exclude virgin/drivers/net/3c509.c 3c509_fix/drivers/net/3c509.c
--- virgin/drivers/net/3c509.c	Wed Mar  5 07:37:01 2003
+++ 3c509_fix/drivers/net/3c509.c	Wed Mar 19 23:35:44 2003
@@ -204,7 +204,9 @@ static int el3_resume(struct pm_dev *pde
 static int el3_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data);
 #endif
 /* generic device remove for all device types */
+#if defined(CONFIG_EISA) || defined(CONFIG_MCA)
 static int el3_device_remove (struct device *device);
+#endif
 
 #ifdef CONFIG_EISA
 struct eisa_device_id el3_eisa_ids[] = {


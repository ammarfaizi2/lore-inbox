Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267626AbUHJSQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267626AbUHJSQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267640AbUHJSIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:08:37 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:29692 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S267528AbUHJSGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:06:17 -0400
Message-ID: <41190E94.40100@us.ibm.com>
Date: Tue, 10 Aug 2004 13:06:12 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] ibmveth bug fixes 3/4
Content-Type: multipart/mixed;
 boundary="------------040200010700000100000709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040200010700000100000709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

This patch checks for the LongBusy return code from the hypervisor, and 
retries the operation (which is what the hypervisor expects the driver 
to do). Please apply.

Signed-off-by: Santiago Leon <santil@us.ibm.com>

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

--------------040200010700000100000709
Content-Type: text/plain;
 name="ibmveth_longbusy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibmveth_longbusy.patch"

===== drivers/net/ibmveth.c 1.15 vs edited =====
--- 1.15/drivers/net/ibmveth.c	Tue Aug 10 11:59:07 2004
+++ edited/drivers/net/ibmveth.c	Tue Aug 10 11:59:49 2004
@@ -530,7 +530,7 @@
 		ibmveth_error_printk("unable to request irq 0x%x, rc %d\n", netdev->irq, rc);
 		do {
 			rc = h_free_logical_lan(adapter->vdev->unit_address);
-		} while H_isLongBusy(rc);
+		} while (H_isLongBusy(rc) || (rc == H_Busy));
 
 		ibmveth_cleanup(adapter);
 		return rc;
@@ -562,7 +562,7 @@
 
 	do {
 		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-	} while H_isLongBusy(lpar_rc);
+	} while (H_isLongBusy(lpar_rc) || (lpar_rc == H_Busy));
 
 	if(lpar_rc != H_Success)
 	{

--------------040200010700000100000709--

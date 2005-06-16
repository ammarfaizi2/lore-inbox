Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVFPUUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVFPUUT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVFPUUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:20:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:34809 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261802AbVFPUUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:20:09 -0400
Subject: [patch][1/4] ibmasm driver: fix command buffer size
From: Max Asbock <masbock@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Vernon Mauery <vernux@us.ibm.com>
Content-Type: text/plain
Message-Id: <1118953205.8372.76.camel@w-amax>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 16 Jun 2005 13:20:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
here are four patches for the ibmasm driver.
(that is the driver for the IBM xSeries RSA service processor)
The patches are against the 2.6.16-rc6 kernel. 

To summarize what they do:
[1] change a #define for the buffer size for commands
[2] Fix a bug where threads in the event handling code calling
wait_event_interruptible() weren't woken up as expected.
[3] Redesigned how remote mouse and keyboard events received by the
driver are handled. 
[4] Fixed a race in the command reference counting logic.

Please apply.

Here is the first one:

Signed-off-by: Max Asbock <masbock@us.ibm.com>


diff -urN linux-2.6.12-rc6/drivers/misc/ibmasm/ibmasm.h linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/ibmasm.h
--- linux-2.6.12-rc6/drivers/misc/ibmasm/ibmasm.h	2005-03-01 23:37:48.000000000 -0800
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/ibmasm.h	2005-06-08 17:54:09.534984912 -0700
@@ -52,7 +52,7 @@
 #define IBMASM_CMD_TIMEOUT_NORMAL	45
 #define IBMASM_CMD_TIMEOUT_EXTRA	240
 
-#define IBMASM_CMD_MAX_BUFFER_SIZE	0x4000
+#define IBMASM_CMD_MAX_BUFFER_SIZE	0x8000
 
 #define REVERSE_HEARTBEAT_TIMEOUT	120
 




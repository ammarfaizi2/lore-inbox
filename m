Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVGVVsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVGVVsU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVGVVsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:48:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43530 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262206AbVGVVsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:48:04 -0400
Date: Fri, 22 Jul 2005 23:47:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/ieee1394/sbp2.c: fix warnings with -Wundef
Message-ID: <20050722214756.GY3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warnings with -Wundef:

<--  snip  -->

...
  CC      drivers/ieee1394/sbp2.o
drivers/ieee1394/sbp2.c:202:5: warning: "CONFIG_IEEE1394_SBP2_DEBUG" is not defined
drivers/ieee1394/sbp2.c:207:7: warning: "CONFIG_IEEE1394_SBP2_DEBUG" is not defined
drivers/ieee1394/sbp2.c:2053:6: warning: "CONFIG_IEEE1394_SBP2_DEBUG" is not defined
drivers/ieee1394/sbp2.c:2623:5: warning: "CONFIG_IEEE1394_SBP2_DEBUG" is not defined
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/drivers/ieee1394/sbp2.c.old	2005-07-22 18:19:38.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/ieee1394/sbp2.c	2005-07-22 18:20:32.000000000 +0200
@@ -171,10 +171,11 @@
 
 /* #define CONFIG_IEEE1394_SBP2_DEBUG_ORBS */
 /* #define CONFIG_IEEE1394_SBP2_DEBUG_DMA */
-/* #define CONFIG_IEEE1394_SBP2_DEBUG 1 */
-/* #define CONFIG_IEEE1394_SBP2_DEBUG 2 */
 /* #define CONFIG_IEEE1394_SBP2_PACKET_DUMP */
 
+/* CONFIG_IEEE1394_SBP2_DEBUG: 0-2 */
+#define CONFIG_IEEE1394_SBP2_DEBUG 0
+
 #ifdef CONFIG_IEEE1394_SBP2_DEBUG_ORBS
 #define SBP2_ORB_DEBUG(fmt, args...)	HPSB_ERR("sbp2(%s): "fmt, __FUNCTION__, ## args)
 static u32 global_outstanding_command_orbs = 0;


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVGWVIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVGWVIY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 17:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVGWVIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 17:08:24 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:1723 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S261683AbVGWVIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 17:08:23 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-Id: <200507232107.j6NL79OO012064@einhorn.in-berlin.de>
Date: Sat, 23 Jul 2005 23:07:08 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [2.6 patch] drivers/ieee1394/sbp2.c: fix warnings with -Wundef
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
cc: Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20050722214756.GY3160@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
X-Spam-Score: (-0.654) AWL,BAYES_00,MSGID_FROM_MTA_ID,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jul, Adrian Bunk wrote:
> drivers/ieee1394/sbp2.c:202:5: warning: "CONFIG_IEEE1394_SBP2_DEBUG" is not defined
> drivers/ieee1394/sbp2.c:207:7: warning: "CONFIG_IEEE1394_SBP2_DEBUG" is not defined
> drivers/ieee1394/sbp2.c:2053:6: warning: "CONFIG_IEEE1394_SBP2_DEBUG" is not defined
> drivers/ieee1394/sbp2.c:2623:5: warning: "CONFIG_IEEE1394_SBP2_DEBUG" is not defined

Here is a minimally improved version of the patch. I kept your sign-off.

- - - - - - - - - - - - 8< - - - - - - - - - - - -


sbp2: fix compiler warnings with -Wundef

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux-2.6.13-rc3/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.13-rc3/drivers/ieee1394/sbp2.c	(revision 1316)
+++ linux-2.6.13-rc3/drivers/ieee1394/sbp2.c	(working copy)
@@ -171,10 +171,12 @@
 
 /* #define CONFIG_IEEE1394_SBP2_DEBUG_ORBS */
 /* #define CONFIG_IEEE1394_SBP2_DEBUG_DMA */
-/* #define CONFIG_IEEE1394_SBP2_DEBUG 1 */
-/* #define CONFIG_IEEE1394_SBP2_DEBUG 2 */
 /* #define CONFIG_IEEE1394_SBP2_PACKET_DUMP */
 
+/* increase to 1 for verbose logging, to 2 for even more logging */
+#define CONFIG_IEEE1394_SBP2_DEBUG 0
+
+
 #ifdef CONFIG_IEEE1394_SBP2_DEBUG_ORBS
 #define SBP2_ORB_DEBUG(fmt, args...)	HPSB_ERR("sbp2(%s): "fmt, __FUNCTION__, ## args)
 static u32 global_outstanding_command_orbs = 0;



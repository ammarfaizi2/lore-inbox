Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbTFBSJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbTFBSJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:09:57 -0400
Received: from gw.netgem.com ([195.68.2.34]:63497 "EHLO gw.dev.netgem.com")
	by vger.kernel.org with ESMTP id S264827AbTFBSJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:09:56 -0400
Subject: [PATCH] radeonfb doesn't compile in 2.4.21-rc6
From: Jocelyn Mayer <jma@netgem.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1054578295.4951.34.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 02 Jun 2003 20:24:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to me that this was already reported for previous
2.4.21-rc's, but never applied.
Here's the patch that make radeonfb compile (and work)
on my Ibook:


--- linux-2.4.21-rc6/drivers/video/radeonfb.c     2003-04-11
19:06:04.0000
00000 +0200
+++ linux-2.4.21-rc6-fixed/drivers/video/radeonfb.c    2003-06-01
20:58:42.0000
00000 +0200
@@ -1001,8 +1001,8 @@
        /* According to XFree86 4.2.0, some production M6's return 0
           for 8MB. */
        if (rinfo->video_ram == 0 &&
-           (pdev->device == PCI_DEVICE_ID_RADEON_LY ||
-            pdev->device == PCI_DEVICE_ID_RADEON_LZ)) {
+           (pdev->device == PCI_DEVICE_ID_ATI_RADEON_LY ||
+            pdev->device == PCI_DEVICE_ID_ATI_RADEON_LZ)) {
            rinfo->video_ram = 8192 * 1024;
          }


Linux version 2.4.21-rc6-fixed (jocelyn@(none)) (gcc version 3.2) #3 Sun
Jun 1 21:02:23 CEST 2003

cpu             : 750FX
clock           : 700MHz
revision        : 1.18 (pvr 7000 0112)
bogomips        : 1389.36
machine         : PowerBook4,3
motherboard     : PowerBook4,3 MacRISC2 MacRISC Power Macintosh
detected as     : 257 (iBook 2 rev. 2)
pmac flags      : 0000000b
L2 cache        : 512K unified
memory          : 384MB
pmac-generation : NewWorld

PCI devices found:
  Bus  0, device  11, function  0:
    Host bridge: Apple Computer Inc. UniNorth/Pangea AGP (rev 0).
      Master Capable.  Latency=16.  
  Bus  0, device  16, function  0:
    VGA compatible controller: ATI Technologies Inc Radeon Mobility M6
LY (rev 0).
      IRQ 48.
      Master Capable.  Latency=255.  Min Gnt=8.
      Prefetchable 32 bit memory at 0x98000000 [0x9fffffff].
      I/O at 0x802400 [0x8024ff].
      Non-prefetchable 32 bit memory at 0x90000000 [0x9000ffff].
...

-- 
Jocelyn Mayer <jma@netgem.com>


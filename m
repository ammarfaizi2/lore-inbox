Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268014AbUHPXBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268014AbUHPXBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266451AbUHPXAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:00:44 -0400
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:13967 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S268016AbUHPW6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:58:11 -0400
Date: Mon, 16 Aug 2004 15:57:50 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Fw: [Lhms-devel] Making hotremovable attribute with memory section[3/4]
Cc: mbligh@aracnet.com
Message-Id: <20040816155258.E6FD.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forwarded by Yasunori Goto <ygoto@us.fujitsu.com>
----------------------- Original Message -----------------------
 From:    Yasunori Goto <ygoto@us.fujitsu.com>
 To:      lhms-devel@lists.sourceforge.net
 Date:    Mon, 16 Aug 2004 14:37:05 -0700
 Subject: [Lhms-devel] Making hotremovable attribute with memory section[3/4]
----


This patch is define __GFP_HOTREMOVABLE attribute.
Kernel can select attribute removable/un-removable section and allocate 
the pages by it.

Note:
  The value of __ GFP_HOTREMOVABLE was 0x03 in the definition before.
 This was used to make new hot-removable zone_list for same purpose.
 This zone_list method had the advantage that the number of steps 
 of main routes did not increase. 
  However, all section's removable attributes in a node have to be
 same in this method. So, this is meaningless on SMP machine.
 
 Dividing free_area is to be more general way for localized allocation.

---

 hotremovable-goto/include/linux/gfp.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -puN include/linux/gfp.h~gfp_hotremovable include/linux/gfp.h
--- hotremovable/include/linux/gfp.h~gfp_hotremovable	Fri Aug 13 16:24:38 2004
+++ hotremovable-goto/include/linux/gfp.h	Fri Aug 13 16:24:38 2004
@@ -14,7 +14,6 @@ struct vm_area_struct;
 /* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low two bits) */
 #define __GFP_DMA	0x01
 #define __GFP_HIGHMEM	0x02
-
 /*
  * Action modifiers - doesn't change the zoning
  *
@@ -38,6 +37,12 @@ struct vm_area_struct;
 #define __GFP_NO_GROW	0x2000	/* Slab internal usage */
 #define __GFP_COMP	0x4000	/* Add compound page metadata */
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#define __GFP_HOTREMOVABLE 0x8000 /* off: Un-hotremovable, on:Hotremovable */
+#else
+#define __GFP_HOTREMOVABLE 0
+#endif
+
 #define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
@@ -51,7 +56,7 @@ struct vm_area_struct;
 #define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
 #define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM | __GFP_HOTREMOVABLE)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
_

-- 
Yasunori Goto <ygoto at us.fujitsu.com>




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Lhms-devel mailing list
Lhms-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/lhms-devel

--------------------- Original Message Ends --------------------

-- 
Yasunori Goto <ygoto at us.fujitsu.com>



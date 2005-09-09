Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbVIIFe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbVIIFe2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 01:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbVIIFe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 01:34:28 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:5853 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965260AbVIIFe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 01:34:28 -0400
Message-ID: <43211EBD.9080405@jp.fujitsu.com>
Date: Fri, 09 Sep 2005 14:33:49 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [2.6.13-mm2] i386-sparsemem-compile-with-DMA32
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because 2.6.13-mm2  adds new zone DMA32, ZONES_SHIFT becomes 3.
So, flags bits reserved for (SECTION | NODE | ZONE) should be increase.

-- Kame
==
ZONE_SHIFT is increased, FLAGS_RESERVED should be.

Signed-off-by Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.13-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.13-mm2.orig/include/linux/mmzone.h
+++ linux-2.6.13-mm2/include/linux/mmzone.h
@@ -458,10 +458,11 @@ extern struct pglist_data contig_page_da
  #if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
  /*
   * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
- * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
+ * there are 4 zones (3 bits) and this leaves 8-2=6 bits for nodes.
+ * +6bits for sections if CONFIG_SPARSEMEM
   */

-#define FLAGS_RESERVED		8
+#define FLAGS_RESERVED		9

  #elif BITS_PER_LONG == 64
  /*


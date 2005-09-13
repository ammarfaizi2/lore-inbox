Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVIMKQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVIMKQQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 06:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVIMKQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 06:16:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12228 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbVIMKQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 06:16:15 -0400
Date: Tue, 13 Sep 2005 03:15:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [1/3] Add 4GB DMA32 zone
Message-Id: <20050913031540.0c732284.akpm@osdl.org>
In-Reply-To: <200509131147.42140.ak@suse.de>
References: <43246267.mailL4R11PXCB@suse.de>
	<200509121447.00373.ak@suse.de>
	<Pine.LNX.4.61.0509131107360.3728@scrub.home>
	<200509131147.42140.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Andrew do you still have the patch with 
>  the description? It must have been between 2.6.13mm1 and  2.6.13mm2.




From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Because 2.6.13-mm2  adds new zone DMA32, ZONES_SHIFT becomes 3.
So, flags bits reserved for (SECTION | NODE | ZONE) should be increase.

ZONE_SHIFT is increased, FLAGS_RESERVED should be.

Signed-off-by Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/mmzone.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN include/linux/mmzone.h~x86_64-dma32-fix include/linux/mmzone.h
--- 25/include/linux/mmzone.h~x86_64-dma32-fix	Fri Sep  9 17:13:41 2005
+++ 25-akpm/include/linux/mmzone.h	Fri Sep  9 17:14:13 2005
@@ -431,9 +431,10 @@ extern struct pglist_data contig_page_da
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
_


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUCOFJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUCOFJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:09:57 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:44929 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261524AbUCOFJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:09:56 -0500
Date: Mon, 15 Mar 2004 00:06:16 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP Updates for 2.6.4-mm2
Message-ID: <20040315000615.GA5972@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This is the first of a series of PnP updates for 2.6.4.  I would appreciate if
these could be tested in your -mm tree.

Thanks,
Adam

[PNP] Resource Conflict Cleanup

This patch cleans up the resource conflict logic and was originally from Matthew
Wilcox <willy@debian.org>.

--- a/drivers/pnp/resource.c	2004-01-23 15:19:25.000000000 +0000
+++ b/drivers/pnp/resource.c	2004-02-01 20:07:41.000000000 +0000
@@ -231,15 +231,9 @@
 
 #define length(start, end) (*(end) - *(start) + 1)

-/* ranged_conflict - used to determine if two resource ranges conflict
- * condition 1: check if the start of a is within b
- * condition 2: check if the end of a is within b
- * condition 3: check if b is engulfed by a */
-
+/* Two ranges conflict if one doesn't end before the other starts */
 #define ranged_conflict(starta, enda, startb, endb) \
-((*(starta) >= *(startb) && *(starta) <= *(endb)) || \
- (*(enda) >= *(startb) && *(enda) <= *(endb)) || \
- (*(starta) < *(startb) && *(enda) > *(endb)))
+	!((*(enda) < *(startb)) || (*(endb) < *(starta)))

 #define cannot_compare(flags) \
 ((flags) & (IORESOURCE_UNSET | IORESOURCE_DISABLED))

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWAKTZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWAKTZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWAKTZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:25:26 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:31758 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932198AbWAKTZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:25:25 -0500
Message-ID: <43C55BF2.40500@shadowen.org>
Date: Wed, 11 Jan 2006 19:26:42 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64 out of line numa funcs are discontig only
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grrrr, patch sender collapsed the cc lines ...

-------- Original Message --------
Subject: [PATCH] x86_64 out of line numa funcs are discontig only
Date: Wed, 11 Jan 2006 18:14:11 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>
References: <20060111042135.24faf878.akpm@osdl.org>

x86_64 out of line numa funcs are discontig only

The following patch included in 2.6.15-mm3 moves the inline DISCONTIGMEM
page accessor functions into numa.c.  However, these are only used under
DISCONTIGMEM and need covered by CONFIG_DISCONTIGMEM:

    x86_64-out-of-line-numa-funcs.patch

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 numa.c |    2 ++
 1 files changed, 2 insertions(+)
diff -upN reference/arch/x86_64/mm/numa.c current/arch/x86_64/mm/numa.c
--- reference/arch/x86_64/mm/numa.c
+++ current/arch/x86_64/mm/numa.c
@@ -361,6 +361,7 @@ EXPORT_SYMBOL(memnode_shift);
 EXPORT_SYMBOL(memnodemap);
 EXPORT_SYMBOL(node_data);

+#ifdef CONFIG_DISCONTIGMEM
 /*
  * Functions to convert PFNs from/to per node page addresses.
  * These are out of line because they are quite big.
@@ -394,3 +395,4 @@ int pfn_valid(unsigned long pfn)
 	return pfn >= node_start_pfn(nid) && (pfn) < node_end_pfn(nid);
 }
 EXPORT_SYMBOL(pfn_valid);
+#endif /* CONFIG_DISCONTIGMEM */

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUDIF3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 01:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUDIF3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 01:29:32 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:53392 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261787AbUDIF3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 01:29:31 -0400
Date: Thu, 08 Apr 2004 22:29:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: colpatch@us.ibm.com, Andi Kleen <ak@suse.de>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: NUMA API for Linux
Message-ID: <1496342704.1081488562@[10.10.2.4]>
In-Reply-To: <1081472946.12673.310.camel@arrakis>
References: <1081373058.9061.16.camel@arrakis> <20040407232712.2595ac16.ak@suse.de> <1081374061.9061.26.camel@arrakis> <20040407234525.4f775c16.ak@suse.de> <1081472946.12673.310.camel@arrakis>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead of looking up a page's node number by
> page_zone(p)->zone_pgdat->node_id, you can get the same information much
> more efficiently by doing some bit-twidling on page->flags.  Use
> page_nodenum(struct page *) from include/linux/mm.h.

Never noticed that before - I'd prefer we renamed this to page_to_nid 
before anyone starts using it ... fits with the naming convention of 
everything else (pfn_to_nid, etc). Nobody uses it right now - I grepped 
the whole tree.

M.

diff -aurpN -X /home/fletch/.diff.exclude virgin/include/linux/mm.h name_nids/include/linux/mm.h
--- virgin/include/linux/mm.h	Wed Mar 17 07:33:09 2004
+++ name_nids/include/linux/mm.h	Thu Apr  8 22:27:24 2004
@@ -340,7 +340,7 @@ static inline unsigned long page_zonenum
 {
 	return (page->flags >> NODEZONE_SHIFT) & (~(~0UL << ZONES_SHIFT));
 }
-static inline unsigned long page_nodenum(struct page *page)
+static inline unsigned long page_to_nid(struct page *page)
 {
 	return (page->flags >> (NODEZONE_SHIFT + ZONES_SHIFT));
 }






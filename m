Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUHIIgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUHIIgC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUHIIf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:35:58 -0400
Received: from holomorphy.com ([207.189.100.168]:58333 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266334AbUHIIdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:33:45 -0400
Date: Mon, 9 Aug 2004 01:33:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040809083339.GK11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040808152936.1ce2eab8.akpm@osdl.org> <200408090820.i798Kbj07417@owlet.beaverton.ibm.com> <20040809082926.GJ11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809082926.GJ11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 01:29:26AM -0700, William Lee Irwin III wrote:
> Initializing NODE_DATA(nid)->node_mem_map prior to calling it should do.

Not sure why the first call didn't show up in the patch.


Index: mm2-2.6.8-rc3/arch/i386/mm/discontig.c
===================================================================
--- mm2-2.6.8-rc3.orig/arch/i386/mm/discontig.c	2004-08-08 15:39:24.000000000 -0700
+++ mm2-2.6.8-rc3/arch/i386/mm/discontig.c	2004-08-09 01:18:30.750614368 -0700
@@ -418,15 +418,15 @@
 		 * remapped KVA area - mbligh
 		 */
 		if (!nid)
-			free_area_init_node(nid, NODE_DATA(nid), 0, 
-				zones_size, start, zholes_size);
+			free_area_init_node(nid, NODE_DATA(nid),
+					zones_size, start, zholes_size);
 		else {
 			unsigned long lmem_map;
 			lmem_map = (unsigned long)node_remap_start_vaddr[nid];
 			lmem_map += sizeof(pg_data_t) + PAGE_SIZE - 1;
 			lmem_map &= PAGE_MASK;
-			free_area_init_node(nid, NODE_DATA(nid), 
-				(struct page *)lmem_map, zones_size, 
+			NODE_DATA(nid)->node_mem_map = (struct page *)lmem_map;
+			free_area_init_node(nid, NODE_DATA(nid), zones_size, 
 				start, zholes_size);
 		}
 	}

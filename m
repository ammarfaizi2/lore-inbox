Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWDYBsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWDYBsc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 21:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWDYBsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 21:48:32 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:64183 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751511AbWDYBsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 21:48:32 -0400
Date: Tue, 25 Apr 2006 10:48:55 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org, mel@csn.ul.ie
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
 independent manner V4
Message-Id: <20060425104855.42c6ca62.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060424202009.20409.89016.sendpatchset@skynet>
References: <20060424202009.20409.89016.sendpatchset@skynet>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006 21:20:09 +0100 (IST)
Mel Gorman <mel@csn.ul.ie> wrote:

> This is V4 of the patchset to size zones and memory holes in an
> architecture-independent manner.
> 

Could you add some documentation about 'how to use' your generic funcs ?
I think more archs can use your generic routine if well documented.

All initialization path can be written in following way ?
==
for_all_memory_region()
	add_active_range(nid, start, end)
free_area_init_nodes(max_dma, max_dma32, max_low_pfn, max_pfn);
==

And following functions are really needed ?
==
+extern void remove_all_active_ranges(void);
+extern void get_pfn_range_for_nid(unsigned int nid,
+			unsigned long *start_pfn, unsigned long *end_pfn);
+extern unsigned long find_min_pfn_with_active_regions(void);
+extern unsigned long find_max_pfn_with_active_regions(void);
+extern int early_pfn_to_nid(unsigned long pfn);
+extern void free_bootmem_with_active_regions(int nid,
+						unsigned long max_low_pfn);
+extern void sparse_memory_present_with_active_regions(int nid);
+extern unsigned long absent_pages_in_range(unsigned long start_pfn,
+						unsigned long end_pfn);

-Kame


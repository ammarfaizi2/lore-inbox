Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUIHMSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUIHMSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUIHMSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:18:38 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:55709 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261375AbUIHMOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:14:49 -0400
Date: Wed, 08 Sep 2004 21:20:02 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC][PATCH] no bitmap buddy allocator:  remove free_area->map
 (0/4)
In-reply-to: <413EEFA9.9030007@jp.fujitsu.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       LHMS <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <413EF8F2.5000904@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <413EEFA9.9030007@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a quick change-log from "previous-version" for comparison.

Big difference from previous one is revival of bad_range() and reduced victim pages.

   -- bad_range() is modified and bad_range_pfn() is added.
   -- bad_range_pfn() uses zone->memmap_start_pfn/memmap_end_pfn instead of using
      zone_start_pfn/spanned_pages. Because IA64's memmap's start is not equal to
      zone->zone_start_pfn.
   -- In most inner loop of __free_pages_bulk(), bad_range_pfn() is used.
   -- this bad_range_pfn() enables me to reduce victim pages.

      In my IA64,
Sep  8 18:59:38 casares kernel: calculate_buddy_range() 36e 129901
Sep  8 18:59:38 casares kernel: victim end page 1feda
Sep  8 18:59:38 casares kernel: calculate_buddy_range() 1fedc 292
Sep  8 18:59:38 casares kernel: victim top page 1fedc
Sep  8 18:59:38 casares kernel: victim top page 1fee0
Sep  8 18:59:38 casares kernel: victim top page 1ff00
Sep  8 18:59:38 casares kernel: victim end page 1ffff
Sep  8 18:59:38 casares kernel: saved end victim page 1ffff
Sep  8 18:59:38 casares kernel: calculate_buddy_range() 40000 262144
Sep  8 18:59:38 casares kernel: calculate_buddy_range() a0000 131072
Sep  8 18:59:38 casares kernel: victim top page a0000
Sep  8 18:59:38 casares kernel: Built 1 zonelists
       # of victim pages is 5. It was 19 in previous version.

   -- ia64's virtual_memmap_init() can call memmap_init() several times for the same
      memory range. It was fixed.

-- Kame


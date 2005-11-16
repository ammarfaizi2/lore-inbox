Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965254AbVKPM4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965254AbVKPM4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbVKPM4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:56:50 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50143 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965254AbVKPM4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:56:49 -0500
Message-ID: <437B2C82.6020803@jp.fujitsu.com>
Date: Wed, 16 Nov 2005 21:56:34 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: 2.6.14-mm2
References: <20051110203544.027e992c.akpm@osdl.org>
In-Reply-To: <20051110203544.027e992c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch was needed to add new pages into empty zone.

-- Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

--
This is a fix to add pages into empty zone.

fixes free_area_init_code, which doesn't calles
init_currently_empty_zone() if zone size is 0.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



Index: linux-2.6.14-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/page_alloc.c
+++ linux-2.6.14-mm2/mm/page_alloc.c
@@ -2054,11 +2054,11 @@ static void __init free_area_init_core(s
  		zone->nr_active = 0;
  		zone->nr_inactive = 0;
  		atomic_set(&zone->reclaim_in_progress, 0);
+		init_currently_empty_zone(zone, zone_start_pfn, size);
  		if (!size)
  			continue;

  		zonetable_add(zone, nid, j, zone_start_pfn, size);
-		init_currently_empty_zone(zone, zone_start_pfn, size);
  		zone_start_pfn += size;
  	}
  }


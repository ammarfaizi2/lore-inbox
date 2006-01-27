Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWA0Aan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWA0Aan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWA0Aan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:30:43 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:49379 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964814AbWA0Aam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:30:42 -0500
Message-ID: <43D96987.8090608@jp.fujitsu.com>
Date: Fri, 27 Jan 2006 09:29:59 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/9] Reducing fragmentation using zones v4
References: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel-san

Mel Gorman wrote:
> Changelog since v4
>   o Minor bugs
>   o ppc64 can specify kernelcore
>   o Ability to disable use of ZONE_EASYRCLM at boot time
>   o HugeTLB uses ZONE_EASYRCLM
>   o Add drain-percpu caches for testing
>   o boot-parameter documentation added
> 

Could you add this patch to your set ?
This was needed to boot my x86 machine without HIGHMEM.

-- Kame

Index: linux-2.6.16-rc1-mm3/mm/highmem.c
===================================================================
--- linux-2.6.16-rc1-mm3.orig/mm/highmem.c
+++ linux-2.6.16-rc1-mm3/mm/highmem.c
@@ -225,9 +225,10 @@ static __init int init_emergency_pool(vo
  	struct sysinfo i;
  	si_meminfo(&i);
  	si_swapinfo(&i);
-
+#ifdef CONFIG_HIGHMEM   /* we can add HIGHMEM after boot */
  	if (!i.totalhigh)
  		return 0;
+#endif

  	page_pool = mempool_create(POOL_SIZE, page_pool_alloc, page_pool_free, NULL);
  	if (!page_pool)


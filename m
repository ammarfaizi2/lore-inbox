Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269168AbUHZP6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269168AbUHZP6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUHZP6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:58:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:41091 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S269137AbUHZPzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:55:54 -0400
Subject: Re: [RFC] buddy allocator without bitmap [3/4]
From: Dave Hansen <haveblue@us.ibm.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <412DD34A.70802@jp.fujitsu.com>
References: <412DD34A.70802@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1093535709.2984.24.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 08:55:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +                       if (zone->nr_mem_map > 1) {
> +                               /*
> +                                * there may be hole in zone's memmap &&
> +                                * hole is not aligned in this order.
> +                                * currently, I think CONFIG_VIRTUAL_MEM_MAP
> +                                * case is only case to reach here.
> +                                * Is there any other case ?
> +                                */
> +                               /*
> +                                * Is there better call than pfn_valid ?
> +                                */
> +                               if (!pfn_valid(zone->zone_start_pfn
> +                                              + (page_idx ^ (1 << order))))
> +                                       break;
> +                       }

Nice try.  How about putting the ia64 code in a macro or header function
that you can #ifdef out on all the other architectures?  We used to be
able to see that entire while loop on one screen.  That's a bit harder
now.  

-- Dave


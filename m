Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVJLL5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVJLL5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 07:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVJLL5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 07:57:35 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:10156 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750867AbVJLL5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 07:57:34 -0400
Subject: Re: [Lhms-devel] [PATCH 8/8] Fragmentation Avoidance V17: 008_stats
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Andrew Morton <akpm@osdl.org>, jschopp@austin.ibm.com, kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20051011151302.16178.46089.sendpatchset@skynet.csn.ul.ie>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
	 <20051011151302.16178.46089.sendpatchset@skynet.csn.ul.ie>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 04:57:27 -0700
Message-Id: <1129118247.6134.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 16:13 +0100, Mel Gorman wrote:
> +#ifdef CONFIG_ALLOCSTAT
> +               memset((unsigned long *)zone->fallback_count, 0,
> +                               sizeof(zone->fallback_count));
> +               memset((unsigned long *)zone->alloc_count, 0,
> +                               sizeof(zone->alloc_count));
> +               memset((unsigned long *)zone->alloc_count, 0,
> +                               sizeof(zone->alloc_count));
> +               zone->kernnorclm_partial_steal=0;
> +               zone->kernnorclm_full_steal=0;
> +               zone->reserve_count[RCLM_NORCLM] =
> +                               realsize >> (MAX_ORDER-1);
> +#endif

The struct zone is part of the pgdat which is zeroed at boot-time on all
architectures and configuration that I have ever audited.  Re-zeroing
parts of it here is unnecessary.

BTW, that '=0' with no spaces is anti-CodingStyle.

-- Dave


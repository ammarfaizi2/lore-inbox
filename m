Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVJEQsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVJEQsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVJEQsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:48:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:6077 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030244AbVJEQsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:48:37 -0400
Subject: Re: [PATCH 3/7] Fragmentation Avoidance V16: 003_fragcore
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jschopp@austin.ibm.com, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20051005144602.11796.53850.sendpatchset@skynet.csn.ul.ie>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
	 <20051005144602.11796.53850.sendpatchset@skynet.csn.ul.ie>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 09:48:27 -0700
Message-Id: <1128530908.26009.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 15:46 +0100, Mel Gorman wrote:
> 
> @@ -1483,8 +1540,10 @@ void show_free_areas(void)
>  
>                 spin_lock_irqsave(&zone->lock, flags);
>                 for (order = 0; order < MAX_ORDER; order++) {
> -                       nr = zone->free_area[order].nr_free;
> -                       total += nr << order;
> +                       for (type=0; type < RCLM_TYPES; type++) {
> +                               nr = zone->free_area_lists[type][order].nr_free;
> +                               total += nr << order;
> +                       }

Can that use the new for_each_ macro?

-- Dave


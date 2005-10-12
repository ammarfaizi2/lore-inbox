Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVJLQoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVJLQoI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVJLQoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:44:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:64717 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751180AbVJLQoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:44:07 -0400
Date: Wed, 12 Oct 2005 09:43:54 -0700
From: mike kravetz <kravetz@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: akpm@osdl.org, jschopp@austin.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 5/8] Fragmentation Avoidance V17: 005_fallback
Message-ID: <20051012164353.GA9425@w-mikek2.ibm.com>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie> <20051011151246.16178.40148.sendpatchset@skynet.csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011151246.16178.40148.sendpatchset@skynet.csn.ul.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 04:12:47PM +0100, Mel Gorman wrote:
> This patch implements fallback logic. In the event there is no 2^(MAX_ORDER-1)
> blocks of pages left, this will help the system decide what list to use. The
> highlights of the patch are;
> 
> o Define a RCLM_FALLBACK type for fallbacks
> o Use a percentage of each zone for fallbacks. When a reserved pool of pages
>   is depleted, it will try and use RCLM_FALLBACK before using anything else.
>   This greatly reduces the amount of fallbacks causing fragmentation without
>   needing complex balancing algorithms

I'm having a little trouble seeing how adding a new type (RCLM_FALLBACK)
helps.  Seems to me that pages put into the RCLM_FALLBACK area would have
gone to the global free list and available to anyone.  I must be missing
something here.

> +int fallback_allocs[RCLM_TYPES][RCLM_TYPES+1] = {
> +	{RCLM_NORCLM,	RCLM_FALLBACK, RCLM_KERN,   RCLM_USER, RCLM_TYPES},
> +	{RCLM_KERN,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_USER, RCLM_TYPES},
> +	{RCLM_USER,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_KERN, RCLM_TYPES},
> +	{RCLM_FALLBACK, RCLM_NORCLM,   RCLM_KERN,   RCLM_USER, RCLM_TYPES}

Do you really need that last line?  Can an allocation of type RCLM_FALLBACK
realy be made?

-- 
Mike

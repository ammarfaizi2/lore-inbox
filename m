Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUHUUMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUHUUMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267787AbUHUUMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:12:00 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:43719 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267759AbUHUULX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:11:23 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: mita akinobu <amgta@yacht.ocn.ne.jp>
Subject: Re: [PATCH] shows Active/Inactive on per-node meminfo
Date: Sat, 21 Aug 2004 16:11:12 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>
References: <200408210302.25053.amgta@yacht.ocn.ne.jp> <200408201448.22566.jbarnes@engr.sgi.com> <200408211529.37839.amgta@yacht.ocn.ne.jp>
In-Reply-To: <200408211529.37839.amgta@yacht.ocn.ne.jp>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408211611.12568.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 21, 2004 2:29 am, mita akinobu wrote:
> get_zone_counts() is used by max_sane_readahead(), and
> max_sane_readahead() is often called in filemap_nopage().
>
> If iterating over every node is going to be very slow, the following change
> would have a little bit of improvement on a large machine?
>
>
> --- linux-2.6.8.1-mm3/mm/readahead.c.orig	2004-08-21 15:18:08.924273720
> +0900 +++ linux-2.6.8.1-mm3/mm/readahead.c	2004-08-21 15:22:31.123413392
> +0900 @@ -572,6 +572,6 @@ unsigned long max_sane_readahead(unsigne
>  	unsigned long inactive;
>  	unsigned long free;
>
> -	get_zone_counts(&active, &inactive, &free);
> +	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
>  	return min(nr, (inactive + free) / 2);
>  }

Good catch, this looks good.  for_each_pgdat just raises a red flag for me 
these days. :)

Thanks,
Jesse

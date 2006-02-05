Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWBEI5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWBEI5t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 03:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWBEI5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 03:57:49 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:51697 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750702AbWBEI5s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 03:57:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jUQcTjpNCpCR2s0AK/TC+RSJRLuByX4YY3CxkNJx5hdPVCk4UyryyCPa9owB/NE6k8/g9CHq9eBjUiAeBs0x4ioNoS1cqUnrGfvi/juWfYprbE+51+fZpaf0hJzW8qxXhAFVJDx8BTQ+R4S6dZjmYmMhUQkzQ6wceTfPWV5oAf8=
Message-ID: <2cd57c900602050057p1b5a813bh@mail.gmail.com>
Date: Sun, 5 Feb 2006 16:57:46 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 2/4] Split the free lists into kernel and user parts
Cc: linux-mm@kvack.org, jschopp@austin.ibm.com, linux-kernel@vger.kernel.org,
       kamezawa.hiroyu@jp.fujitsu.com, lhms-devel@lists.sourceforge.net
In-Reply-To: <20060120115455.16475.93688.sendpatchset@skynet.csn.ul.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060120115415.16475.8529.sendpatchset@skynet.csn.ul.ie>
	 <20060120115455.16475.93688.sendpatchset@skynet.csn.ul.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/20, Mel Gorman <mel@csn.ul.ie>:
>
> This patch adds the core of the anti-fragmentation strategy. It works by
> grouping related allocation types together. The idea is that large groups of
> pages that may be reclaimed are placed near each other. The zone->free_area
> list is broken into RCLM_TYPES number of lists.
>
> Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
> diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/mmzone.h linux-2.6.16-rc1-mm1-002_fragcore/include/linux/mmzone.h
> --- linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/mmzone.h      2006-01-19 11:21:59.000000000 +0000
> +++ linux-2.6.16-rc1-mm1-002_fragcore/include/linux/mmzone.h    2006-01-19 21:51:05.000000000 +0000
> @@ -22,8 +22,16 @@
>  #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
>  #endif
>
> +#define RCLM_NORCLM 0

better be RCLM_NORMAL

> +#define RCLM_EASY   1
> +#define RCLM_TYPES  2
> +
> +#define for_each_rclmtype_order(type, order) \
> +       for (order = 0; order < MAX_ORDER; order++) \
> +               for (type = 0; type < RCLM_TYPES; type++)
> +
>  struct free_area {
> -       struct list_head        free_list;
> +       struct list_head        free_list[RCLM_TYPES];
>         unsigned long           nr_free;
>  };
>


--
Coywolf Qi Hunt

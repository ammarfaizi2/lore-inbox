Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757962AbWK1XbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962AbWK1XbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758007AbWK1XbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:31:18 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:26016 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1757962AbWK1XbO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:31:14 -0500
Subject: Re: [PATCH 6/6] ext2 balloc: use io_error label
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611281743370.29701@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114184919.GA16020@skynet.ie>
	 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	 <20061114113120.d4c22b02.akpm@osdl.org>
	 <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
	 <20061115232228.afaf42f2.akpm@osdl.org>
	 <1163666960.4310.40.camel@localhost.localdomain>
	 <20061116011351.1401a00f.akpm@osdl.org>
	 <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
	 <20061116132724.1882b122.akpm@osdl.org>
	 <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
	 <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
	 <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611281743370.29701@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 28 Nov 2006 15:31:11 -0800
Message-Id: <1164756672.6538.8.camel@dyn9047017103.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 17:44 +0000, Hugh Dickins wrote:
> ext2_new_blocks has a nice io_error label for setting -EIO,
> so goto that in the one place that doesn't already use it.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> ---
> 

Acked, 

Mingming
>  fs/ext2/balloc.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> --- 2.6.19-rc6-mm2/fs/ext2/balloc.c	2006-11-24 08:18:02.000000000 +0000
> +++ linux/fs/ext2/balloc.c	2006-11-27 19:28:41.000000000 +0000
> @@ -1258,10 +1258,9 @@ retry_alloc:
>  		if (group_no >= ngroups)
>  			group_no = 0;
>  		gdp = ext2_get_group_desc(sb, group_no, &gdp_bh);
> -		if (!gdp) {
> -			*errp = -EIO;
> -			goto out;
> -		}
> +		if (!gdp)
> +			goto io_error;
> +
>  		free_blocks = le16_to_cpu(gdp->bg_free_blocks_count);
>  		/*
>  		 * skip this group if the number of
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ext4" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


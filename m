Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWEGIzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWEGIzE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 04:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWEGIzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 04:55:04 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:50909 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932109AbWEGIzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 04:55:03 -0400
Date: Sun, 7 May 2006 11:54:58 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jon Mason <jdmason@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, mulix@mulix.org
Subject: Re: [PATCH 3/3] swiotlb: replace free array with bitmap
Message-ID: <20060507085458.GG6015@rhun.haifa.ibm.com>
References: <20060504210017.GE14361@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504210017.GE14361@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 04:00:17PM -0500, Jon Mason wrote:

> +		index = find_next_zero_string(io_tlb_list, io_tlb_index,
> +				io_tlb_nslabs, nslots);
> +		if (index == ~0U) {
> +			index = find_next_zero_string(io_tlb_list, 0,
> +					io_tlb_nslabs, nslots);
> +			if (index == ~0U)
> +				return NULL;

If we run out of space in the bitmap we return here with the
io_tlb_lock held. Also, an informative message saying that we've run
out of space in the bitmap is probably a good idea.

Cheers,
Muli



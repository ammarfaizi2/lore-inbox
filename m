Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUEHWWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUEHWWv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUEHWWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:22:51 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:55307 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264206AbUEHWWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:22:44 -0400
Date: Sat, 8 May 2004 23:22:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap 24 pte_young first
Message-ID: <20040508232239.B12293@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain> <Pine.LNX.4.44.0405082255430.26569-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0405082255430.26569-100000@localhost.localdomain>; from hugh@veritas.com on Sat, May 08, 2004 at 10:56:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 10:56:26PM +0100, Hugh Dickins wrote:
> From: Andrea Arcangeli <andrea@suse.de>
> 
> rmap test pte_young before doing the costlier ptep_test_and_clear_young.
> 
>  rmap.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> --- rmap24/mm/rmap.c	2004-05-08 20:54:32.421571016 +0100
> +++ rmap25/mm/rmap.c	2004-05-08 20:54:43.358908288 +0100
> @@ -198,7 +198,7 @@ static int page_referenced_one(struct pa
>  	if (page_to_pfn(page) != pte_pfn(*pte))
>  		goto out_unmap;
>  
> -	if (ptep_test_and_clear_young(pte))
> +	if (pte_young(*pte) && ptep_test_and_clear_young(pte))

stupid question - shouldn't the pte_young check simply move to
the beginning of ptep_test_and_clear_young?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWHNW7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWHNW7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 18:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWHNW7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 18:59:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:5085 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965030AbWHNW7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 18:59:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=IXIJLkjjPILiSBsrCVs7U2oiD9UrBr79753wgE1dUqr64zAJiLc1VfqvheCpH6ILeOYmy3XxLwDcm4maYJDsf0vdexkiuo8WVyKH/kFcSTQTVLEO8veJY0w7S1q2Lp6r3MI7Hek8xXrhtRIhkvIJOCTZAkrwCRTkOs1HRXK3+EQ=
Date: Tue, 15 Aug 2006 02:59:41 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, cmm@us.ibm.com
Subject: Re: + ext3-and-jbd-cleanup-replace-brelse-to-put_bh.patch added to -mm tree
Message-ID: <20060814225941.GB5175@martell.zuzino.mipt.ru>
References: <200608120146.k7C1kDVd006044@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608120146.k7C1kDVd006044@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 06:46:13PM -0700, akpm@osdl.org wrote:
> Replace all brelse() calls with put_bh().  Because brelse() is
> old-fashioned, has a weird name and neelessly permits a NULL

> --- a/fs/ext3/balloc.c~ext3-and-jbd-cleanup-replace-brelse-to-put_bh
> +++ a/fs/ext3/balloc.c
> @@ -351,7 +351,7 @@ do_more:
>  		overflow = bit + count - EXT3_BLOCKS_PER_GROUP(sb);
>  		count -= overflow;
>  	}
> -	brelse(bitmap_bh);
> +	put_bh(bitmap_bh);

Is it safe to always s/brelse/put_bh/ ? Or someone has to audit every
occurence for this "neelessly permits a NULL"?


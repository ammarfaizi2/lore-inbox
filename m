Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261730AbTCZP5A>; Wed, 26 Mar 2003 10:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261734AbTCZP5A>; Wed, 26 Mar 2003 10:57:00 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:43524 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261730AbTCZP47>; Wed, 26 Mar 2003 10:56:59 -0500
Date: Wed, 26 Mar 2003 16:08:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] s390 update (4/9): common i/o layer update.
Message-ID: <20030326160810.A17984@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <200303261610.16448.schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303261610.16448.schwidefsky@de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Mar 26, 2003 at 04:10:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 04:10:16PM +0100, Martin Schwidefsky wrote:
> +	typeof (chsc_area_ssd.response_block)
> +		*ssd_res = &chsc_area_ssd.response_block;

Yikes!  Please use the actual type here instead of typeof()

> +	if (sch->lpm == 0)
> +		return -ENODEV;
> +	else
> +		return -EACCES;

I'd write this as return (sch->lpm ? -EACCES : -ENODEV), but maybe I'm
just too picky..

> -	sch = kmalloc (sizeof (*sch), GFP_DMA);
> +	sch = kmalloc (sizeof (*sch), GFP_KERNEL | GFP_DMA);

What about using GFP_KERNEL | __GFP_DMA instead?  This makes it
more clear that it's just a qualifier.


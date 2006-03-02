Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWCBEqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWCBEqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWCBEqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:46:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21732 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750781AbWCBEqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:46:21 -0500
Date: Wed, 1 Mar 2006 20:45:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] map multiple blocks for mpage_readpages()
Message-Id: <20060301204502.63330347.akpm@osdl.org>
In-Reply-To: <1141075456.10542.25.camel@dyn9047017100.beaverton.ibm.com>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
	<1141075456.10542.25.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>  do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
>  -			sector_t *last_block_in_bio, get_block_t get_block)
>  +			sector_t *last_block_in_bio, struct buffer_head *map_bh,
>  +			unsigned long *first_logical_block, int *map_valid,
>  +			get_block_t get_block)

I wonder if we really need that map_valid pointer there.  The normal way of
communicating the validity of a bh is via buffer_uptodate().  I _think_
that's an appropriate thing to use here.  With appropriate comments, of
course..

If those options are not a sufficiently good fit then we can easily create
a new buffer-head.state bit for this purpose - there are lots to spare.

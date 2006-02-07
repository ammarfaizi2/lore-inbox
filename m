Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWBGHjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWBGHjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 02:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWBGHjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 02:39:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27667 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964990AbWBGHjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 02:39:16 -0500
Date: Tue, 7 Feb 2006 08:41:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH] block: undeprecate ll_rw_block()
Message-ID: <20060207074136.GA4210@suse.de>
References: <1139254591.17774.5.camel@localhost> <20060206210705.GC5276@suse.de> <Pine.LNX.4.58.0602070909370.25555@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602070909370.25555@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07 2006, Pekka J Enberg wrote:
> On Mon, Feb 06 2006, Pekka Enberg wrote:
> > > This patch removes the DEPRECATED comment from ll_rw_block(). The function
> > > is still in active use and there isn't any real replacement for it.
> 
> On Mon, 6 Feb 2006, Jens Axboe wrote:
> > It is still deprecated, so I think the comment should stay. There are
> > plenty ways to accomplish what ll_rw_block does (and more efficiently,
> > array of bh's is not very nice to say the least) and the buffer_head
> > isn't even an io unit anymore.
> 
> To clarify, what ways are there? When we need to access the data, use
> submit_bh() and when we just want the I/O to be done,
> generic_make_request()?

Generally you want to move to using a bio instead of a bh. Once you do
that, you can submit > 1 page of io a lot more efficiently than what
ll_rw_block() is doing. submit_bh() is just a 'wrapper' on top of the
real io interface, your explanation of the two doesn't make sense.

generic_make_request() is typically something a low level driver like md
or dm would use to submit a formed bio to a device, it's not something
you'd expect other parts of the kernel to use. If you look at the newer
io parts in the kernel (in fs/ and mm/), you'll see them using
submit_bio() mostly.

-- 
Jens Axboe


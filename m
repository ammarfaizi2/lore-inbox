Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbTFJPqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTFJPqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:46:13 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:14199 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263293AbTFJPqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:46:02 -0400
Date: Tue, 10 Jun 2003 17:02:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jens Axboe <axboe@suse.de>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loop 2/9 absorb bio_copy
In-Reply-To: <20030610153730.GC17164@suse.de>
Message-ID: <Pine.LNX.4.44.0306101657140.2334-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003, Jens Axboe wrote:
> On Tue, Jun 10 2003, Hugh Dickins wrote:
> > bio_copy is used only by the loop driver, which already has to walk the
> > bio segments itself: so it makes sense to change it from bio.c export
> > to loop.c static, as prelude to working upon it there.
> 
> I don't think this is is a particularly good idea, it's pretty core bio
> functionality that should be left alone in bio.c imho.
> 
> Is there a real reason you want to do this apart from 'loop is the only
> (current) user'?

As I said, loop already has to walk the bio segments itself elsewhere,
and a lot of what bio_copy does (e.g. copying data) it doesn't need done,
and other things it does (same gfp_mask for two very different allocations)
don't suit loop very well.  By all means add bio_copy back into fs/bio.c
when something else needs that functionality?

Hugh


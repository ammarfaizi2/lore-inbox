Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWHQXLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWHQXLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWHQXLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:11:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:1941 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965143AbWHQXLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:11:17 -0400
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
From: Badari Pulavarty <pbadari@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jens Axboe <axboe@suse.de>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E1G83hL-00035h-00@gondolin.me.apana.org.au>
References: <E1G83hL-00035h-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 16:14:16 -0700
Message-Id: <1155856456.18864.5.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 09:30 +1000, Herbert Xu wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > That looks really dangerous, I'd prefer that to be a BUG_ON() as well to
> > prevent nastiness further down.
> 
> OK, I used a WARN_ON mainly because ext3 has been doing this for years
> without killing anyone until now :)
> 
> [BLOCK] bh: Ensure bh fits within a page
> 
> There is a bug in jbd with slab debugging enabled where it was submitting
> a bh obtained via jbd_rep_kmalloc which crossed a page boundary.  A lot
> of time was spent on tracking this down because the symptoms were far off
> from where the problem was.
> 
> This patch adds a sanity check to submit_bh so we can immediately spot
> anyone doing similar things in future.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Cheers,

Hi,

I am working on a fix to address this problem. Do you have any testcases
to reproduce the problem ? I have been running bunch of tests with
CONFIG_DEBUG_SLAB with WARN_ON() and I haven't seen it yet :(

Wondering, if there is any special thing I need to do to reproduce
the problem ? Please let me know.

Thanks,
Badari


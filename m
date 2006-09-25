Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWIYGSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWIYGSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWIYGSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:18:40 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:23258 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S932202AbWIYGSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:18:39 -0400
Date: Mon, 25 Sep 2006 15:18:19 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, luke Yang <luke.adi@gmail.com>
Subject: Re: [PATCH 3/3] [BFIN] Blackfin documents and MAINTAINER patch
Message-ID: <20060925061819.GA8879@localhost.na.rta>
References: <6.1.1.1.0.20060925011906.01ecea00@ptg1.spd.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.1.1.0.20060925011906.01ecea00@ptg1.spd.analog.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 01:51:34AM -0400, Robin Getz wrote:
> Paul indicated:
> >This is a generic enough of a feature that I suspect we should hash out a 
> >common API for it rather than having people roll their own.
> 
> That sounds like a good idea. From the few people that use this, I think a 
> much simpler interface would be desirable.
> 
> For data, it is easy - something similar to the processor specific 
> xx_flush_range(start,end) - have a xxx_lock_range(start,end) would be good, 
> and easy to implement.
> 
Yes, xxx_lock_range() (and a corresponding xxx_unlock_range()) would be
ideal for this.

> The only thing I am not sure of - is how to force things into cache. For 
> data - it is easy - do a read, and then lock it. For instruction - for 
> those architectures which have separate instruction cache (like Blackfin) 
> it is much harder. The only way to get code into cache is to execute it. 
> (ergo the existing interface).
> 
I suppose the first question is to determine whether it's really worth
doing the I-cache locking or simply sticking with a simplistic interface
aimed more at D-cache locking.

The I-cache case is somewhat more problematic, the only way to do it in
an architecture-neutral fashion is likely to expose a code page that is
pre-loaded and kicked down to the lower levels to work out the actual
locking semantics.

> Because the algorithm is so specific to the hardware - I am not sure how to 
> make instruction as generic as data could be.
> 
> How does SH cache handle things like this?
> 
On SH both the I and D caches have MMIO access to the cache lines, so we
can jump to uncached space, clean the relevant cache, and then map the
data we want to lock directly in before jumping back to cached space.

So far we haven't done much with I-cache locking though.

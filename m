Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbUCYPRs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbUCYPRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:17:22 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53888 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263196AbUCYPRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:17:09 -0500
Date: Thu, 25 Mar 2004 16:01:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       seife@suse.de
Subject: Re: swsusp with highmem, testing wanted
Message-ID: <20040325150129.GI1505@openzaurus.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz> <20040325073244.GE3377@suse.de> <20040325115129.GB300@elf.ucw.cz> <20040325121418.GK3377@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325121418.GK3377@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I actually ran it on real 2GB machine, and it seemed to do the trick,
> > unless "too much" memory was full.
> 
> Well your patch really looked nothing more than a nasty hack, since it
> has known and very real failures. Why do you need to copy all highmem
> down to low mem? That cannot _ever_ work reliably?!

Because it is only solution I know that does not require rewriting half
the kernel or rewriting all the block drivers. (see how swsusp already
does copy of lowmem).

Having special "poll" mode for block drivers might do the trick, but thats lot of work.

Which operations are allowed to access highmem? Can I rely on
block device read/write not accessing highmem?

> > What wories me is 
> > 
> > +               kaddr = kmap_atomic(page, KM_USER0);
> > +               memcpy(save->data, kaddr, PAGE_SIZE);
> > +               kunmap_atomic(kaddr, KM_USER0);
> > 
> > : am I allowed to use KM_USER0, or should I get new KM_constant just
> > for me?
> 
> KM_USER0 should be fine.

Thanks.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


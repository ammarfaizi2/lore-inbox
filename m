Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293491AbSBYTtb>; Mon, 25 Feb 2002 14:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293492AbSBYTtT>; Mon, 25 Feb 2002 14:49:19 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:10717 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S293491AbSBYTsn>;
	Mon, 25 Feb 2002 14:48:43 -0500
Subject: Re: [PATCH] only irq-safe atomic ops
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Jens Axboe <axboe@suse.de>, Andi Kleen <ak@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C7A939D.FCAE9096@zip.com.au>
In-Reply-To: <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel>
	<3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel>
	<3C77F503.1060005@sgi.com.suse.lists.linux.kernel>
	<p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au>
	<3C780702.9060109@sgi.com> <3C780CDA.FEAF9CB4@zip.com.au>
	<3C781362.7070103@sgi.com> <3C781909.F69D8791@zip.com.au>
	<3C7A35FF.5040508@sgi.com> <20020225131218.GO11837@suse.de>
	<3C7A398A.1060300@sgi.com>  <3C7A939D.FCAE9096@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 25 Feb 2002 13:45:22 -0600
Message-Id: <1014666322.9227.368.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-25 at 13:42, Andrew Morton wrote:
> Stephen Lord wrote:
> > 
> > Yep, bio just made it easier to get larger requests.
> > 
> 
> Which promptly go kersplat when you feed them into
> submit_bio():
> 
>      BUG_ON(bio_sectors(bio) > q->max_sectors);
> 
> Given that I'm hand-rolling a monster bio, I need to know
> when to wrap it up and send it off, to avoid creating a bio
> which is larger than the target device will accept.  I'm currently
> using the below patch.   Am I right that this is missing API
> functionality, or did I miss something?
> 

I don't run into that one, but probably because I limit xfs to
use BIO_MAX_SECTORS, take a look at ll_rw_kio to see how that
splits things up. This of course does not take into account
any further restriction in an underlying queue.

Steve


-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com

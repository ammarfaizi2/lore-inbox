Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWJMHDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWJMHDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 03:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWJMHDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 03:03:45 -0400
Received: from brick.kernel.dk ([62.242.22.158]:22277 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751223AbWJMHDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 03:03:44 -0400
Date: Fri, 13 Oct 2006 09:03:57 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       ak@suse.de, Don Mullis <dwm@meer.net>
Subject: Re: [patch 5/7] fault-injection capability for disk IO
Message-ID: <20061013070356.GU6515@kernel.dk>
References: <20061012074305.047696736@gmail.com> <452df232.7451e919.6dde.ffff9127@mx.google.com> <20061012140830.49ff6135.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012140830.49ff6135.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12 2006, Andrew Morton wrote:
> On Thu, 12 Oct 2006 16:43:10 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 
> > @@ -3134,6 +3174,9 @@ end_io:
> >  		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
> >  			goto end_io;
> >  
> > +		if (should_fail_request(bio))
> > +			goto end_io;
> > +
> 
> hm, so we simulate IO errors by failing at make_request() time rather than
> at end_that_request_last()-time, which is where IO errors would usually be
> reported.
> 
> If we're testing the filesystem/VFS/etc layers then that's pretty much
> equivalent.  But perhaps there's an argument for doing both.
> 
> Jens, could you have a think about it please?

For the io submitter and above layers, it's 100% identical to doing it
at end_that_request_first() time (which I suspect is what you meant). So
the above tests those layers only, which is fine if that is what you
want. When we have timeout timers at the block layer (moved from lower
layers), we could do more fancy stuff and test lower layers of the io
stack as well more easily.

-- 
Jens Axboe


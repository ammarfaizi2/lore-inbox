Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWC2JH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWC2JH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 04:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWC2JH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 04:07:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54034 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750715AbWC2JH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 04:07:57 -0500
Date: Wed, 29 Mar 2006 11:08:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Mark Lord <lkml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-git4: kernel BUG at block/ll_rw_blk.c:3497
Message-ID: <20060329090806.GW8186@suse.de>
References: <44288882.4020809@rtr.ca> <20060329081642.GU8186@suse.de> <20060329082747.GV27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329082747.GV27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, Al Viro wrote:
> On Wed, Mar 29, 2006 at 10:16:43AM +0200, Jens Axboe wrote:
> > triggering. What sort of testing were you running, exactly?
> > 
> > Al, any ideas?
> 
> I really wonder why it's the call from do_exit() that triggers it.
> The thing is, we get off-by-exactly-one here and all previous callers
> of that puppy would be elsewhere (cfq, mostly).
> 
> IOW, we get exactly one extra call of put_io_context() _and_ have it
> happen before do_exit() (i.e. from normal IO paths).  Interesting...
> 
> Is there any way to reproduce it without too much PITA?

That's what I'd like to know as well. So far I haven't seen any io
context anomalies with the current kernels. I'll keep poking.

-- 
Jens Axboe


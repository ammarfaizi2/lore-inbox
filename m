Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbUCLIEz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 03:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbUCLIEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 03:04:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58085 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262012AbUCLIEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 03:04:48 -0500
Date: Fri, 12 Mar 2004 09:04:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040312080446.GB15598@suse.de>
References: <20040311083619.GH6955@suse.de> <200403120741.18455.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403120741.18455.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12 2004, Ingo Oeser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Jens,
> 
> On Thursday 11 March 2004 09:36, Jens Axboe wrote:
> > diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/kernel/power/pmdisk.c linux-2.6.4-mm1/kernel/power/pmdisk.c
> > --- /opt/kernel/linux-2.6.4-mm1/kernel/power/pmdisk.c	2004-03-11 03:55:28.000000000 +0100
> > +++ linux-2.6.4-mm1/kernel/power/pmdisk.c	2004-03-11 09:07:12.000000000 +0100
> > @@ -859,7 +859,6 @@
> >  
> >  static void wait_io(void)
> >  {
> > -	blk_run_queues();
> >  	while(atomic_read(&io_done))
> >  		io_schedule();
> >  }
> > @@ -895,6 +894,7 @@
> >  		goto Done;
> >  	}
> >  
> > +	rw |= BIO_RW_SYNC;
> >  	if (rw == WRITE)
> >  		bio_set_pages_dirty(bio);
> >  	start_io();
> 
> These last 3 lines look bogus. The condition will never trigger. 
> Maybe you meant to move the assignment either down or change bio->bi_rw
> instead of rw.

Oops yes, that is bogus. Thanks for cathing that.

-- 
Jens Axboe


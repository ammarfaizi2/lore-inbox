Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSJOHit>; Tue, 15 Oct 2002 03:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSJOHit>; Tue, 15 Oct 2002 03:38:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59364 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263279AbSJOHin>;
	Tue, 15 Oct 2002 03:38:43 -0400
Date: Tue, 15 Oct 2002 09:44:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] superbh, fractured blocks, and grouped io
Message-ID: <20021015074423.GE5294@suse.de>
References: <20021014135100.GD28283@suse.de> <20021014181338.GF22117@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014181338.GF22117@nic1-pc.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14 2002, Joel Becker wrote:
> On Mon, Oct 14, 2002 at 03:51:00PM +0200, Jens Axboe wrote:
> 
> 	Just a couple niggles, really.  Looking good.
> 
> >  	/*
> > -	 * First step, 'identity mapping' - RAID or LVM might
> > -	 * further remap this.
> > +	 * detach each bh and resubmit, or completely and if its a grouped bh
> >  	 */
> 
> 	The last line of the comment means "completely fail if its
> grouped", right?

Oops, the 'and' should be an 'end'. So your wording is correct.

> > +#define MAX_SUPERBH 65535	/* must fit info ->b_size right now */
> 
> 	Why not sizeof(b_size) in case we ever care?

We don't want to make them too large anyway, and I think that 64k-1 is
more than enough. Maybe it would even be better to simply use an even
32kb. Consider someone writing in chunks of 64kb. It would simply suck
to get one 65024b request followed by a 512b one.

> > +extern int submit_bh_linked(int, struct buffer_head *);
> > +extern int submit_bh_grouped(int, struct buffer_head *);
> 
> 	Why aren't these EXPORT_SYMBOL(), given that a third party
> driver may wish to use them (eg, a filesystem doing its own O_DIRECT
> work)?

Sure yes they will be, posted code was a first draft :-)

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbRDWXKI>; Mon, 23 Apr 2001 19:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132551AbRDWXJH>; Mon, 23 Apr 2001 19:09:07 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:64272 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132561AbRDWXIP>; Mon, 23 Apr 2001 19:08:15 -0400
Date: Mon, 23 Apr 2001 17:01:58 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: NWFS broken on 2.4.3 -- someone removed WRITERAW
Message-ID: <20010423170158.A1543@vger.timpanogas.org>
In-Reply-To: <20010423163725.C1131@vger.timpanogas.org> <20010424005809.Y9357@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010424005809.Y9357@suse.de>; from axboe@suse.de on Tue, Apr 24, 2001 at 12:58:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 12:58:09AM +0200, Jens Axboe wrote:
> On Mon, Apr 23 2001, Jeff V. Merkey wrote:
> > 
> > 
> > Hey guys,
> > 
> > Whomever removed WRITERAW has broken NWFS.  WRITE requests call
> > _refile_buffer() after the I/O request and take my locally created 
> > buffer heads and munge them back into the linux buffer cache, causing
> > massive memory corruption in the system.  These buffers don't belong 
> > in Linus' buffer cache, they are owned by my LRU and ll_rw_block 
> > should not be blindly filing them back into the buffer cache.
> > 
> > Please put something back in to allow me to write without the buffer
> > heads always getting filed into Linus' buffer cache.  This has 
> > broken NWFS on 2.4.3 and above.
> 
> 	bh->b_end_io = my_end_io_handler;
> 	submit_bh(WRITE, bh);


Jens,

Bless you.  I'll code the fix, test it, and get it out.  

Jeff

> 
> Be a happy camper.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261768AbSJQFx6>; Thu, 17 Oct 2002 01:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261774AbSJQFx6>; Thu, 17 Oct 2002 01:53:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54728 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261768AbSJQFx5>;
	Thu, 17 Oct 2002 01:53:57 -0400
Date: Thu, 17 Oct 2002 07:59:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] superbh, fractured blocks, and grouped io
Message-ID: <20021017055942.GC9245@suse.de>
References: <20021014135100.GD28283@suse.de> <20021017005109.GV22117@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017005109.GV22117@nic1-pc.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16 2002, Joel Becker wrote:
> On Mon, Oct 14, 2002 at 03:51:00PM +0200, Jens Axboe wrote:
> > @@ -943,7 +1015,6 @@
> >  	 */
> >  	bh = blk_queue_bounce(q, rw, bh);
> 
> 	I don't know why this only slightly bothered me until I oopsed.
> This only bounces the superbh and certainly doesn't bounce all the
> attendant bhs in the list.

Eh no, it actually doesn't bounce anything! I added a test to bypass
bouncing temporarily in blk_queue_bounce() (see the BH_Super test in
there), but forgot to replace it with the real thing. The superbh
contains no data, so is not a candidate for bouncing.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267171AbUBSKV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267175AbUBSKV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:21:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6303 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267171AbUBSKVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:21:54 -0500
Date: Thu, 19 Feb 2004 11:21:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, Andrew Morton <akpm@osdl.org>,
       linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       thornber@redhat.com
Subject: Re: IO scheduler, queue depth, nr_requests
Message-ID: <20040219102108.GK27190@suse.de>
References: <20040216131609.GA21974@cistron.nl> <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl> <20040218172622.52914567.akpm@osdl.org> <20040219021159.GE30621@drinkel.cistron.nl> <403424A4.3090007@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403424A4.3090007@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19 2004, Nick Piggin wrote:
> 
> 
> Miquel van Smoorenburg wrote:
> 
> >
> >No, I'm actually referring to a struct request. I'm logging this in the
> >SCSI layer, in scsi_request_fn(), just after elv_next_request(). I have
> >in fact logged all the bio's submitted to __make_request, and the output
> >of the elevator from elv_next_request(). The bio's are submitted 
> >sequentially,
> >the resulting requests aren't. But this is because nr_requests is 128, 
> >while
> >the 3ware device has a queue of 254 entries (no tagging though). Upping
> >nr_requests to 512 makes this go away ..
> >
> >That shouldn't be necessary though. I only see this with LVM over 
> >3ware-raid5,
> >not on the 3ware-raid5 array directly (/dev/sda1). And it gets less 
> >troublesome
> >with a lot of debugging (unless I set nr_requests lower again), which 
> >points
> >to a timing issue.
> >
> >
> 
> So the problem you are seeing is due to "unlucky" timing between
> two processes submitting IO. And the very efficient mechanisms
> (merging, sorting) we have to improve situations exactly like this
> is effectively disabled. And to make it worse, it appears that your
> controller shits itself on this trivially simple pattern.
> 
> Your hack makes a baby step in the direction of per *process*
> request limits, which I happen to be an advocate of. As it stands
> though, I don't like it.

I'm very much an advocate for per process request limits as well.  Would
be trivial to add... Miquels patch is horrible, I appreciate it being
posted as a cry for help.

-- 
Jens Axboe


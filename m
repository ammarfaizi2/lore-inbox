Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbREZPlP>; Sat, 26 May 2001 11:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbREZPlF>; Sat, 26 May 2001 11:41:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49931 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261482AbREZPky>;
	Sat, 26 May 2001 11:40:54 -0400
Date: Sat, 26 May 2001 17:40:54 +0200
From: Jens Axboe <axboe@suse.de>
To: A Duston <hald@sound.net>
Cc: "Gortmaker, Paul" <p_gortmaker@yahoo.com>,
        "Andersen, Rasmus" <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: PS/2 Esdi patch #8
Message-ID: <20010526174054.F553@suse.de>
In-Reply-To: <Pine.GSO.4.10.10105231748550.23376-200000@sound.net> <3B0D733F.1829DC88@yahoo.com> <20010525164615.C14899@suse.de> <3B0FC26B.D210E416@sound.net> <20010526165800.C553@suse.de> <3B0FCCDD.5B5A891C@sound.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B0FCCDD.5B5A891C@sound.net>; from hald@sound.net on Sat, May 26, 2001 at 10:33:49AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26 2001, A Duston wrote:
> >  and so it continues. This is the easy way to process requests. However,
> >  if you can start I/O on more than one buffer at the time (scatter
> >  gather), you could then setup your sg tables by browsing the entire
> >  request buffer_head list and initiate I/O as needed.
> >
> >  Bigger requests on the queue, means more I/O in progress being possible.
> >  There's no rule that you have to finish a request in one go, so even if
> >  you can only handle eg 64 sectors per request with sg, you could do
> >  just start I/O on as many segments as you can and simply don't dequeue
> >  the request until it's completely done. So the max_sectors patch is
> >  never really needed if you know what you are doing.
> 
> Can I still gain any advantage if the hardware can only have one I/O inflight
> per device?  I am not sure the ps2esdi interface supports this.

Not really, and especially for a slow interface like ps2esdi :-)

There's a small optimization possible for ps2esdi I see, but the chance
of it happening in real life is probably pretty slim. Even if you can't
do sg and you can't have more than one command pending, you could still
be lucky and do I/O to more than ->buffer provided that bh1 and bh2 etc
are contigous in memory. For a 4kB fs the chances are close to 0 that
this will happen once the system has been up for a little while (and
memory starts to fragment). For a 1kB fs the chances are probably
bigger.

If I were you, I'd leave it the way it is now. As long as you work on
current_nr_sectors, the only thing that Paul's patch will accomplish is
make the queue smaller. It will buy you nothing.

-- 
Jens Axboe


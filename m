Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbSI0GvI>; Fri, 27 Sep 2002 02:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbSI0GvI>; Fri, 27 Sep 2002 02:51:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44780 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261326AbSI0GvG>;
	Fri, 27 Sep 2002 02:51:06 -0400
Date: Fri, 27 Sep 2002 08:56:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthew Jacob <mjacob@feral.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file transfers
Message-ID: <20020927065610.GQ5646@suse.de>
References: <20020927063616.GO5646@suse.de> <Pine.BSF.4.21.0209262344250.17672-100000@beppo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.21.0209262344250.17672-100000@beppo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26 2002, Matthew Jacob wrote:
> 
> > > > scsi_dma crap. That said, 253 default depth is a bit over the top, no?
> > > 
> > > Why? Something like a large Hitachi 9*** storage system can take ~1000
> > > tags w/o wincing.
> > 
> > Yeah, I bet that most of the devices attached to aic7xxx controllers are
> > exactly such beasts.
> > 
> > I didn't say that 253 is a silly default for _everything_, I think it's
> > a silly default for most users.
> > 
> 
> Well, no, I'm not sure I agree. In the expected life time of this
> particular set of software that gets shipped out, the next generation of
> 100GB or better disk drives will be attached, and they'll likely eat all
> of that many tags too, and usefully, considering the speed and bit
> density of drives. For example, the current U160 Fujitsu drives will
> take ~130 tags before sending back a QFULL.

Just because a device can eat XXX number of tags does definitely _not_
make it a good idea. At least not if you care the slightest bit about
latency.

> On the other hand, we can also find a large class of existing devices
> and situations where anything over 4 tags is overload too.
> 
> With some perspective on this, I'd have to say that in the last 25 years
> I've seen more errors on the side of 'too conservative' for limits
> rather than the opposite.

At least for this tagging discussion, I'm of the exact opposite
oppinion. What's the worst that can happen with a tag setting that is
too low? Theoretical loss of disk bandwidth. I say theoretical, because
it's not even given that tags are that much faster then the Linux io
scheduler. More tags might even give you _worse_ throughput, because you
end up leaving the io scheduler with much less to work on (if you have a
253 depth to you device, you have 3 requests left for the queue...).

So I think the 'more tags the better!' belief is very much bogus, at
least for the common case.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbRGKOvU>; Wed, 11 Jul 2001 10:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266708AbRGKOvK>; Wed, 11 Jul 2001 10:51:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43196 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267326AbRGKOu6>; Wed, 11 Jul 2001 10:50:58 -0400
Date: Wed, 11 Jul 2001 20:25:36 +0530
From: Dipankar Sarma <dipankar@sequent.com>
To: Jens Axboe <axboe@suse.de>
Cc: Mike Anderson <mike.anderson@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711202536.H9220@in.ibm.com>
Reply-To: dipankar@sequent.com
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010710160512.A25632@us.ibm.com> <20010711142311.B9220@in.ibm.com> <20010711105339.F17314@suse.de> <20010711193256.G9220@in.ibm.com> <20010711160148.A712@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010711160148.A712@suse.de>; from axboe@suse.de on Wed, Jul 11, 2001 at 04:01:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Wed, Jul 11, 2001 at 04:01:48PM +0200, Jens Axboe wrote:
> On Wed, Jul 11 2001, Dipankar Sarma wrote:
> > On Wed, Jul 11, 2001 at 10:53:39AM +0200, Jens Axboe wrote:
> > > The queue lengths should always be long enough to keep the hw busy of
> > > course. And in addition, the bigger the queues the bigger the chance of
> > > skipping seeks due to reordering. But don't worry, I've scaled the queue
> > > lengths so I'm pretty sure that they are always on the safe side in
> > > size.
> > > 
> > > It's pretty easy to test for yourself if you want, just change
> > > QUEUE_NR_REQUESTS in blkdev.h. It's currently 8192, the request slots
> > > are scaled down from this value. 8k will give you twice the amount of
> > > slots that you have RAM in mb, ie 2048 on a 1gig machine.
> > > 
> > > block: queued sectors max/low 683554kB/552482kB, 2048 slots per queue
> > 
> > Hmm.. The tiobench run was done on a 1GB machine and we still ran
> > out of request slots. Will investigate.
> 
> Sure, that's to be expected. If we never ran out we would be wasting
> memory. My point is that you should rerun the same test with more
> request slots -- and I'd be surprised if you gained any significant
> performance on that account. I never said that you'd never run out,
> that's of course not true. In fact, running out is what starts the I/O
> typically on a 1GB machine and bigger.

I agree that running out of slots don't necessarily mean anything. I
was just wondering about the queue lengths. On the face of it, 2048 
requests pending for a single disk seems like a fairly large queue length.
Is this all related to plugging of queues for disk block optimization ?

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@sequent.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262939AbSJBCuC>; Tue, 1 Oct 2002 22:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262938AbSJBCuB>; Tue, 1 Oct 2002 22:50:01 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:34533 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262939AbSJBCuA>;
	Tue, 1 Oct 2002 22:50:00 -0400
Message-ID: <1033527322.3d9a601aa7795@kolivas.net>
Date: Wed,  2 Oct 2002 12:55:22 +1000
From: Con Kolivas <conman@kolivas.net>
To: Jens Axboe <axboe@suse.de>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.39-mm1
References: <3D9976D9.C06466B@digeo.com> <200209301941.41627.conman@kolivas.net> <20021001101520.GB20878@suse.de> <3D9976D9.C06466B@digeo.com> <5.1.0.14.2.20021001190123.00b3cdc8@pop.gmx.net> <20021001172200.GH5755@suse.de>
In-Reply-To: <20021001172200.GH5755@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jens Axboe <axboe@suse.de>:

> On Tue, Oct 01 2002, Mike Galbraith wrote:
> > At 10:19 PM 10/1/2002 +1000, Con Kolivas wrote:
> > >On Tuesday 01 Oct 2002 8:20 pm, Andrew Morton wrote:
> > >> Jens Axboe wrote:
> > >> > On Mon, Sep 30 2002, Andrew Morton wrote:
[snip]
> > >> > >
> > >> > > I think I'll set fifo_batch to 16 again...
> > >> >
> > >> > As not to compare oranges and apples, I'd very much like to see a
> > >> > 2.5.39-mm1 vs 2.5.39-mm1 with fifo_batch=16. Con, would you do that?
> > >> > Thanks!
> > >>
> > >> The presence of /proc/sys/vm/fifo_batch should make that pretty easy.
> > >
> > >Thanks. That made it a lot easier and faster, and made me curious enough
> to
> > >create a family or very interesting results. All these are with
> 2.5.39-mm1
> > >with fifo_batch set to 1->16, average of three runs. The first result is
[snip]
> > >What's most interesting is the variation was small until the number was
> <8;
> > >then the variation between runs increased. Dare I say it there appears to
> 
> > >be
> > >a sweet spot in the results.
> > 
> > What's more interesting (methinks) is the huge difference between 32 and 
> > 16.  Have you played with values between 32 and 16?  (/me wonders if 
> > there's a cliff or a gentle slope)
> 
> As I wrote in response, the difference is that 16 == seek_cost. So
> fifo_batch of 16 will allow 1 seek, fifo_batch of 32 will allow two.
> This is the reason for the big drop at that point. I would expect 31 to
> be pretty close to 16.

Ok well I've got the answer to both questions. I've removed the other results
from this email for clarity, and here is a more complete family (average of 2 or
3 runs):

io_load:
Kernel                  Time            CPU%            Ratio
2539mm1fb01             125.4           60              1.85
2539mm1fb02             112.7           65              1.66
2539mm1fb04             146.4           51              2.16
2539mm1fb08             109.1           68              1.61
2539mm1fb10             204.3           63              3.02
2539mm1fb12             210.3           60              3.10
2539mm1fb14             192.6           66              2.85
2539mm1fb16             131.2           57              1.94
2539mm1fb18             209.7           61              3.10
2539mm1fb20             221.8           57              3.27
2539mm1fb22             262.3           48              3.88
2539mm1fb24             264.0           48              3.90
2539mm1fb26             258.7           50              3.82
2539mm1fb28             307.4           42              4.54
2539mm1fb30             319.4           40              4.71
2539mm1fb31             294.4           44              4.34
2539mm1fb32             239.5           32              3.54

For my machine at least it appears that falling outside the powers of 2 is not good.

Con

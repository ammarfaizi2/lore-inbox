Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282957AbRK0VZK>; Tue, 27 Nov 2001 16:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282958AbRK0VY6>; Tue, 27 Nov 2001 16:24:58 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:33785
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282957AbRK0VYm>; Tue, 27 Nov 2001 16:24:42 -0500
Date: Tue, 27 Nov 2001 13:24:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ahmed Masud <masud@googgun.com>, "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011127132435.G9391@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Ahmed Masud <masud@googgun.com>,
	'lkml' <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111261825340.15932-100000@xanadu.home> <000901c17723$b641c990$8604a8c0@googgun.com> <3C03C96D.B3ACA982@zip.com.au>, <3C03C96D.B3ACA982@zip.com.au> <20011127123128.E9391@mikef-linux.matchmail.com> <3C03FE2F.63D7ACFD@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C03FE2F.63D7ACFD@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 12:57:19PM -0800, Andrew Morton wrote:
> Mike Fedyk wrote:
> > 
> > >   I'll send you a patch which makes the VM less inclined to page things
> > >   out in the presence of heavy writes, and which decreases read
> > >   latencies.
> > >
> > Is this patch posted anywhere?
> 
> I sent it yesterday, in this thread.  Here it is again.
>

Yep, saw it.  I didn't realize (didn't read patch) that it modified the VM
swapping. 

> Description:
> 
> - Account for locked as well as dirty buffers when deciding
>   to throttle writers.
> 
> - Tweak VM to make it work the inactive list harder, before starting
>   to evict pages or swap.
> 
> - Change the elevator so that once a request's latency has
>   expired, we can still perform merges in front of that
>   request.  But we no longer will insert new requests in
>   front of that request.  
> 
> - Modify elevator so that new read requests do not have
>   more than N write requests placed in front of them, where
>   N is tunable per-device with `elvtune -b'.
> 
>   Theoretically, the last change needs significant alterations
>   to the readhead code.  But a rewrite of readhead made negligible
>   difference (I wasn't able to trigger the failure scenario).
>   Still crunching on this.
>

Sounds great.

I'll test it out.

MF

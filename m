Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266227AbRF3Rrz>; Sat, 30 Jun 2001 13:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbRF3Rrp>; Sat, 30 Jun 2001 13:47:45 -0400
Received: from [192.48.153.1] ([192.48.153.1]:41262 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S266227AbRF3RrZ>;
	Sat, 30 Jun 2001 13:47:25 -0400
Message-Id: <200106301748.f5UHmLs03109@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>
cc: Steve Lord <lord@sgi.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bounce buffer deadlock 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Sat, 30 Jun 2001 10:39:59 PDT." <Pine.LNX.4.33.0106301032170.1470-100000@penguin.transmeta.com> 
Date: Sat, 30 Jun 2001 12:48:21 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, 30 Jun 2001, Steve Lord wrote:
> >
> > It looks to me as if all memory allocations of type GFP_BUFFER which happen
> > in generic_make_request downwards can hit the same type of deadlock, so
> > bounce buffers, the request functions of the raid and lvm paths can all
> > end up in try_to_free_buffers on a buffer they themselves hold the lock on.
> 
> .. which is why GFP_BUFFER doesn't exist any more in the most recent
> pre-kernels (oops, this is pre8 only, not pre7 like I said in the previous
> email)
> 
> The problem is that GFP_BUFFER used to mean two things: "don't call
> low-level filesystem" and "don't do IO". Some of the pre-kernels starting
> to make it mean "don't call low-level FS" only. The later ones split up
> the semantics, so that the cases which care about FS deadlocks use
> "GFP_NOFS", and the cases that care about IO recursion use "GFP_NOIO", so
> that we don't overload the meaning of GFP_BUFFER.
> 
> That allows us to do the best we can - still flushing out dirty buffers
> when that's ok (like when a filesystem wants more memory), and giving the
> allocator better control over exactly _what_ he objects to.
> 
> 		Linus

OK, sounds reasonable, time to go download and merge again I guess!

Steve




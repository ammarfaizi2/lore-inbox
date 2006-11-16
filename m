Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424633AbWKPVVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424633AbWKPVVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424628AbWKPVVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:21:39 -0500
Received: from brick.kernel.dk ([62.242.22.158]:55898 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1424633AbWKPVVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:21:38 -0500
Date: Thu, 16 Nov 2006 22:21:07 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: David Miller <davem@davemloft.net>
Cc: jaschut@sandia.gov, linux-kernel@vger.kernel.org
Subject: Re: splice/vmsplice performance test results
Message-ID: <20061116212107.GK7164@kernel.dk>
References: <1163700539.2672.14.camel@sale659.sandia.gov> <20061116.155224.08323028.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116.155224.08323028.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16 2006, David Miller wrote:
> From: "Jim Schutt" <jaschut@sandia.gov>
> Date: Thu, 16 Nov 2006 11:08:59 -0700
> 
> > Or is read+write really the fastest way to get data off a
> > socket and into a file?
> 
> There is still no explicit TCP support for splice/vmsplice so things
> get copied around and most of the other advantaves of splice/vmplice
> aren't obtained either.  So perhaps that explains your numbers.

There should not be any copying for tcp send, at least no more than what
sendfile() did/does. Hmm?

> Jens Axboe tries to get things working, and others have looked into it
> too, but adding TCP support is hard and for several reasons folks like
> Alexey Kuznetsov and Evgeniy Polyakov believe that sys_receivefile()
> is an interface much better suited for TCP receive.
> 
> splice/vmsplice has a lot of state connected to a transaction, and
> perhaps that is part of why Evgeniy and Alexey have trouble wrapping
> their brains around an efficient implementation.

I hope to try and see if I can help get some of that done, however I
need all the help I can get on the networking side. Not sure I
understand why it has to be so difficult, if we need to define a wrapper
container instead of passing down a pipe that is completely fine with
me. The networking code basically just needs to hang on to the
pipe_buffer and release it on ack for send, receive is somewhat more
involved (and I don't know enough about networking to voice any
half-intelligent opinion on that!).

I would just consider it a damn shame if we cannot complete the splice
family and need to punt to something else for net receive.

-- 
Jens Axboe


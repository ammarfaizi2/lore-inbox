Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTE0B2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTE0B2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:28:17 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:34532 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262456AbTE0B2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:28:15 -0400
Date: Mon, 26 May 2003 22:41:24 -0300
From: Rodrigo Souza de Castro <rcastro@ime.usp.br>
To: Con Kolivas <kernel@kolivas.org>
Cc: Kimmo Sundqvist <rabbit80@mbnet.fi>, linux-kernel@vger.kernel.org,
       linuxcompressed-devel@lists.sourceforge.net
Subject: Re: [2.4.20-ck7] good compressed caching experience
Message-ID: <20030527014124.GE3388@bach>
Mail-Followup-To: Rodrigo Souza de Castro <rcastro@ime.usp.br>,
	Con Kolivas <kernel@kolivas.org>,
	Kimmo Sundqvist <rabbit80@mbnet.fi>, linux-kernel@vger.kernel.org,
	linuxcompressed-devel@lists.sourceforge.net
References: <200305262150.04552.rabbit80@mbnet.fi> <200305270711.34608.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305270711.34608.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

On Tue, May 27, 2003 at 07:11:34AM +1000, Con Kolivas wrote:
> On Tue, 27 May 2003 04:50, Kimmo Sundqvist wrote:
> > I just decided to tell everyone that I've been able to run 2.4.20-ck7 with
> > compressed caching enabled in my little brother's Pentium 133MHz, for
> > hours, doing stress testing, compiling kernels and using the Internet under
> > X.
> >
> > I had pre-empt enabled.  Compressed swap worked also.  I used 4kB pages
> > without compressed swap, and 8kB with it.
[snip]
> > exclusive), 1GB of RAM but "mem=128M" for testing purposes.  Been stable
> > for 6 hours now, and done even some stress testing.  Try 128 instances of
> > burnBX with 1MB each, like "for ((A=128;A--;A<1)) do burnBX J & done".  A
> > nice brute force or "if you don't behave I'll push all my buttons" method
> > :)
> >
> > Wondering if Pentium 133MHz (64MB RAM) is fast enough to benefit from
> > compressed caching.  I know there's a limit, depending on the speed of the
> > CPU and the speed of the swap partition (doing random accesses), which
> > determines if compressed caching is beneficial or not.
[snip]
> What you describe has been my experience with cc as well. I haven't
> had any crashes or unusual problems with it since removing the AA vm
> changes as well - it seemed to be the combination that caused
> hiccups on extreme testing.

Something to be figured out yet. It is a pity we couldn't work harder
on these problems.

> >From what I can see, no matter how slow your cpu you will still get
> benefit from cc as the hard drives on those machines are
> proportionately slower as well.

I guess that, in the past, the gap was smaller, but still there.

> The one limitation of cc is that it does require _some_ ram to
> actually store swap pages in, and it seems that you need more than
> 32Mb ram to start deriving benefit.

I am not sure. It requires some ram, but it is only a few pages to
avoid failed page allocations when it first needs to allocate pages. I
have a report of running CC on a laptop with 8M RAM, that showed to be
a little more responsive. I don't have a scientific results showing
that is better on system with a lower amount of memory, but this
feedback seems positive.

> One minor thing, though - my vm hacks make compressed caching work
> much less than it normally does as they try to avoid swapping quite
> aggressively. It is when the vm attempts to start swapping that cc
> looks to see if it should take pages into compressed cache instead.

What exactly are your VM hacks concerning CC? The default behaviour is
to compress pages only when the VM starts freeing pages, not in a
compress-ahead fashion, pretty much what I think you said above.

> I've cc'ed the actual developer of cc as he has indicated that he is
> actively working on compressed caching again.

At a slower pace, but finally back to CC development. :-)

> > Just a warning... both systems have only ReiserFS partitions.
> > Other FSes might still get hurt.
> 
> This is definitely the case! If you try out compressed caching with
> ck7 please do not enable preempt if you are using ext2/3 or vfat.

As told in a previous email, I wouldn't enable preempt in any case
with this code version.

Regards,
-- 
Rodrigo



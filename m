Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTE0DWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 23:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTE0DWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 23:22:49 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:3230 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263025AbTE0DWq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 23:22:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Rodrigo Souza de Castro <rcastro@ime.usp.br>
Subject: Re: [2.4.20-ck7] good compressed caching experience
Date: Tue, 27 May 2003 13:37:20 +1000
User-Agent: KMail/1.5.1
Cc: Kimmo Sundqvist <rabbit80@mbnet.fi>, linux-kernel@vger.kernel.org,
       linuxcompressed-devel@lists.sourceforge.net
References: <200305262150.04552.rabbit80@mbnet.fi> <200305270711.34608.kernel@kolivas.org> <20030527014124.GE3388@bach>
In-Reply-To: <20030527014124.GE3388@bach>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305271337.20465.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003 11:41, Rodrigo Souza de Castro wrote:
> Hi Con,
>
> On Tue, May 27, 2003 at 07:11:34AM +1000, Con Kolivas wrote:
> > On Tue, 27 May 2003 04:50, Kimmo Sundqvist wrote:
> > > I just decided to tell everyone that I've been able to run 2.4.20-ck7
> > > with compressed caching enabled in my little brother's Pentium 133MHz,
> > > for hours, doing stress testing, compiling kernels and using the
> > > Internet under X.
> > >
> > > I had pre-empt enabled.  Compressed swap worked also.  I used 4kB pages
> > > without compressed swap, and 8kB with it.
>
> [snip]
>
> > > exclusive), 1GB of RAM but "mem=128M" for testing purposes.  Been
> > > stable for 6 hours now, and done even some stress testing.  Try 128
> > > instances of burnBX with 1MB each, like "for ((A=128;A--;A<1)) do
> > > burnBX J & done".  A nice brute force or "if you don't behave I'll push
> > > all my buttons" method
> > >
> > > :)
> > >
> > > Wondering if Pentium 133MHz (64MB RAM) is fast enough to benefit from
> > > compressed caching.  I know there's a limit, depending on the speed of
> > > the CPU and the speed of the swap partition (doing random accesses),
> > > which determines if compressed caching is beneficial or not.
>
> [snip]
>
> > What you describe has been my experience with cc as well. I haven't
> > had any crashes or unusual problems with it since removing the AA vm
> > changes as well - it seemed to be the combination that caused
> > hiccups on extreme testing.
>
> Something to be figured out yet. It is a pity we couldn't work harder
> on these problems.

I think getting the stability necessary on the main tree was far more 
important so I don't regret this.

>
> > >From what I can see, no matter how slow your cpu you will still get
> >
> > benefit from cc as the hard drives on those machines are
> > proportionately slower as well.
>
> I guess that, in the past, the gap was smaller, but still there.
>
> > The one limitation of cc is that it does require _some_ ram to
> > actually store swap pages in, and it seems that you need more than
> > 32Mb ram to start deriving benefit.
>
> I am not sure. It requires some ram, but it is only a few pages to
> avoid failed page allocations when it first needs to allocate pages. I
> have a report of running CC on a laptop with 8M RAM, that showed to be
> a little more responsive. I don't have a scientific results showing
> that is better on system with a lower amount of memory, but this
> feedback seems positive.
>
> > One minor thing, though - my vm hacks make compressed caching work
> > much less than it normally does as they try to avoid swapping quite
> > aggressively. It is when the vm attempts to start swapping that cc
> > looks to see if it should take pages into compressed cache instead.
>
> What exactly are your VM hacks concerning CC? The default behaviour is
> to compress pages only when the VM starts freeing pages, not in a
> compress-ahead fashion, pretty much what I think you said above.

Ok, I didn't look at your code, but that would make sense too because with my 
hacks it will start even lower priority than the default VM freeing less 
pages at a time unless the memory pressure gets high.

>
> > I've cc'ed the actual developer of cc as he has indicated that he is
> > actively working on compressed caching again.
>
> At a slower pace, but finally back to CC development. :-)

Excellent. Good to have you back.
>
> > > Just a warning... both systems have only ReiserFS partitions.
> > > Other FSes might still get hurt.
> >
> > This is definitely the case! If you try out compressed caching with
> > ck7 please do not enable preempt if you are using ext2/3 or vfat.
>
> As told in a previous email, I wouldn't enable preempt in any case
> with this code version.

-ck has always come with a warning saying as much. I hope to integrate more of 
your code when you're happy with it, so this problem can be resolved.

Cheers,
Con

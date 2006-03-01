Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbWCAAfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbWCAAfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWCAAfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:35:05 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:26597
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932634AbWCAAfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:35:04 -0500
Date: Tue, 28 Feb 2006 16:34:52 -0800
From: Greg KH <greg@kroah.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, perex@suse.cz, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060301003452.GG23716@kroah.com>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org> <20060227234525.GA21694@suse.de> <20060228063207.GA12502@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228063207.GA12502@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 01:32:07AM -0500, Theodore Ts'o wrote:
> On Mon, Feb 27, 2006 at 03:45:25PM -0800, Greg KH wrote:
> > > So I just don't see any upsides to documenting anything private or 
> > > unstable. I see only downsides: it's an excuse to hide behind for 
> > > developers.
> > 
> > So should we just not even document anything we consider "unstable"?
> > The first trys at things are usually really wrong, and that only can be
> > detected after we've tried it out for a while and have a few serious
> > users.  Should we brand anything new as "testing" if the developer feels
> > it is ready to go?
> 
> How about "we don't let anything into mainline that we consider
> 'unstable' from an interface point of view"?

In a perfect world, where we are all kick-ass programmers and never get
anything wrong and can always anticipate exactly how people will use the
interfaces we create, sure we could say this.

But until then, there's no way this can happen :)

For example, look at all of the gyrations that the sys_futex call went
through.  It took people really using the thing before the final version
of how it would work could be added.

And another example, /proc.  How many times over the past 15 years have
we had to upgrade the procps package to handle the addition or change of
one thing or another?  We evolve over time to handle the issues that
come up with different architectures and needs.  That's what makes Linux
so great.

Now remember, this is only a very small subset of programs that fall
into this "changing interface" category.  For 99% of the programs that
run out there, they only use the standard POSIX syscall api, and they
never change (Binaries built for Caldera 1.0 still run on 2.6 this day
as proof of that.)

But everyone here on this list feels the issues as we are doing the
development of this system.  It is a real system, consisting of parts
that are outside of the kernel in order for everything to work properly.

And if we want to pull some of those pieces into the kernel tree proper,
in order to handle the change and churn better, that's fine with me too,
but is outside the scope of this classification document.

> There seems to be a fetish going on today that everything possible
> should be mindlessly pushed out into userspace regardless of whether
> or not it makes sense.

It's not a "new" fetish at all, look at the huge number of ioctls, proc
files, sysctls, mmap interfaces to devices, etc.  It's just that the
list of these interfaces has never been fully documented or classified
(find any DRI/DRM interface docs in the kernel tree lately?)

Hopefully this proposal will help address the need for figuring out what
is changing in the kernel, and help userspace programmers to know what
they can and can not count on remaining stable in the future, both near
and far.

> If we're not sure we can get the interface right, then maybe it's a
> sign it needs to stay in -mm longer, or maybe we were trying to push
> the wrong thing out into userspace.  If the interface isn't easy to
> understand, and we aren't confident that we can promise to never
> change it once we put it out there (although of course we can always
> add additional interfaces as we add new features), then maybe the
> mistake was in trying to create the interface in the first place.

The "stay in -mm" statement is nice, but unfortunately will not really
help.  Look at how many people really run and test -mm.  What is it, in
the low 100s at the most?  And we have how many, 900+ individually
documented kernel contributors over the lifetime of the kernel?  Even if
all of them run -mm, we would not have the spread or reach that we
really need to be able to classify interfaces as "stable" all the time.
All of those developers are working on their individual pieces and
rarely look up and see what else is going on around in the kernel.

thanks,

greg k-h

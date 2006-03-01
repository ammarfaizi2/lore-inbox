Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWCABRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWCABRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 20:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWCABRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 20:17:55 -0500
Received: from sccrmhc14.comcast.net ([63.240.77.84]:19653 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751367AbWCABRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 20:17:55 -0500
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
From: Nicholas Miell <nmiell@comcast.net>
To: Greg KH <greg@kroah.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, perex@suse.cz, Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20060301003452.GG23716@kroah.com>
References: <20060227190150.GA9121@kroah.com>
	 <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de>
	 <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org>
	 <20060227234525.GA21694@suse.de> <20060228063207.GA12502@thunk.org>
	 <20060301003452.GG23716@kroah.com>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 17:17:49 -0800
Message-Id: <1141175870.2989.17.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 16:34 -0800, Greg KH wrote:
> On Tue, Feb 28, 2006 at 01:32:07AM -0500, Theodore Ts'o wrote:
> > On Mon, Feb 27, 2006 at 03:45:25PM -0800, Greg KH wrote:
> > > > So I just don't see any upsides to documenting anything private or 
> > > > unstable. I see only downsides: it's an excuse to hide behind for 
> > > > developers.
> > > 
> > > So should we just not even document anything we consider "unstable"?
> > > The first trys at things are usually really wrong, and that only can be
> > > detected after we've tried it out for a while and have a few serious
> > > users.  Should we brand anything new as "testing" if the developer feels
> > > it is ready to go?
> > 
> > How about "we don't let anything into mainline that we consider
> > 'unstable' from an interface point of view"?
> 
> In a perfect world, where we are all kick-ass programmers and never get
> anything wrong and can always anticipate exactly how people will use the
> interfaces we create, sure we could say this.
> 
> But until then, there's no way this can happen :)
> 
> For example, look at all of the gyrations that the sys_futex call went
> through.  It took people really using the thing before the final version
> of how it would work could be added.
> 
> And another example, /proc.  How many times over the past 15 years have
> we had to upgrade the procps package to handle the addition or change of
> one thing or another?  We evolve over time to handle the issues that
> come up with different architectures and needs.  That's what makes Linux
> so great.

This is a really bad example.

All the /proc related contortions are a direct result of the fact that
the multitudes of /proc "formats" are completely undocumented,
non-extensible, and largely unintended for programmatic usage[1]. (/sys
was supposed to solve some of these things, but it seems to be going the
same route, unfortunately.)

Honestly, despite what the ASCII fetish crowd[2] may say, Solaris got it
right by just exporting C structs. The parsing is certainly a hell of a
lot easier when you're dealing with actual C datatypes instead of
character strings and people hacking on /proc are probably less likely
to make ABI breaking changes when they're dealing with a struct instead
of a sprintf statement.





[1] Where's my EBNF?

[2] "But ASCII is easily manipulated by shell tools!!!!"
 Well, then write a very small C program that spits out ASCII and stick
it in procps.


-- 
Nicholas Miell <nmiell@comcast.net>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWB0Xpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWB0Xpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWB0Xpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:45:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:29317 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751780AbWB0Xpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:45:51 -0500
Date: Mon, 27 Feb 2006 15:45:25 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, perex@suse.cz, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227234525.GA21694@suse.de>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 12:20:49PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 27 Feb 2006, Greg KH wrote:
> 
> > On Mon, Feb 27, 2006 at 02:36:54PM -0500, Benjamin LaHaise wrote:
> > > On Mon, Feb 27, 2006 at 11:01:50AM -0800, Greg KH wrote:
> > > > --- /dev/null
> > > > +++ gregkh-2.6/Documentation/ABI/private/alsa
> > > > @@ -0,0 +1,8 @@
> > > > +What:		Kernel Sound interface
> > > > +Date:		Feburary 2006
> > > > +Who:		Jaroslav Kysela <perex@suse.cz>
> > > > +Description:
> > > > +		The use of the kernel sound interface must be done
> > > > +		through the ALSA library.  For more details on this,
> > > > +		please see http://www.alsa-project.org/ and contact
> > > > +		<alsa-devel@alsa-project.org>
> > > 
> > > How can something as widely used as sound not work from one kernel version 
> > > to the next, as seems to be implied with the "private" nature of the ABI?  
> > > This is a total cop-out and is IMHO very amateur of the developers.  If 
> > > something like this is to be the case, at the very least the alsa libraries 
> > > need to provide a stable ABI and be shipped with the kernel.
> > 
> > Then I suggest you work with the ALSA developers to come up with such a
> > "stable" api that never changes.  They have been working at this for a
> > number of years, if it was a "simple" problem, it would have been done
> > already...
> 
> I really don't much like the "private" and "unstable" subdirectories.
> 
> They seem to be just excuses for bad habits. And the notion of a "private" 
> interface is insane anyway, since it doesn't matter - the only thing that 
> matters is whether it breaks existing binaries or not, and being "private" 
> in no way makes any difference to that. If you need to compile or link 
> against a new library, it's broken - whether it was "private" or not makes 
> no difference.

Ok, I don't mind the name change from something different than
"private".  I was looking for something to call the interface between
the user and kernel that almost all userspace programs should be using
the library instead of the "raw" kernel interface.  ALSA and netlink are
two examples of this, and I'm sure there's others.

We will probably have more of these in the future, and if they need to
move their "library" into the kernel tree, that's fine too.

> The ALSA development model is in my opinion pretty broken (the development 
> seems to try to be pretty closed-up), but it's (a) gotten better and (b) 
> the alsa people do not seem to be breaking old binaries and libraries very 
> much. At least I don't remember seeing all that many problems lately.

Yes, ALSA has gotten a lot better.  But what about the next project that
comes along that has the same kind of binding and it takes a year or so
to figure out the way that the interface should work as no one has ever
done that kind of interface before?  For the majority of things that
people have been complaining about, this has never been done by any
operating system before, the others don't have these problems as they
don't even try :)

> So I just don't see any upsides to documenting anything private or 
> unstable. I see only downsides: it's an excuse to hide behind for 
> developers.

So should we just not even document anything we consider "unstable"?
The first trys at things are usually really wrong, and that only can be
detected after we've tried it out for a while and have a few serious
users.  Should we brand anything new as "testing" if the developer feels
it is ready to go?

thanks,

greg k-h

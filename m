Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318727AbSHAMGQ>; Thu, 1 Aug 2002 08:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318722AbSHAMFd>; Thu, 1 Aug 2002 08:05:33 -0400
Received: from [195.39.17.254] ([195.39.17.254]:15488 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318727AbSHAMFB>;
	Thu, 1 Aug 2002 08:05:01 -0400
Date: Thu, 1 Aug 2002 12:30:11 +0200
From: Pavel Machek <pavel@elf.ucw.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)
Message-ID: <20020801103011.GB159@elf.ucw.cz>
References: <20020730054111.GA1159@dualathlon.random> <20020730084939.A8978@redhat.com> <20020730214116.GN1181@dualathlon.random> <20020730175421.J10315@redhat.com> <20020731004451.GI1181@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020731004451.GI1181@dualathlon.random>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Can you point me out to a patch with the new cancellation API that you
> > > agree with for merging in 2.5 so I can synchronize? I'm reading your
> > > very latest patch loaded on some site in June. that will be really
> > > helpful, many thanks!
> > 
> > Here is what I've got for the aio core that has the cancellation 
> > change to return the completion event.  The other slight change that 
> > I meant to get in before going into the mainstream is to have the 
> > timeout io_getevents takes be an absolute timeout, which helps for 
> > applications that have specific deadlines they are attempting to 
> > schedule to (think video playback).  This drop is untested, but I'd 
> 
> are you sure this is a good idea? this adds an implicit gettimeofday
> (thought no entry/exit kernel) to every getevents syscall with a
> "when" specificed, so the user may now need to do gettimeofday both
> externally and internally to use the previous "timeout" feature (given
> the kernel can delay only of a timeout, so the kernel has to calculate
> the timeout internally now). I guess I prefer the previous version that
> had the "timeout" information instead of "when". Also many soft
> multimedia only expect the timeout to take "timeout", and if a frame
> skips they'll just slowdown the frame rate, so they won't be real time
> but you'll see something on the screen/audio. Otherwise they can keep
> timing out endlessy if they cannot keep up with the stream, and they
> will show nothing rather than showing a low frame rate.
> 
> So I'm not very excited about this change, I would prefer the previous
> version. Also consider with the vsyscall doing the gettimeofday
> calculation in userspace based on "when" rather than in-kernel isn't
> going to be more expensive than your new API even of applications that
> really want the "when" behaviour instead of the "timeout". While the
> applications that wants the "timeout" this way we'll be forced to a
> vgettimeofday in userspace and one in kernel which is a pure overhead
> for them.

I believe Linus actually explained why "when" looks way better to him
than "timeout". [It does not skew, for example.]
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org

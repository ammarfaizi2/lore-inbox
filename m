Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbSJJO6h>; Thu, 10 Oct 2002 10:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbSJJO6h>; Thu, 10 Oct 2002 10:58:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20850 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261607AbSJJO6g>; Thu, 10 Oct 2002 10:58:36 -0400
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
References: <Pine.LNX.4.44.0210091613590.9234-100000@home.transmeta.com>
	<3DA4BECB.9C7D6119@mvista.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Oct 2002 09:03:06 -0600
In-Reply-To: <3DA4BECB.9C7D6119@mvista.com>
Message-ID: <m14rbunxp1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> writes:

> Linus Torvalds wrote:
> > 
> > On Wed, 9 Oct 2002, george anzinger wrote:
> > >
> > > This patch, in conjunction with the "core" high-res-timers
> > > patch implements high resolution timers on the i386
> > > platforms.
> > 
> > I really don't get the notion of partial ticks, and quite frankly, this
> > isn't going into my tree until some major distribution kicks me in the
> > head and explains to me why the hell we have partial ticks instead of just
> > making the ticks shorter.
> > 
> Well, the notion is to provide timers that have resolution
> down into the micro seconds.  Since this take a bit more
> overhead, we just set up an interrupt on an as needed
> basis.  This is why we define both a high res and a low res
> clock.  Timers on the low res clock will always use the 1/HZ
> tick to drive them and thus do not introduce any additional
> overhead.  If this is all that is needed the configure
> option can be left off and only these timers will be
> available.
> 
> On the other hand, if a user requires better resolution,
> s/he just turns on the high-res option and incures the
> overhead only when it is used and then only at timer expire
> time.  Note that the only way to access a high-res timer is
> via the POSIX clocks and timers API.  They are not available
> to select or any other system call.
> 
> Making ticks shorter causes extra overhead ALL the time,
> even when it is not needed.  Higher resolution is not free
> in any case, but it is much closer to free with this patch
> than by increasing HZ (which, of course, can still be
> done).  Overhead wise and resolution wise, for timers, we
> would be better off with a 1/HZ tick and the "on demand"
> high-res interrupts this patch introduces.

???  The issue of ticks is separate from the issue of how often
timer interrupts fire.  Ticks just becomes the maximum resolution
you can support/express.

If it makes sense to have two maximum tick resolutions.  The normal
application maximum tick rate and the special task maximum tick
rate it is probably worth making this only available as a capability
or an rlimit.

Eric


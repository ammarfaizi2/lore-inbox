Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSJJPkf>; Thu, 10 Oct 2002 11:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbSJJPkf>; Thu, 10 Oct 2002 11:40:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52984 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261615AbSJJPkd>;
	Thu, 10 Oct 2002 11:40:33 -0400
Message-ID: <3DA5A0B3.C9534692@mvista.com>
Date: Thu, 10 Oct 2002 08:45:56 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
References: <Pine.LNX.4.44.0210091613590.9234-100000@home.transmeta.com>
		<3DA4BECB.9C7D6119@mvista.com> <m14rbunxp1.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> george anzinger <george@mvista.com> writes:
> 
> > Linus Torvalds wrote:
> > >
> > > On Wed, 9 Oct 2002, george anzinger wrote:
> > > >
> > > > This patch, in conjunction with the "core" high-res-timers
> > > > patch implements high resolution timers on the i386
> > > > platforms.
> > >
> > > I really don't get the notion of partial ticks, and quite frankly, this
> > > isn't going into my tree until some major distribution kicks me in the
> > > head and explains to me why the hell we have partial ticks instead of just
> > > making the ticks shorter.
> > >
> > Well, the notion is to provide timers that have resolution
> > down into the micro seconds.  Since this take a bit more
> > overhead, we just set up an interrupt on an as needed
> > basis.  This is why we define both a high res and a low res
> > clock.  Timers on the low res clock will always use the 1/HZ
> > tick to drive them and thus do not introduce any additional
> > overhead.  If this is all that is needed the configure
> > option can be left off and only these timers will be
> > available.
> >
> > On the other hand, if a user requires better resolution,
> > s/he just turns on the high-res option and incures the
> > overhead only when it is used and then only at timer expire
> > time.  Note that the only way to access a high-res timer is
> > via the POSIX clocks and timers API.  They are not available
> > to select or any other system call.
> >
> > Making ticks shorter causes extra overhead ALL the time,
> > even when it is not needed.  Higher resolution is not free
> > in any case, but it is much closer to free with this patch
> > than by increasing HZ (which, of course, can still be
> > done).  Overhead wise and resolution wise, for timers, we
> > would be better off with a 1/HZ tick and the "on demand"
> > high-res interrupts this patch introduces.
> 
> ???  The issue of ticks is separate from the issue of how often
> timer interrupts fire.  Ticks just becomes the maximum resolution
> you can support/express.
> 
> If it makes sense to have two maximum tick resolutions.  The normal
> application maximum tick rate and the special task maximum tick
> rate it is probably worth making this only available as a capability
> or an rlimit.
> 
I could support a notion that to use the high-res clock for
a timer the user would need a particular capability.  After
all we do the same for the real time priority.  

Does this get us any closer to acceptance in 2.5?
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

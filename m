Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbTCNWRJ>; Fri, 14 Mar 2003 17:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbTCNWRI>; Fri, 14 Mar 2003 17:17:08 -0500
Received: from ts46-01-qdr3643.mdfrd.or.charter.com ([68.118.36.71]:61720 "EHLO
	mail.flugsvamp.com") by vger.kernel.org with ESMTP
	id <S261206AbTCNWRD>; Fri, 14 Mar 2003 17:17:03 -0500
Date: Fri, 14 Mar 2003 16:27:12 -0600
From: Jonathan Lemon <jlemon@flugsvamp.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <20030314162712.A77383@flugsvamp.com>
References: <local.mail.linux-kernel/Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com> <local.mail.linux-kernel/20030311142447.GA14931@bjl1.jlokier.co.uk.lucky.linux.kernel> <local.mail.linux-kernel/20030314155947.GD13106@netch.kiev.ua> <200303142143.h2ELheqx076668@mail.flugsvamp.com> <Pine.LNX.4.50.0303141412260.1903-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.50.0303141412260.1903-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Fri, Mar 14, 2003 at 02:16:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 02:16:34PM -0800, Davide Libenzi wrote:
> On Fri, 14 Mar 2003, Jonathan Lemon wrote:
> 
> > In article <local.mail.linux-kernel/Pine.LNX.4.50.0303140845480.1903-100000@blue1.dev.mcafeelabs.com> you write:
> > >On Fri, 14 Mar 2003, Valentin Nechayev wrote:
> > >
> > >>  Tue, Mar 11, 2003 at 14:27:50, jamie wrote about "Re: [patch, rfc]
> > >lt-epoll ( level triggered epoll ) ...":
> > >>
> > >> > Actually I think _this_ is cleanest: A three-way flag per registered
> > >> > fd interest saying whether to:
> > >> >
> > >> > 	1. Report 0->1 edges for this interest.  (Initial 1 counts as an event).
> > >> > 	2. Continually report 1 levels for this interest.
> > >> > 	3. One-shot, report the first time 1 is noted and unregister.
> > >> >
> > >> > ET poll is equivalent to 1.  LT poll is equivalent to 2.  dnotify's
> > >> > one-shot mode is equivalent to 3.
> > >>
> > >> kqueue can do all three variants (1st with EV_CLEAR, 3rd with EV_ONESHOT).
> > >>
> > >> So, result of this whole epoll work is trivially predictable - Linux will have
> > >> analog of "overbloated" and "poorly designed" kqueue, but more poor
> > >> and with incompatible interface, adding its own stone to hell of
> > >> different APIs. Congratulations.
> > >
> > >See, this is a free world, and I very much respect your opinion. On the
> > >other side you might want to actually *read* the kqueue man page and find
> > >out of its 24590 flags, where 99% of its users will use only 1% of its
> > >functionality. Talking about overbloating. You might also want to know
> > >that quite a few kqueue users currently running on your favourite OS, are
> > >moving to Linux+epoll. The reason is still unclear to me, but I can leave
> > >you to discover it as exercise.
> >
> > FUD. You should know that in the normal case, kq users don't use any
> > flags, but they are available for those people who are doing specific
> > things.  But I bet you knew that already and just want to slam something
> > that isn't epoll.
> 
> Please, consider reading the message that generated the response before
> generating superfluous noise. Expecially those "overbloated" and "poorly
> designed" thingies. In my books overbloat is the presence of features that
> 99% of users simply ignore.

I've read the entire thread.

I'm responding to your hyperbole about "XXX flags", which is pure
exaggeration.  I might as well say that epoll is "limited" and
"single-purpose", since it is not capable of doing the same things
that kqueue can do.  In my book, engineering should make the common
case fast, and the uncommon case possible.  You seem to be ignoring
the latter.

If you want to call those features you don't use, "bloat", fine.  But 
they *are* useful to many (>> 1) people, and they were added because
there was no other way to solve their problem.  You should see the
laundry list of items/features/extensions/flags I declined to add, usually
because they were too special-purpose.
-- 
Jonathan

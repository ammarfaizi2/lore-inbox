Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUIOJFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUIOJFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 05:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUIOJFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 05:05:25 -0400
Received: from witte.sonytel.be ([80.88.33.193]:23698 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264265AbUIOJDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 05:03:12 -0400
Date: Wed, 15 Sep 2004 11:02:56 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roland McGrath <roland@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: notify_parent (was: Re: Linux 2.6.9-rc2)
In-Reply-To: <200409142019.i8EKJ8HG002560@magilla.sf.frob.com>
Message-ID: <Pine.GSO.4.58.0409151102180.29604@waterleaf.sonytel.be>
References: <200409142019.i8EKJ8HG002560@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004, Roland McGrath wrote:
> > On Mon, 13 Sep 2004, Linus Torvalds wrote:
> > > Roland McGrath:
> > >   o cleanup ptrace stops and remove notify_parent
> >
> > However, there are still a few users of notify_parent():
>
> IIRC all these are old arch-specific signal code that is rampantly wrong in
> semantics compared to what the up-to-date arch's using the generic code do,
> for quite a long time now.  I believe I mentioned this when I posted the
> patch.  All this arch signal code needs to be rewritten to use
> get_signal_to_deliver, and define ptrace_signal_deliver appropriately to
> get its arch-specific work done.  The old style of code that does all the
> central signal dispatch logic itself is hopeless.  Mostly you have a lot of
> old cruft to remove, and the code that needs to be left is much smaller and
> simpler because the complex stuff is in the shared kernel/signal.c.
>
> > You forgot to add `struct rusage _rusage' members to struct siginfo._sigchld
> > for 2 architectures that define HAVE_ARCH_SIGINFO_T.
>
> I didn't forget.  I never claimed to update other arch's.  The arch
> maintainers need to keep up with patches like you are doing with these
> here.  Most other arch maintainers have submitted their updates already.
> You may need to update some copy_*_siginfo functions if your arch's
> have them in compat code as well.

Hence (IMHO) they should have gone through linux-arch...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

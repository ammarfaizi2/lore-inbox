Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269751AbUINUXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269751AbUINUXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269698AbUINUUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:20:07 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:41154 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S269699AbUINUTV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:19:21 -0400
Date: Tue, 14 Sep 2004 13:19:08 -0700
Message-Id: <200409142019.i8EKJ8HG002560@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: notify_parent (was: Re: Linux 2.6.9-rc2)
In-Reply-To: Geert Uytterhoeven's message of  Tuesday, 14 September 2004 14:27:59 +0200 <Pine.LNX.4.58.0409141425360.8147@anakin>
X-Zippy-Says: My uncle Murray conquered Egypt in 53 B.C.  And I can prove it too!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 13 Sep 2004, Linus Torvalds wrote:
> > Roland McGrath:
> >   o cleanup ptrace stops and remove notify_parent
> 
> However, there are still a few users of notify_parent():

IIRC all these are old arch-specific signal code that is rampantly wrong in
semantics compared to what the up-to-date arch's using the generic code do,
for quite a long time now.  I believe I mentioned this when I posted the
patch.  All this arch signal code needs to be rewritten to use
get_signal_to_deliver, and define ptrace_signal_deliver appropriately to
get its arch-specific work done.  The old style of code that does all the
central signal dispatch logic itself is hopeless.  Mostly you have a lot of
old cruft to remove, and the code that needs to be left is much smaller and
simpler because the complex stuff is in the shared kernel/signal.c.

> You forgot to add `struct rusage _rusage' members to struct siginfo._sigchld
> for 2 architectures that define HAVE_ARCH_SIGINFO_T.

I didn't forget.  I never claimed to update other arch's.  The arch
maintainers need to keep up with patches like you are doing with these
here.  Most other arch maintainers have submitted their updates already.
You may need to update some copy_*_siginfo functions if your arch's
have them in compat code as well.



Thanks,
Roland

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTEEW6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbTEEW6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:58:20 -0400
Received: from a169212.upc-a.chello.nl ([62.163.169.212]:1284 "EHLO
	walton.kettenis.dyndns.org") by vger.kernel.org with ESMTP
	id S262139AbTEEW6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:58:19 -0400
To: Richard Henderson <rth@twiddle.net>
Cc: David.Mosberger@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vsyscall unwind information
References: <20030502004014$08e2@gated-at.bofh.it> <20030503210015$292c@gated-at.bofh.it> <20030504063010$279f@gated-at.bofh.it> <ugade16g78.fsf@panda.mostang.com> <20030505074248.GA7812@twiddle.net> <16054.32214.804891.702812@panda.mostang.com> <20030505163444.GB9342@twiddle.net>
From: Mark Kettenis <kettenis@chello.nl>
Date: 06 May 2003 01:10:37 +0200
In-Reply-To: Richard Henderson's message of "Mon, 5 May 2003 09:34:44 -0700"
Message-ID: <86d6ixdm6q.fsf@elgar.kettenis.dyndns.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson <rth@twiddle.net> writes:

> On Mon, May 05, 2003 at 08:05:58AM -0700, David Mosberger-Tang wrote:
> >   Richard> Why?  Certainly it isn't needed for x86.
> > 
> > Certain applications (such as debuggers) want to know.  Sure, you can
> > do symbol matching (if you have the symbol table) or code-reading
> > (assuming you know the exact sigreturn sequence), but having a marker
> > would be more reliable and faster.
> 
> Eh.  The whole point was to *eliminate* the special cases.
> 
> If the debugger does nothing special now, it'll see the symbol
> from the VDSO in the backtrace and print __kernel_sigreturn.
> Isn't this sufficient for the user to recognize what's going on?
> Does it really need to print <signal frame>?

Unfortunately, GDB needs to be able to recognize signal trampolines in
order to be able to single step correctly when a signal arrives.  At
least on some platforms.  Could be that the code-path in question
isn't used for Linux/i386, but I vaguely remember it does.

Anyway, signal trampolines could be marked with a special augmentation
in their CIE.

Mark

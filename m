Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTK0UmD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 15:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbTK0UmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 15:42:03 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:23017 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261190AbTK0UmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 15:42:00 -0500
Date: Thu, 27 Nov 2003 21:41:59 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG (non-kernel), can hurt developers.
In-Reply-To: <Pine.LNX.4.58.0311261021400.1524@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0311272133540.21573@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.53.0311261153050.10929@chaos>
 <Pine.LNX.4.58.0311261021400.1524@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Nov 2003, Linus Torvalds wrote:

>
> On Wed, 26 Nov 2003, Richard B. Johnson wrote:
> >
> > Note  to hackers. Even though this is a lib-c bug
>
> It's not.
>
> It's a bug in your program.
>
> You can't just randomly use library functions in signal handlers. You can
> only use a very specific "signal-safe" set.
>
> POSIX lists that set in 3.3.1.3 (3f), and says
>
> 	"All POSIX.1 functions not in the preceding table and all
> 	 functions defined in the C standard {2} not stated to be callable
> 	 from a signal-catching function are considered to be /unsafe/
> 	 with respect to signals. .."
>
> typos mine.
>
> The thing is, they have internal state that makes then non-reentrant (and
> note that even the re-entrant ones might not be signal-safe, since they
> may have deadlock issues: being thread-safe is _not_ the same as being
> signal-safe).
>
> In other words, if you want to do complex things from signals, you should
> really just set a flag (of type "sigatomic_t") and have your main loop do
> them. Or you have to be very very careful and only use stuff that is
> defined to be signal-safe (mainly core system calls - stuff like <stdio.h>
> is right out).

Just curious --- what happens when these functions are interrupted by
signal and signal handler does siglongjmp out of signal?

According to this assumption siglongjmp should not work. Does it handle
these situations specially? I don't understand why is it in specification
if it doesn't work.

Mikulas

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319097AbSHSW4F>; Mon, 19 Aug 2002 18:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319098AbSHSW4F>; Mon, 19 Aug 2002 18:56:05 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7894 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319097AbSHSW4D>;
	Mon, 19 Aug 2002 18:56:03 -0400
Date: Tue, 20 Aug 2002 01:01:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Robert Love <rml@tech9.net>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <200208192247.g7JMlUM29487@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0208200049590.5653-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Richard Gooch wrote:

> Having a stable ABI to user-space has been one of the strong points of
> Linux, versus just about everything else out there. And I wouldn't be
> using libc 5 if glibc wasn't growing exponentially with time (both in
> terms of total bytes and in terms of number of shared libraries I have
> to add to my link line).

Richard, if you have read the current thread you are replying to, then you
sure must have noticed that i was mailing exactly because i was worried
about binary compatibility with certain old applications, not because i
wanted to break or obsolete them. A patch with a solution was posted.

Since glibc has not linked any application with the old interfaces in the
past 2 years or more, there's no realistic chance to have any 'recent'
applications that will just break. And old stuff has to be careful anyway
=> one more thing to watch out for to get a working system with an old
libc under a new kernel. If you really really need the old app then you
can change pid_max, or you can even run the application under UML running
an older Linux kernel or a new Linux kernel with a more conservative
pid_max value. Plus, as the icing on the cake, new glibc detects old
interface usage safely, so it's not as if things broke silently.

now on to the interface you complain about. It's horribly broken. It
assumes 16-bit PIDs and provides no safeguards against PID overflow. The
new kernel might as well have scrapped the whole 16-bit implementation of
the API and return -ENOSYS on it. Now it provides a way to limit the PID
space to save these applications that use this broken 16-bit API. Good
enough?

	Ingo



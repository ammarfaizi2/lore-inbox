Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTJETOD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTJETOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:14:03 -0400
Received: from gprs148-216.eurotel.cz ([160.218.148.216]:6016 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263761AbTJETN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:13:59 -0400
Date: Sun, 5 Oct 2003 21:13:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: JFFS2 swsusp / signal cleanup.
Message-ID: <20031005191344.GA963@elf.ucw.cz>
References: <1065266733.16088.91.camel@imladris.demon.co.uk> <20031005161155.GA753@elf.ucw.cz> <20031005171916.B21478@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031005171916.B21478@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is flush_signals() really so stupid to do? Goal was to make
> > modifications to code as simple as possible, and as most pieces do not
> > expect to be interrupted, pretending signal never happened seems like
> > good idea...
> 
> What if that signal was necessary for the operation of the thread, and
> dropping it would cause a problem?
> 
> Since you're effectively using signal handling to cause a false pending
> signal indication, surely the correct cleanup is to re-calculate the
> pending signal indication.  That way, we won't be throwing away
> signals.

Should I do recalc_sigpending() instead of flush_signals(current)?

> I'm also wondering if there could be a problem with (ab)using TASK_STOPPED
> here - could a stopped task be woken prematurely and thereby sent spinning
> in refrigerator() by a non-stopped process sending a SIGCONT at just the
> right time?
> 
> Maybe we want a TASK_FROZEN state to describe the "frozen, may not be woken
> by anything except thawing" state?

That would certainly be cleaner, but I think it would require
modifications all over the kernel...

That SIGCONT race... while() in refrigerator() should catch
that. Maybe we spin, but we go back to sleep pretty soon.

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

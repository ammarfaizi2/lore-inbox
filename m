Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWIHKxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWIHKxB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 06:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWIHKxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 06:53:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9910 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750783AbWIHKxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 06:53:00 -0400
Date: Fri, 8 Sep 2006 12:52:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908105238.GB920@elf.ucw.cz>
References: <20060907003210.GA5503@clipper.ens.fr> <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com> <20060907173449.GA24013@clipper.ens.fr> <20060907225429.GA30916@elf.ucw.cz> <20060908041034.GB24135@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908041034.GB24135@clipper.ens.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You contradict yourself.
> 
> I don't see how that is.  I understand that you could be unconvinced
> by my reasoning and by my arguments, but I don't see how they are
> contradictory.

Well, you claim it is as safe as possible, and it is not quite. 

> The bottom line is that, whereas for root making syscalls fail (or,
> worse, in the case of setuid(), behave subtly diffently) is a radical
> change, for non-root it is something which should always be expected
> (fork() can fail for lack of resources, write() can fail for quota
> exhaution, etc.), and not something an attacker should be able to
> exploit.

I can bet someone will get the fork() case wrong:

f = fork();
kill(f);

fork will return -1, and kill will kill _all_ the processes.

> >			   Yes, you are decreasing security of suid
> > non-root programs, and yes, someone will take advantage of that. Plus,
> > you can easily do away without this risk.
> 
> I wish I could offer more assurance, but unfortunately the solutions
> which do away with the risk come with a great cost:
> 
> > Just add all "usual" capabilities when execing
> > suid/sgid-anything.
> 
> This makes it trivial to regain capabilities: just create a program
> suid yourself and exec it.  OK, we can say that "yourself" won't work,
> but you still only need to find another uid to hijack...  Not too

If you can find another uid to hijack, that other uid has bad
problems. And I do not think you'll commonly find another uid to
hijack.

And there are easier ways to get out of jail with your proposed
capabilities: you do not restrict ptrace, so you can just ptrace any
other process with same uid, and hijack it.

(You probably want to introduce CAP_REG_PTRACE).

Or just remove CAP_REG_XUID_EXEC when removing any other CAP_REG...?

> >		      Alternatively disallow suid/sgid-anything exec
> > when all "usual" capabilities are not present.
> 
> This is probably too stringent: remove any trivial capability
> whatsoever and you lose a rather important ability.

It is not too bad; you'll usually not want restricted programs to exec
anything setuid... (Do you have example where
restricted-but-should-be-able-to-setuid-exec makes sense?)
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

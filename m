Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWIJJes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWIJJes (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 05:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWIJJes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 05:34:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22793 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750799AbWIJJeq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 05:34:46 -0400
Date: Sat, 9 Sep 2006 11:40:38 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060909114037.GA4277@ucw.cz>
References: <20060907003210.GA5503@clipper.ens.fr> <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com> <20060907173449.GA24013@clipper.ens.fr> <20060907225429.GA30916@elf.ucw.cz> <20060908041034.GB24135@clipper.ens.fr> <20060908105238.GB920@elf.ucw.cz> <20060908225118.GB877@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908225118.GB877@clipper.ens.fr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, you claim it is as safe as possible, and it is not quite. 
> 
> I claim "safe enough". :-)

Ok, state 'this allows nasty user to induce failures in setgid
programs it execs' in changelog when you submit.

No, I do not think 'safe enough' is good enough for little or no gain.


> > I can bet someone will get the fork() case wrong:
> > 
> > f = fork();
> > kill(f);
> > 
> > fork will return -1, and kill will kill _all_ the processes.
> 
> Someone who writes code like that deserves to get all his processes
> killed. :-p

...as does someone who introduces known-bad security-related changes
withou *very* good reason.

> fork() can fail for a million reasons, some of which, on
> most systems,

'on most systems' is keyword here, and remember that other ways of
inducing fork failures are normally very easy to detect.

Also... fork was first example. There are probably better examples.


> > If you can find another uid to hijack, that other uid has bad
> > problems. And I do not think you'll commonly find another uid to
> > hijack.
> 
> How about another gid, then?  Should we reset all caps on sgid exec?

Yes. Any setuid/setgid exec is a security barrier, and weird (or new)
semantics may not cross that barrier.

> Ultimately a compromise is to be reached between security and
> flexibility...  The problem is, I don't know who should make the
> decision.

Go for security here. (Normally, consensus on the list is needed for
merging the patch).

> > Or just remove CAP_REG_XUID_EXEC when removing any other CAP_REG...?
> 
> Doable, but ugly (or so I think): there are many paths that set

No, I meant 'teach users to remove CAP_REG_XUID_EXEC when removing
others'.

> caps...  A simpler solution would be to remove the test on
> CAP_REG_SXID and instead test on all regular caps simultaneously.
> Still, I really don't like the idea.

Agreed, I'd call that slightly ugly.

> > It is not too bad; you'll usually not want restricted programs to exec
> > anything setuid... (Do you have example where
> > restricted-but-should-be-able-to-setuid-exec makes sense?)
> 
> Well, I could imagine that a paranoid sysadmin might want some users'
> processes to run without this or that capability (perhaps
> CAP_REG_PTRACE or some other yet-to-be-defined capability).  This
> doesn't mean that they shouldn't be able to run a game which runs sgid
> in order to write the score file.

...so you prefer enabling DoS attack on the core file. I bet some
combination of your new capabilities will allow game to lock the core
file, but make it crash without unlocking it.

Or do you volunteer to audit all the games in Debian each time new
capability is added? :-)
							Pavel
-- 
Thanks for all the (sleeping) penguins.

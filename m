Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbTK0R1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 12:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbTK0R1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 12:27:07 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:11989 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264560AbTK0R1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 12:27:04 -0500
Date: Thu, 27 Nov 2003 18:26:37 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, bruce@perens.com,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Never mind. Re: Signal left blocked after signal handler.
Message-ID: <20031127172637.GB28676@wohnheim.fh-wedel.de>
References: <1069883580.723.416.camel@cube> <200311271012.07893.ioe-lkml@rameria.de> <1069947938.722.437.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1069947938.722.437.camel@cube>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 November 2003 10:45:39 -0500, Albert Cahalan wrote:
> 
> It has benefits:
> 
> 1. Continuous respawning is no good.

But trivial to notice. :)

> 2. If the processes sleeps, you can attach a debugger.

If aunt Tilly has a core dump, her son can extract it and send it to
some developer.  No need for you to drive over to aunt Tilly.

> The obviously correct behavior is to go back into
> user space, likely to take the signal again. The only
> thing wrong with this is that it eats CPU time.
> So _pretend_ to do that. Have the process sleep,
> ideally with an "R" state as seen in /proc, and maybe
> even go back to the crazy loop if someone attaches a
> debugger.
> 
> The crazy loop is most correct though. It's what the
> user asked for. It perfectly handles the case of a
> repeating SIGFPE (blocked) followed by some other
> thread unmapping a page of instructions or data that
> turns the SIGFPE into a SIGSEGV.

"It just what you asked for, but not what you wanted."

I am a firm non-believer in the trust-the-programmer paradigm.  How
many people actually intend to do NULL-pointer dereferences, etc?  To
make this possible "if you really really want to" is ok, but at least
make the bad behaviour hard to trigger by accident.

What Linux did in 2.5.7x is not exacly what I would have done, but it
makes it hard to do the Wrong Thing (tm) by accident, while allowing
it for those who really want it.  Good enough for most users.

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbSJQK4a>; Thu, 17 Oct 2002 06:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSJQK4a>; Thu, 17 Oct 2002 06:56:30 -0400
Received: from ns.suse.de ([213.95.15.193]:65288 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261357AbSJQK42> convert rfc822-to-8bit;
	Thu, 17 Oct 2002 06:56:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Subject: Re: Posix capabilities
Date: Thu, 17 Oct 2002 13:02:25 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021016154459.GA982@TK150122.tuwien.teleweb.at> <20021017032619.GA11954@think.thunk.org> <874rblcpw5.fsf@goat.bogus.local>
In-Reply-To: <874rblcpw5.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210171302.25413.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 October 2002 12:37, Olaf Dietsche wrote:
> "Theodore Ts'o" <tytso@mit.edu> writes:
> > Personally, I'm not so convinced that capabilities are such a great
> > idea.  System administrators have a hard enough time keeping 12 bits
> > of permissions correct on executable files; with capabilities they
> > have to keep track of several hundred bits of capabilties flags, which
>
> So you claim, system administrators are stupid people?

Filesystem capabilities move complexity out of applications into the file 
system (=system configuration), so the admins have to deal with an additional 
task.

>From a security point of view suid root applications that are dropping 
capabilities voluntarily aren't much different from plain old suid root apps; 
there may still be exploitable bugs before the code that drops capabilities 
(which doesn't mean that apps shouldn't drop capabilities). With capabilities 
the kernel ensures that applications cannot exceed their capabilities.

I think the remaining questions really are:

	- how to populate the database of capabilities needed by apps.
	  (Pavel Machek has started this as part of elfcap [which is a bad
	  idea], see http://atrey.karlin.mff.cuni.cz/~pavel/caps/capbase.txt)

	- how to make maintaining / monitoring tight capabilities as
	  effortless as possible.

	- how to set up capabilities when users log in (which users are
	  granted which capabilities; this can be used to split up the role
	  of root.)

	- (maybe some more)

> > must be set precisely correctly, or the programs will either (a) fail
> > to function,
>
> Which you will notice very fast.

Well perhaps not, the admin gets overloaded with requests/complaints, and 
finally decides to discard FS caps.

> > or (b) have a gaping huge security hole.
>
> Which is not worse, but possibly a lot better, than setuid root.

It's worse if apps stop dropping capabilities and instead rely on the caller.

--Andreas.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbSKCHJd>; Sun, 3 Nov 2002 02:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSKCHJd>; Sun, 3 Nov 2002 02:09:33 -0500
Received: from [207.88.206.43] ([207.88.206.43]:40067 "EHLO
	intruder-luxul.gurulabs.com") by vger.kernel.org with ESMTP
	id <S261668AbSKCHJc>; Sun, 3 Nov 2002 02:09:32 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Dax Kelson <dax@gurulabs.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Oliver Xymoron <oxymoron@waste.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, davej@suse.de
In-Reply-To: <Pine.GSO.4.21.0211030048170.25010-100000@steklov.math.psu.edu>
References: <Pine.GSO.4.21.0211030048170.25010-100000@steklov.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Nov 2002 00:16:02 -0700
Message-Id: <1036307763.31699.214.camel@thud>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 23:37, Alexander Viro wrote:
> 
> Congratulations with potential crapload of security holes - now anyone
> who'd compromised a process running as nobody can chmod the damn thing
> and modify it.

Speaking of user 'nobody', modern best practices (and shipped vendor
configuration) strongly discourages lumping everything under 'nobody'.

Each app should run in its own security context by itself.  That is why
I have all the following users in my /etc/passwd:

apache nscd squid xfs ident rpc pcap nfsnobody radvd gdm named ntp

I didn't have to do this myself, my vendor shipped it that way. I don't
have any daemons running as 'nobody'.

I think it is well understood that having more than one app run as the
same uid (historically, nobody) is a Bad Thing(tm).

> And that is the reason why suid-nonroot is bad.  

Generally speaking yes, but don't remove that ability for those who have
applications/circumstances where suid-noroot+caps can be a simple and
clean solution. Vendors, of course, are not likely to ship
suid-noroot+caps binaries.
 
> Note that _all_ binaries that need any capabilities now are written to
> be suid-root.  So the only case left from your scenario is
> 	* new binary
> 	* runs with UID of caller
> 	* wants some capabilities
> 	* doesn't want to be portable (it won't work on any other Unix,
> since we had assumed that it doesn't want to be suid-root and still
> relies on caps present)
> 	* doesn't use any of $BIGNUM portable mechanisms (separate
> helpers, descriptor-passing, yadda, yadda).
> 
> Umm...  Do we really want to help these out?  We don't even have an
> excuse of that being an important 3rd-party program brought from some
> other system - it will be Linux-only and new, at that.

Pardon if I miss parsed.

On a 'everything install RHL8.0', there exists 47 SUID root binaries.

Don't we want to convert them to 'run with UID of caller and with some
capabilities'?

Isn't this the common case?

A process executing as root, even with ZERO capabilities, is still quite
privileged/dangerous.  That process can replace root owned binaries, and
read /etc/shadow.

I see two problem spaces that capabilities helps with:

1. SUID root binaries --> run as caller with need capabilities
2. root daemons --> run as defined non-root user with capabilities

Problem space 2 can be tackled right now assuming the daemon doesn't try
to fork+exec another binary and expect that binary to inherit the
capabilities that it has.

> 
> Comments?

See above :)


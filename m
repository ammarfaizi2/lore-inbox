Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbQKCVef>; Fri, 3 Nov 2000 16:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132167AbQKCVe0>; Fri, 3 Nov 2000 16:34:26 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:25604 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S132147AbQKCVeO>; Fri, 3 Nov 2000 16:34:14 -0500
Date: Fri, 3 Nov 2000 13:34:10 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: george@moberg.com
cc: Tim Hockin <thockin@isunix.it.ilstu.edu>,
        Ulrich Drepper <drepper@cygnus.com>, linux-kernel@vger.kernel.org
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a 
 user-land  programmer...
In-Reply-To: <3A0316D1.C96AADFC@moberg.com>
Message-ID: <Pine.LNX.4.21.0011031324210.22526-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000 george@moberg.com wrote:

> I don't mean this to sound like a rant.  It's just that I can't possibly
> ascertain why someone in their right mind would want any behaviour
> different than SA_RESTART.

study apache 1.3's child_main code, you'll see an example of EINTR in use.  
it's used to get out of accept() -- most specifically when the child needs
to die off (because the parent has determined that there's either too many
children, or because a shutdown/restart is occuring).

apache 1.3's BUFF code also uses EINTR for timeouts.

i eliminated signals in the 2.0 design... so it doesn't use EINTR any
more, but it restarts in userland because that's the most portable thing
to do.



On Fri, 3 Nov 2000 george@moberg.com wrote:

> After reading about SA_RESTART, ok.  However, couldn't those
> applications that require it enable this behaviour explicitly?

anyone sane writing modern applications will use sigaction().  signal() is
legacy.

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

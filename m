Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbQKHOzJ>; Wed, 8 Nov 2000 09:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKHOyu>; Wed, 8 Nov 2000 09:54:50 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:86 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129094AbQKHOyS>; Wed, 8 Nov 2000 09:54:18 -0500
Date: Wed, 8 Nov 2000 08:53:19 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200011081453.IAA340590@tomcat.admin.navo.hpc.mil>
To: riel@conectiva.com.br, Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Looking for better VM
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------
> On Wed, 8 Nov 2000, Szabolcs Szakacsits wrote:
> > On Mon, 6 Nov 2000, Rik van Riel wrote:
[snip]
> > You could ask, so what's the point for non-overcommit if we use
> > process killing in the end? And the answer, in *practise* this almost
> > never happens, root can always clean up and no processes are lost
> > [just as when disk is "full" except the reserved area for root]. See?
> > Human get a chance against hard-wired AI.
> > 
> > I also didn't say non-overcommit should be used as default and a
> > patch http://www.cs.helsinki.fi/linux/linux-kernel/2000-13/1208.html,
> > developed for 2.3.99-pre3 by Eduardo Horvath and unfortunately was
> > ignored completely, implemented it this way. 
> 
> OK. This is a lot more reasonable. I'm actually looking
> into putting non-overcommit as a configurable option in
> the kernel.
> 
> However, this does not save you from the fact that the
> system is essentially deadlocked when nothing can get
> more memory and nothing goes away. Non-overcommit won't
> give you any extra reliability unless your applications
> are very well behaved ... in which case you don't need
> non-overcommit.

Applications are not usually the problem, users are. If a user starts
one "well behaved" process, and then starts another, and another....
The system WILL go OOM, and with unpredictable results (as far as the user
is concerned).

The Eduardo Horvath patch works exactly as he designed. It allowed overcommit
by root, disallowed user generating overcommit. or it could disallow
overcommit by all, or operate the same as without the patch (but it did
accumulate some statistics).

The problem is that unless user memory resource controls are available to
the administrator to establish some policy, system deadlock will always
occur, OR you have random shutdowns, or random process aborts. The resource
controls should allow an administrator defined policy, established in user
space, and enforced by the kernel. The kernel should be able to enforce any
policy from no memory restriction (current, and reasonable for single user
workstations), to fully disabled overcommit (dedicated multi-user batch
processing in clustered environments).

I know the patch was an early prototype. It did provide some identification
of the locations that resource controls could/should be done (this should be a
2.5 developement item).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

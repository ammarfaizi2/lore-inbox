Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284538AbRL2A40>; Fri, 28 Dec 2001 19:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284280AbRL2A4Q>; Fri, 28 Dec 2001 19:56:16 -0500
Received: from bitmover.com ([192.132.92.2]:7589 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284538AbRL2A4D>;
	Fri, 28 Dec 2001 19:56:03 -0500
Date: Fri, 28 Dec 2001 16:55:59 -0800
From: Larry McVoy <lm@bitmover.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228165559.N3727@work.bitmover.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228120104.B4077@work.bitmover.com> <7390.1009587002@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <7390.1009587002@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Dec 29, 2001 at 11:50:02AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I also want updates from the dependency back end code, to remove the
> phase 5 processing.  The "extract dependency" code runs after each
> compile step so there can be multiple updates running in parallel.  My
> gut feeling is that it will be faster to have one database server and
> all the back ends talk to that server.  Otherwise each compile will
> have overhead for lock, open, mmap, update, close, write back, unlock.
> A single threading server removes the need for lock/unlock and can sync
> the data to disk after n compiles instead of being forced to do it
> after every compile.
> 
> If your experience says that doing updates from each compile step
> without a server process would not be too slow, let me know.

You certainly don't need a server process.   And as was pointed out
earlier, it's nice not to have them, then you don't have to worry 
about them still being there.

I can write you up a multi writer version using in file locks (which
work over NFS, we had do that for BK and I'm pretty sure it is platform
independent, I can't break it).  We have to do this sort of multi
reader/writer crud in BK all the time and have lots of experience with
locking, breaking locks, waiting, NFS, etc.  Much more experience than
we ever wanted :-)

You don't need to sync to disk at all, let the data sit in memory, that's
why mmap is cool.

Give me a spec for what you want, I'll crank out some code.  Maybe I'll 
finally actually be useful to the kernel after all these years...
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

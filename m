Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310494AbSCPRix>; Sat, 16 Mar 2002 12:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310488AbSCPRip>; Sat, 16 Mar 2002 12:38:45 -0500
Received: from bitmover.com ([192.132.92.2]:24964 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310482AbSCPRie>;
	Sat, 16 Mar 2002 12:38:34 -0500
Date: Sat, 16 Mar 2002 09:38:32 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Larry McVoy <lm@bitmover.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
Message-ID: <20020316093832.F10086@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Larry McVoy <lm@bitmover.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com> <3C938027.4040805@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C938027.4040805@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Mar 16, 2002 at 12:25:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think a fair question would be, is this scenario going to occur often? 
>  I don't know.  But I'll bet you -will- see it come up again in kernel 
> development.  Why?  We are exercising the distributed nature of the 
> BitKeeper system.  The system currently punishes Joe in Alaska and 
> Mikhail in Russia if they independently apply the same GNU patch, and 
> then later on wind up attempting to converge trees.

Indeed.  So speak in file systems, because a BK package is basically a file
system, with multiple distributed instances, all of which may be out of
sync.  The problems show up when the same patch is applied N times and 
then comes together.  The inodes collide.  Right now, you think that's
the problem, and want BK to fix it.  We can fix that.  But that's not 
the real problem.  The real problem is N sets of diffs being applied
and then merged.  The revision history ends up with the data inserted N
times.

I'm not sure what to do about it.  I can handle the duplicate inode case
more gracefully but it's a heavy duty rewack.

We could play games where we detect the same patch inserted multiple times
and refuse to merge them.  Hmm. Hmm.  Not sure that helps.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

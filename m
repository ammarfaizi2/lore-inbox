Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267901AbUHaVdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267901AbUHaVdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbUHaVdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:33:21 -0400
Received: from lakermmtao06.cox.net ([68.230.240.33]:43251 "EHLO
	lakermmtao06.cox.net") by vger.kernel.org with ESMTP
	id S267901AbUHaVa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:30:28 -0400
In-Reply-To: <1093973977.434.7097.camel@cube>
References: <1093964782.434.7054.camel@cube> <Pine.LNX.4.58.0408310945580.2295@ppc970.osdl.org> <1093973977.434.7097.camel@cube>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F8184F90-FB94-11D8-9B58-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Albert Cahalan <albert@users.sourceforge.net>, axboe@suse.de,
       bunk@fs.tum.de, Linus Torvalds <torvalds@osdl.org>, arjanv@redhat.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: What policy for BUG_ON()?
Date: Tue, 31 Aug 2004 17:30:24 -0400
To: Albert Cahalan <albert@users.sf.net>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 31, 2004, at 13:39, Albert Cahalan wrote:
> Expensive function calls won't get optimized away unless you
> mark them __attribute__((__const__)) or __attribute__((__pure__)).
> (perhaps that should be encouraged)
>
> Then of course the compiler must assume that the function
> really needed the arguments it was passed, and that it
> might have modified memory, and so on.
>
> Eh, how about a BUG_ON_WITH_SIDE_EFFECT() macro?

Due to the potentially large number of existing BUG_ON() usages with 
side
effects, it might be better to do this:

#if DEBUG
# define	BUG_ON(cond)		do { if (cond) BUG(); } while(0)
# define	BUG_CHECK(cond)		do { if (cond) BUG(); } while(0)
#else
# define	BUG_ON(cond)		do { if (cond); } while(0)
# define	BUG_CHECK(cond)		do { } while(0)
#endif

Then in most cases new statements would use BUG_CHECK, especially if
they contain expensive unnecessary function calls or critical sections.

This would break the least amount of existing code, and provide both
methods to kernel developers.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------



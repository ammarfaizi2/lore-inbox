Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263301AbTCXXXY>; Mon, 24 Mar 2003 18:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263339AbTCXXXY>; Mon, 24 Mar 2003 18:23:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44045 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263301AbTCXXXV>; Mon, 24 Mar 2003 18:23:21 -0500
Date: Tue, 25 Mar 2003 00:34:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.65: *huge* interactivity problems
Message-ID: <20030324233429.GB3539@atrey.karlin.mff.cuni.cz>
References: <20030323231306.GA4704@elf.ucw.cz> <20030324171936.680f98e2.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324171936.680f98e2.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm having awfull interactivity problems. While lingvistic application
> > (slm from nltools.sf.net) is running, machine is unusable. I still can
> > read text in most, but can't login, can't run links, can't... For
> > minutes.
> > 
> > slm does a lot of computation over ~250MB dataset, but during stall
> > disk was not active.
> 
> Oh Pavel, this is more a whinge than a bug report.  You know better
> ;)

Yes, it is whine, it is *so* horrible that I thought everyone must see
it.

Looks like scheduler problem to me. Disk is not lit.

vmstat (part):

 6  1  15352   3316    408  54164    0    0   256     0 1039   100 99  1  0  0
 6  1  15352   3316    408  54168    0    0     0     0 1033    99 100  0  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 6  1  15352   4212    408  53132    0    0   256     0 1040   109 98  2  0  0
 6  1  15352   4044    408  53388    0    0   256     0 1051   112 99  1  0  0
 6  1  15352   3708    408  53704    0    0   312     0 1045   108 99  1  0  0
 6  1  15352   3484    408  53968    0    0   256     0 1045   130 96  4  0  0
 6  1  15352   4276    392  53012    0    0   444     0 1088   131 95  5  0  0
 6  1  15352   3828    392  53528    0    0   512    72 1034   114 100  0  0  0
 6  1  15352   3828    392  53536    0    0     0     0 1057    90 99  1  0  0
 6  1  15352   3604    392  53792    0    0   256     0 1052    87 88 12  0  0
 6  1  15352   3324    392  54052    0    0   256     0 1040    95 88 12  0  0
 6  1  15352   5340    360  52044    0    0   256     0 1031    90 93  7  0  0
 8  1  15352   5164    360  52304    0    0   256     8 1036    99 98  2  0  0
 4  1  15352   4884    360  52564    0    0   256     0 1031   118 98  2  0  0
 4  1  15352   4660    360  52828    0    0   256     0 1210   215 97  3  0  0

Login takes > 30 seconds at this point.  

> - How much memory does the machine have?

256MB

> - UP/SMP/preempt?

UP

> - What do vmstat and top say?

top is hung, too.

> - Did it happen in 2.5.64?  2.5.63?  2.4.20?

Definitely not there with 2.4., and I do not think I seen it with 2.5.64.

> - Does it get better if you renice stuff?

Will try.

> - What steps should others take to reproduce it?

Quite hard to reproduce, that lingvistics tools are not really fun to
use.

> etc, etc, etc.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130829AbRCJCCj>; Fri, 9 Mar 2001 21:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130828AbRCJCCa>; Fri, 9 Mar 2001 21:02:30 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:34936 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130827AbRCJCCQ>; Fri, 9 Mar 2001 21:02:16 -0500
Message-ID: <3AA989B2.9CE8273E@sgi.com>
Date: Fri, 09 Mar 2001 17:56:02 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <Pine.GSO.4.21.0103091958030.17677-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> No such thing. The same fs may be present in many places. Please,
> describe the situation - where do you get that dentry from?
>                                                         Cheers,
>                                                                 Al
---

Al,
	I'm getting it from various places, 1) if I want to know the
path relative to the root of the dentry at the end of 'path_walk'
or __user_path_walk (as used in truncate)  and
2) If I've gotten a dentry as in sys_fchdir/fchown/fstat/newfstat 
from a file descriptor and I want the absolute path or if multple
(such as multiple mounts of the same fs in different locations), the
one that the user used to access the dentry.

	In 2.2 there was a way to get the path only from the
dentry (d_path) -- I'm looking for similar functionality for the
above cases.

	Is it such that in 2.2 dentries were only relative to root
where in 2.4 they are relative to their mount point and instead of
duplicate dcache entries for each possible mount point, they get stored
as one?  

	If that's the case, then while I might get a path for user-path
walk, if I just have a 'fd', it may not be poasible to backtrace into
the path the user used to access the file?

	Just some wild speculations on my part....:-/...did
I refine the question enough?

thanks,
-linda


-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264780AbSJVTHh>; Tue, 22 Oct 2002 15:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbSJVTHh>; Tue, 22 Oct 2002 15:07:37 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:1685 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264780AbSJVTHf> convert rfc822-to-8bit; Tue, 22 Oct 2002 15:07:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Tim Hockin <thockin@sun.com>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
Date: Tue, 22 Oct 2002 14:12:59 -0500
User-Agent: KMail/1.4.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com> <200210221303.47488.pollard@admin.navo.hpc.mil> <3DB59722.2090701@sun.com>
In-Reply-To: <3DB59722.2090701@sun.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210221412.59933.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 October 2002 01:21 pm, Tim Hockin wrote:
> Jesse Pollard wrote:
> > Does it actually work with NFS???? or any networked file system?
> > Most of them limit ngroups to 16 to 32, and cannot send any data
> > if there is an overflow, since that overflow would replace all of the
> > data you try to send/recieve...
>
> NFS has a smaller limit, that is correct.  An unfortunate limitation.
>
> > And I really doubt that anybody has 10000 unique groups (or even
> > close to that) running under any system. The center I'm at has
> > some of the largest UNIX systems ever made, and there are only
> > about 600 unique groups over the entire center. The largest number
> > of groups a user can be in is 32. And nobody even comes close.
>
> I'm glad it doesn't affect you.  If it was a more common problem, it
> would have been solved a long time ago.  It does affect some people,
> though.  Maybe they can redesign their group structures, but why not
> remove this arbitrary limit, since we can?

Think about a while - if a file write (say 1K in length) must include 10000
groups (at 16 bits/group? 32bits?) then the resulting transaction becomes
1K + 2*10K -> 21K (or 1K+4*10K -> 41K). This is over 20 times the overhead.

No I don't expect the structures to be changed that much.

I am in favor of being able to change the limits, but lets be reasonable.
I can see a use for 64 groups, but not much over. Even that introduces
a practical security problem (leakage of data from one authorized group
to unauthorized groups).

By the time you get one or more people with that many groups you
may as well put everybody in one group and be done with it.

ACLs would be much more usefull, and controllable than 10000 groups
anyway. At least the owner of the file would be able to specify exactly
what access is being granted, and to whom.

BTW, a bsearch algorithm is slow compaired to a radix search in
sparse trees...

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

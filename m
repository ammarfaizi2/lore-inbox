Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbTBTQhM>; Thu, 20 Feb 2003 11:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbTBTQhL>; Thu, 20 Feb 2003 11:37:11 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:22547 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S265936AbTBTQhK>;
	Thu, 20 Feb 2003 11:37:10 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
Date: Thu, 20 Feb 2003 16:47:15 +0000 (UTC)
Organization: Cistron Group
Message-ID: <b330qj$sri$1@news.cistron.nl>
References: <Pine.LNX.4.44.0302201656030.30000-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1045759635 29554 62.216.29.200 (20 Feb 2003 16:47:15 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0302201656030.30000-100000@localhost.localdomain>,
Ingo Molnar  <mingo@elte.hu> wrote:
>the fix for this is two-fold. First, it must be possible for procps to
>separate 'threads' from 'processes' without having to go into 16 thousand
>directories. I solved this by prefixing 'threads' (ie. non-group-leader
>threads) with a dot ('.') character in the /proc listing:

Why not put threads belonging to a thread group into /proc/17072/threads ?

> $ ls -a /proc

I'm seeing 17072 as a group-leader and the 'threads' as .17073 etc.
When you put all 'threads' into /proc/17072/threads, you'd get
/proc/17072/threads/17072, /proc/17072/threads/17073, etc.
/proc/17072 would show stats for the whole threads group, while
/proc/17072/threads/17072 would show stats for just that thread.

>the .17073 ... .17082 entries belong to the thread-group 17072.

Yuck ;(

>The key here is for procps to be able to parse threads without having to
>call into the kernel 16K times. The dot-approach also has the added
>benefit of 'hiding' threads in the default 'ls /proc' listing.

What is against /proc/<pid>/threads ?

>the other change needed was the ability to read comulative CPU usage
>statistics from the thread group leader. I've introduced 4 new fields in
>/proc/PID/stat for that purpose, the kernel keeps those uptodate across
>fork/exit and in the timer interrupt - it's very low-overhead.

That would also be solved with /proc/<pid> and /proc/<pid>/threads/<thread>

>another advantage of this approach is that old procps is fully compatible
>with the new kernel, and new procps is fully compatible with old kernels.  

That would also be the case with /proc/<pid>/threads

Mike.
-- 
Anyone who is capable of getting themselves made President should
on no account be allowed to do the job -- Douglas Adams.


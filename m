Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbRHTTa7>; Mon, 20 Aug 2001 15:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268928AbRHTTat>; Mon, 20 Aug 2001 15:30:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:59362 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268934AbRHTTaj>; Mon, 20 Aug 2001 15:30:39 -0400
Date: Mon, 20 Aug 2001 14:30:52 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.9 Make thread group id visible in
 /proc/<pid>/status
Message-ID: <33840000.998335852@baldur>
In-Reply-To: <9lrn8s$t23$1@ncc1701.cistron.net>
In-Reply-To: <E15Yrlh-0006JF-00@the-village.bc.nu>
 <26210000.998324773@baldur> <9lrn8s$t23$1@ncc1701.cistron.net>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, August 20, 2001 19:09:16 +0000 Miquel van Smoorenburg 
<miquels@cistron-office.nl> wrote:

> Hmm, I've always been a bit curious about this .. I don't think getpid()
> should return tgid instead of pid. It looks broken to me. Thread groups
> are a good idea, but they should act more like process groups do.
> Switching pid and tgid is something that the LinuxThreads library
> should probably do, but not the kernel. IMHO.
>
> If one really wants CLONE_PID to work, fix CLONE_PID.

I wasn't on the list when getpid() was changed to return tgid.  I don't 
have a strong feeling about it, though it does make pthread semantics 
simpler.

CLONE_PID really isn't the semantic we want, though.  That would make all 
tasks in the process have the same pid, and no way to address a specific 
task.  We'd have to introduce something like a task id or a thread id. 
Having tgid and pid gives us the tools we need, and minimizes the 
compatibility issues.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059


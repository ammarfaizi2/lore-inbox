Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317348AbSGOGFG>; Mon, 15 Jul 2002 02:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSGOGFF>; Mon, 15 Jul 2002 02:05:05 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:46556 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S317348AbSGOGFE>; Mon, 15 Jul 2002 02:05:04 -0400
Message-Id: <5.1.0.14.2.20020715160245.02ad0978@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 15 Jul 2002 16:06:21 +1000
To: Andrew Morton <akpm@zip.com.au>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: ext2 performance in 2.5.25 versus 2.4.19pre8aa2
Cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, Steve Lord <lord@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D325DEB.A9920C12@zip.com.au>
References: <3D2CFF48.9EFF9C59@zip.com.au>
 <5.1.0.14.2.20020714202539.022c4270@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:30 PM 14/07/2002 -0700, Andrew Morton wrote:
>Funny thing about your results is the presence of sched_yield(),
>especially in the copy-from-pagecache-only load.  That test should
>peg the CPU at 100% and definitely shouldn't be spending time in
>default_idle.  So who is calling sched_yield()?  I think it has to be
>your test app?
>
>Be aware that the sched_yield() behaviour in 2.5 has changed a lot
>wrt 2.4.  It has made StarOffice 5.2 completely unusable on a non-idle
>system, for a start.  (This is a SO problem and not a kernel problem,
>but it's a lesson).

my test app uses pthreads (one thread per disk-worker) and 
pthread_cond_wait in the master task to wait for all workers to finish.
i'll switch the app to use clone() and sys_futex instead.

i guess in that case, its debatable whether its a kernel problem or not -- 
pthreads is out there, and if its default behavior is bad, any threaded app 
which uses it will also be bad.


cheers,

lincoln.


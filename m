Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSGOGmC>; Mon, 15 Jul 2002 02:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSGOGmC>; Mon, 15 Jul 2002 02:42:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64274 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317355AbSGOGmB>;
	Mon, 15 Jul 2002 02:42:01 -0400
Message-ID: <3D327129.691A95AF@zip.com.au>
Date: Sun, 14 Jul 2002 23:52:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, Steve Lord <lord@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 performance in 2.5.25 versus 2.4.19pre8aa2
References: <3D325DEB.A9920C12@zip.com.au> <5.1.0.14.2.20020715160245.02ad0978@mira-sjcm-3.cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale wrote:
> 
> At 10:30 PM 14/07/2002 -0700, Andrew Morton wrote:
> >Funny thing about your results is the presence of sched_yield(),
> >especially in the copy-from-pagecache-only load.  That test should
> >peg the CPU at 100% and definitely shouldn't be spending time in
> >default_idle.  So who is calling sched_yield()?  I think it has to be
> >your test app?
> >
> >Be aware that the sched_yield() behaviour in 2.5 has changed a lot
> >wrt 2.4.  It has made StarOffice 5.2 completely unusable on a non-idle
> >system, for a start.  (This is a SO problem and not a kernel problem,
> >but it's a lesson).
> 
> my test app uses pthreads (one thread per disk-worker) and
> pthread_cond_wait in the master task to wait for all workers to finish.
> i'll switch the app to use clone() and sys_futex instead.

OK.

> i guess in that case, its debatable whether its a kernel problem or not --
> pthreads is out there, and if its default behavior is bad, any threaded app
> which uses it will also be bad.

Well if your machine is executing a single cycle in default_idle
with that load then there's a bug somewhere.

I took a quick look at glibc-linuxthreads but as usual, my brain
turned to mush and it took seven years off my life.

If you can send me a copy of your test app I'll take a look
at what's going on.

Thanks.

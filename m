Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAaORr>; Wed, 31 Jan 2001 09:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129965AbRAaORh>; Wed, 31 Jan 2001 09:17:37 -0500
Received: from yoda.planetinternet.be ([195.95.30.146]:64520 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S129631AbRAaORZ>; Wed, 31 Jan 2001 09:17:25 -0500
Date: Wed, 31 Jan 2001 15:17:20 +0100
From: Kurt Roeckx <Q@ping.be>
To: Mohit Aron <aron@cs.rice.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gprof cannot profile multi-threaded programs
Message-ID: <20010131151720.A1386@ping.be>
In-Reply-To: <200101310531.XAA09534@cs.rice.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <200101310531.XAA09534@cs.rice.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 11:31:13PM -0600, Mohit Aron wrote:
> I analyzed the problem to be the following. Linux uses periodic SIGPROF signals
> for profiling (Linux doesn't use the profil system call used in other OS's like
> Solaris where the kernel does the profiling on behalf of the process). All
> profile information is collected in the context of the signal handler for the
> SIGPROF signal in Linux. Unfortunately, any thread that's created using
> pthread_create() does not get these periodic SIGPROF signals. Hence any thread
> other than the first thread is not profiled. The fix is to use setitimer()
> system call immediately in the thread startup function for any new thread to
> make the SIGPROF signal to be delivered at the designated interrupt frequency
> (every 10ms). With this fix, the profile produced by gprof reflects the overall
> computation done by all threads in the process. A more general fix would be
> to fix the kernel to make any new threads inherit the setitimer() settings
> for the parent thread.

You have the same problem when doing fork().  Only the parent
will get cpu usage info.  I have to call setitimer() too, to make
it work properly.

I complained about it a few days ago, but didn't get a reply yet.


Kurt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

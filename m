Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136707AbRASWTK>; Fri, 19 Jan 2001 17:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136467AbRASWTA>; Fri, 19 Jan 2001 17:19:00 -0500
Received: from gateway.sequent.com ([192.148.1.10]:49313 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S136707AbRASWSt>; Fri, 19 Jan 2001 17:18:49 -0500
Date: Fri, 19 Jan 2001 14:18:44 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: Davide Libenzi <davidel@xmail.virusscreen.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
Message-ID: <20010119141844.I26968@w-mikek.des.sequent.com>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com> <20010119124921.G26968@w-mikek.des.sequent.com> <20010119135135.H26968@w-mikek.des.sequent.com> <01011914030601.01005@ewok.dev.mycio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <01011914030601.01005@ewok.dev.mycio.com>; from davidel@xmail.virusscreen.com on Fri, Jan 19, 2001 at 02:03:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 02:03:06PM -0800, Davide Libenzi wrote:
<stuff deleted>
> > void            oneatwork(int thr)
> > {
> >     int             i;
> >     while (!start)              /* don't disturb pthread_create() */
> >         usleep(10000);
> >
> >     actthreads++;
> >     while (!stop)
> >     {
> >         if (count)
> >             totalwork[thr]++;
> >
> >         syscall(158); /* sys_sched_yield() */
> >     }
> >     actthreads--;
> >     pthread_exit(0);
> > }
> >
> > Note that actthreads is a global variable which is being updated
> > by multiple threads without any form of synchronization.  Because
> > of this actthreads sometimes never goes to zero after all worker
> > threads have finished. 
> 
> If all threads complete successfully actthreads has to be zero.

Not as currently coded.  If two threads try to decrement actthreads
at the same time, there is no guarantee that it will be decremented
twice.  That is why you need to put some type of synchronization in
place.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136559AbRASXYn>; Fri, 19 Jan 2001 18:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136982AbRASXYX>; Fri, 19 Jan 2001 18:24:23 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:61158 "HELO
	localdomain") by vger.kernel.org with SMTP id <S136559AbRASXYD>;
	Fri, 19 Jan 2001 18:24:03 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
Organization: myCIO.com
Date: Fri, 19 Jan 2001 15:24:41 -0800
X-Mailer: KMail [version 1.1.95.5]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Andrea Arcangeli <andrea@suse.de>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
To: Mike Kravetz <mkravetz@sequent.com>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com> <01011914030601.01005@ewok.dev.mycio.com> <20010119141844.I26968@w-mikek.des.sequent.com>
In-Reply-To: <20010119141844.I26968@w-mikek.des.sequent.com>
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
MIME-Version: 1.0
Message-Id: <01011915244102.01005@ewok.dev.mycio.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 January 2001 15:23, Mike Kravetz wrote:
> On Fri, Jan 19, 2001 at 02:03:06PM -0800, Davide Libenzi wrote:
> <stuff deleted>
>
> > > void            oneatwork(int thr)
> > > {
> > >     int             i;
> > >     while (!start)              /* don't disturb pthread_create() */
> > >         usleep(10000);
> > >
> > >     actthreads++;
> > >     while (!stop)
> > >     {
> > >         if (count)
> > >             totalwork[thr]++;
> > >
> > >         syscall(158); /* sys_sched_yield() */
> > >     }
> > >     actthreads--;
> > >     pthread_exit(0);
> > > }
> > >
> > > Note that actthreads is a global variable which is being updated
> > > by multiple threads without any form of synchronization.  Because
> > > of this actthreads sometimes never goes to zero after all worker
> > > threads have finished.
> >
> > If all threads complete successfully actthreads has to be zero.
>
> Not as currently coded.  If two threads try to decrement actthreads
> at the same time, there is no guarantee that it will be decremented
> twice.  That is why you need to put some type of synchronization in
> place.

Right, inc & dec are not atomic w/o #LOCK.


- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

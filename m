Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292923AbSCDWNA>; Mon, 4 Mar 2002 17:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292932AbSCDWMv>; Mon, 4 Mar 2002 17:12:51 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:24073 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S292923AbSCDWMg>; Mon, 4 Mar 2002 17:12:36 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 4 Mar 2002 14:15:58 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: Davide Libenzi <davidel@xmailserver.org>, Robert Love <rml@tech9.net>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fast Userspace Mutexes III.
In-Reply-To: <20020304154848.A1055@elinux01.watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0203041305250.1561-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Hubertus Franke wrote:

> On Mon, Mar 04, 2002 at 12:13:50PM -0800, Davide Libenzi wrote:
> > On 4 Mar 2002, Robert Love wrote:
> >
> > > On Sun, 2002-03-03 at 22:55, Rusty Russell wrote:
> > > > 1) Use mmap/mprotect bits, not new syscall (thanks RTH, Erik Biederman)
> > > > 2) Fix wakeup race in kernel (thanks Martin Wirth, Paul Mackerras)
> > > > 3) Simplify locking to a single atomic (no more arch specifics!)
> > > > 4) Use wake-one by handcoding queues.
> > > > 5) Comments added.
> > > >
> > > > Thanks to all for feedback and review: I'd appreciate a comment from
> > > > those arch's which need to do something with the PROT_SEM bit.
> > > >
> > > > Once again, tested on 2.4.18 UP PPC, compiles on 2.5.6-pre1.
> > > >
> > > > Bad news is that we're up to 206 lines again.
> > > > Rusty.
> > >
> > > Good work.  I likee.
> >
> > Ok, i reply to this because my 'd' Pine's key is heavily used in these days :-)
> > I took a look at the code yesterday night and i've a stupid question
> > Rusty. I do not know what is the code used in the upper part of the
> > iceberg ( userspace ) but are you doing a dec_and_test() on userspace
> > before entering the kernel ? Or, is the kernel code the slow path or you
> > enter it by default ?
> >
> >
> >
> > - Davide
> >
>
> Yes, that section is missing. It should be just as you said.
>
> int futex_down(atomic_t *count)
> {
> 	if (!atomic_dec_and_test(count))
> 		return sys_futex(count,FUTEX_DOWN);
> 	return 0;
> }

That's great. What if the process holding the mutex dies while there're
sleeping tasks waiting for it ?




- Davide




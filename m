Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293535AbSBZUoz>; Tue, 26 Feb 2002 15:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293537AbSBZUoq>; Tue, 26 Feb 2002 15:44:46 -0500
Received: from chaos.analogic.com ([204.178.40.224]:32651 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293535AbSBZUod>; Tue, 26 Feb 2002 15:44:33 -0500
Date: Tue, 26 Feb 2002 15:47:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: schedule()
In-Reply-To: <Pine.LNX.4.44.0202261218080.1544-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.3.95.1020226154406.6812A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Davide Libenzi wrote:

> On Tue, 26 Feb 2002, Richard B. Johnson wrote:
> 
> > On Tue, 26 Feb 2002, Davide Libenzi wrote:
> >
> > > On Tue, 26 Feb 2002, Richard B. Johnson wrote:
> > >
> > > >
> > > >
> > > > I just read on this list that:
> > > >
> > > >     while(something)
> > > >     {
> > > >       current->policy |= SCHED_YIELD;
> > > >       schedule();
> > > >     }
> > > >
> > > > Will no longer be allowed in a kernel module! If this is true, how
> > > > do I loop, waiting for a bit in a port, without wasting CPU time?
> > > >
> > > > A lot of hardware does not generate interrupts upon a condition,
> > > > there is no CPU activity that could send a wake_up_interruptible()
> > > > to something sleeping.
> > > >
> > > > For instance, I need to write data to a hardware FIFO, one long-word
> > > > at a time, but I can't just write. I have to wait for a bit to be
> > > > set or reset for each and every write. I'm going to be burning a
> > > > lot of CPU cycles if I can't schedule() while the trickle-down-effect
> > > > of the hardware is happening.
> > >
> > > What did it do yield() to you ? Doesn't it work for your case ?
> > >
> > There isn't one in 2.4.x  I'll modify my drivers to use YIELD
> > and #define it depending upon version.
> 
> In 2.5 yield() maps to sys_sched_yield(). You can handle it in the same
> way in your includes if version <= 2.4.
> 
> 

Can't find it in any header file.

Script started on Tue Feb 26 15:45:06 2002
# grep "sys_sched_yield()" /usr/src/linux/include/linux/*.h
# grep "sys_sched_yield()" /usr/src/linux/include/asm/*.h
You have new mail in /var/spool/mail/root
# exit
exit

Script done on Tue Feb 26 15:46:46 2002

I'll #define a macro and be done with it.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276653AbRJYXQs>; Thu, 25 Oct 2001 19:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276665AbRJYXQj>; Thu, 25 Oct 2001 19:16:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35065 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S276653AbRJYXQY> convert rfc822-to-8bit; Thu, 25 Oct 2001 19:16:24 -0400
Message-ID: <3BD89B1E.28E4D7DC@mvista.com>
Date: Thu, 25 Oct 2001 16:07:10 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shaya Potter <spotter@cs.columbia.edu>
CC: =?iso-8859-1?Q?Jos=E9?= Luis Domingo =?iso-8859-1?Q?L=F3pez?= 
	<jdomingo@internautas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux Scheduler and Compilation
In-Reply-To: <007501c15d68$94f12c60$8630fdd4@3232424> 
		<20011025203743.B504@dardhal.mired.net> <1004036810.1770.2.camel@zaphod>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter wrote:
> 
> On Thu, 2001-10-25 at 16:37, José Luis Domingo López wrote:
> > On Thursday, 25 October 2001, at 18:20:25 +0300,
> > Omer Sever wrote:
> >
> > >      I have a project on Linux CPU Scheduler to make it Fair Share
> > > Scheduler.I will make some changes on some files such as sched.c vs...I will
> > > want to see the effect ot the change but recompilation of the kernel takes
> > > about half an hour on my machine.How can I minimize this time?Which part
> > > should I necessarily include in my config file for the kernel to minimize
> > > it?
> > >
> > make is your friend: it will only recompile those files that changed from
> > the last compilation. If you modify some #includes in the code, I believe
> > you will have to also run "make dep" before, to get dependencies right.
> 
> Except, as I discovered recently in playing around with the scheduler,
> if you modify sched.h, you basically have to recompile the entire
> kernel, as it seems everything depends on it.
> 
> On that note, why is add_to_runqueue() in sched.c and
> del_from_runqueue() in sched.h?  del_from_runqueue being the only func I
> was modifying in sched.h (really annoying have to recompile an entire
> kernel multiple times in a vmware vm, albiet thats not a good reason to
> move it, I'm just wondering why they are split in 2 different files)
> 
Somewhere back around 2.2.15 (or so) a change was made that has the smp
cpu start up code removing the start up task from the run list.  I think
you will find the del_from_runqueue() is only used in this case.  It
could have been done in init_idle() in sched.c (in fact the code is
there) but it is also done prior to this call.  Sigh...

George

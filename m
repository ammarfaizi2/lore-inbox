Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265789AbRF2JDb>; Fri, 29 Jun 2001 05:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265790AbRF2JDW>; Fri, 29 Jun 2001 05:03:22 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:26102 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S265789AbRF2JDL>; Fri, 29 Jun 2001 05:03:11 -0400
Message-ID: <3B3C44BE.5F25109D@kegel.com>
Date: Fri, 29 Jun 2001 02:05:02 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Smith <x@xman.org>
CC: "Daniel R. Kegel" <dank@alumni.caltech.edu>, balbir.singh@wipro.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
In-Reply-To: <5.1.0.14.0.20010629011647.02a00a98@imap.xman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Smith wrote:
> 
> At 07:49 PM 6/27/2001 -0700, Daniel R. Kegel wrote:
> >Balbir Singh <balbir.singh@wipro.com> wrote:
> > >sigopen() should be selective about the signals it allows
> > >as argument. Try and make sigopen() thread specific, so that if one
> > >thread does a sigopen(), it does not imply it will do all the signal
> > >handling for all the threads.
> >
> >IMHO sigopen()/read() should behave just like sigwait() with respect
> >to threads.  That means that in Posix, it would not be thread specific,
> >but in Linux, it would be thread specific, because that's how signals
> >and threads work there at the moment.
> 
> Actually, I believe with IBM's new Posix threads implementation, Linux
> finally does signal delivery "the right way". In general, I think it'd be
> nice if this API *always* sucked up signals from all threads. This makes
> sense particularly since the FD is accessible by all threads.

Although I'm looking forward to the day when Linux threading
(perhaps thanks to IBM's enhancements to Gnu Pth) becomes Posix compliant,
for now we need to consider both Posix threads and LinuxThreads.  
I think the proper behavior for sigopen() under the two threading systems would be:

Posix threads: sigopen() would capture signals delivered to the process,
as well as signals delivered by pthread_kill() to the thread that called sigopen().

Current LinuxThreads: sigopen() would only capture signals delivered 
to the thread that called sigopen().

- Dan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289036AbSAUEa7>; Sun, 20 Jan 2002 23:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289037AbSAUEas>; Sun, 20 Jan 2002 23:30:48 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:63248 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289036AbSAUEac>; Sun, 20 Jan 2002 23:30:32 -0500
Message-ID: <3C4B97EA.F49C7C95@zip.com.au>
Date: Sun, 20 Jan 2002 20:24:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: Your message of "Sun, 20 Jan 2002 18:56:34 -0800."
	             <3C4B8362.8B249698@zip.com.au> <1032.1011584580@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 20 Jan 2002 18:56:34 -0800,
> Andrew Morton <akpm@zip.com.au> wrote:
> >I'm not aware of anyone getting kgdb working fully with modules.
> 
> kgdb has a script that tells gdb where each module is loaded.  AFAIK it
> uses add-symbol-file FILENAME -sSECTION ADDRESS, the __insmod entries
> contain enough data to tell gdb what is going on.
> 
> >Proper crash analysis needs to know the load address of each module
> >at the time of the crash.  We should print them out at Oops time.
> 
> You need 13 bits of data per module.  Where each of text, rodata, data
> and bss sections were loaded, you cannot assume they are contiguous.
> The length of those four sections.  Where the module is on disk, you
> cannot assume the object name is the same as the module name, insmod
> -o.  The timestamp and kernel version of the module when it was loaded,
> to detect updates after the event.  All of that is encoded in the
> __insmod entries in /proc/ksyms, 5 lines per module.

That sounds OK.  Just print it first.  If it hits the logs then
great.  If it just scrolls off the screen then no loss.

> >> That is a different problem.  Saying that modular kernels cause
> >> problems for debugging is not a good enough reason to deprecate modular
> >> kernels, all the problems have been solved.
> >
> >They are patently *not* solved, because we continue to get a
> >stream of partially and competely useless oops reports.
> 
> Rule 1.  Users do not read documentation.
> Rule 2.  You can't do anything about rule 1.

Often the users know nothing about elf internals, kernel tools
and build processes and all of that.  They just want to get their
box back up and reliable, and they consider that any work they do 
in problem disgnosis is a favour for the developers (and I have no
problem with that attitude).

Often, we only get one shot at it.
 
> If you want complete bug reports, write a script that forces the user
> to submit all the required data.

It's in our interest to make it as easy as possible for the reporter.
Cut-and-paste is easy, so we should err on the side of overkill when
choosing which data to dump out.

> Why do I feel the "Linux should have
> a bug reporting system" thread starting again?

Yeah, let's not do that.  (But I'd be on the "no" side :-))

-

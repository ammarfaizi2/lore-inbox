Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314453AbSECPpw>; Fri, 3 May 2002 11:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314465AbSECPpv>; Fri, 3 May 2002 11:45:51 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:25869 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314453AbSECPpt>;
	Fri, 3 May 2002 11:45:49 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Fri, 03 May 2002 09:48:04 EST."
             <Pine.LNX.4.44.0205030853090.32217-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 May 2002 01:45:38 +1000
Message-ID: <15357.1020440738@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002 09:48:04 -0500 (CDT), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>On Fri, 3 May 2002, Keith Owens wrote:
>> Changing from a recursive to non-recursive make is the big change in
>> kbuild 2.5.  If you think that you can do non-recursive make without
>> significant changes to the Makefiles, show me the code.
>
>Well, we had this thread a couple of months ago, I resurrected a 
>(proof-of-concept only) patch I had to do so. You were on the CC list - 
>why do I even bother talking to you when you don't listen anyway?

Because you have no working code!  kbuild 2.5 is up and running, you
are still discussing ideas and wasting my time.

>In the non-recursive build, make ends up with a database for all potential 
>objects, and has to build the dependency tree from that. Considering that 
>every single source file has in the order of 100 files it depends on, 
>that's a huge job. Even with a pretty small .config, I noticed make 
>growing to >64M of RAM, so I suspect this approach may cause serious 
>problems on small boxes - I didn't check that, though.

Which is why I don't let make do the dependency graph, I do it in
pp_makefile4.  Don't you understand?  I have already tried using
standard make processing for the kernel and found it was too expensive
for small systems.  Been there, done that, discarded the idea, wrote
the replacement code which is faster than what you are suggesting.

>However, let me state that I don't know what's the best solution here. I 
>can see options like
>o recursive build
>o non-recursive build all handled within make
>o using some external program that will generate a non-recursive Makefile
>  to be used with make (note that this however, could be more or less a
>  trivial parser which only adds the appropriate paths to object/source
>  names in the individual Makefile fragments)

I do.  make cannot cope with the complexity of the kernel, especially
with the two layer model of config plus timestamp.  You are still
looking at options that I investigated over a year ago and discarded as
unworkable.

>> http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-history.tar.bz2
>> without making significant changes to the entire kbuild system, show me
>> the code.
>
>I'm not claiming to have solved all the problems, I'm claiming to be able
>to solve the important ones. - in particular, correctness, i.e.
>dependencies done right and clean Makefiles. I didn't look into providing
>a separate tree to put the built objects into, but I think it's doable.

Don't think, show me some working code or shut up.  I can tell you now
that it was several months of hard work to track down and fix all the
places in the source and Makefiles that assume source == object.  The
extreme difficulty of doing that with standard make rules is one of the
reasons that I went to a pre-processor.

>> kbuild 2.5 fixes _all_ the problems listed in the history file, except
>> for modversions which will be done later.  Once you decide to fix the
>> big problems, you will realise that fiddling with the old system to fix
>> the little problems is a waste of time and effort.
>
>In one paragraph you claim that leaving the hard problem for later is a 
>bad idea, in the next one you do it yourself?

No.  I am temporarily omitting a feature which is (a) currently broken
(b) is not being used in development kernels and (c) cannot be fixed
without a radical redesign.  Modversions is not needed right now and
will be added later.  Everything I have done in kbuild 2.5 is needed
now.

Kai, I am fed up with you suggesting ideas which I have already tried
and found not to work.  The only way that you will persuade me is to
come up with a *fully* working system that is simpler and faster than
kbuild 2.5.  Go away and do that, then you can argue your case.


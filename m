Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312393AbSC3E0H>; Fri, 29 Mar 2002 23:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312392AbSC3EZ6>; Fri, 29 Mar 2002 23:25:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65039 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312391AbSC3EZk>;
	Fri, 29 Mar 2002 23:25:40 -0500
Message-ID: <3CA53DE5.668AC7AB@zip.com.au>
Date: Fri, 29 Mar 2002 20:24:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Jeremy Jackson <jerj@coplanar.net>, linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] which kernel debugger is "best"?
In-Reply-To: Your message of "Fri, 29 Mar 2002 19:18:39 -0800."
	             <3CA52E8F.C8D0E5F8@zip.com.au> <2178.1017459962@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Fri, 29 Mar 2002 19:18:39 -0800,
> Andrew Morton <akpm@zip.com.au> wrote:
> >Jeremy Jackson wrote:
> >>
> >> What are people using?
> >
> >kgdb.  Tried kdb and (sorry, Keith), it's not in the same
> >league.  Not by miles.
> 
> <good points deleted>
> ..
> Pick the right tool.

I guess the distinction here is that I use kgdb for "development",
not for "debugging".

Displaying data structures, values of variables.  Seeing what
state all tasks in the system are in, where they're sleeping,
where they're spending CPU, etc.

When adding ad-hoc inxtrumentation to the kernel, you don't
need to bother printing it out - just increment the counters
and go in take a look when desired.

And yes, kgdb mucks up call chains across down() because of the
lack of a frame pointer - backtraces don't display who called
down() - it loses the innermost frame.  That's irritating,
but not enough to have motivated me to soil my hands with
x86 assembly yet.

I haven't had any problems with -fno-omit-frame-pointer at
any time.

I *have* had problems with -fno-inline.  I'd very much like
to be able to turn that on, but the presence of `extern inline'
functions causes a link failure with `-fno-inline'.  I'd suggest
that this is a gcc shortcoming.  I actually had a poke yesterday
at teaching gcc to convert extern inline to static inline if 
flag_no_inline, but it didn't work out.

kgdb is damned inconvenient.  You have to set up a cross-build
machine, serial cable and generally get organised to use it.
In reality, this would take an hour or so but it is some friction.

I would like to see kdb shipped in the mainline kernel, so that
we can get better diagnostic reports from users/testers.


-

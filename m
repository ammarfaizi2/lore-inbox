Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265757AbSJTDrN>; Sat, 19 Oct 2002 23:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265756AbSJTDrN>; Sat, 19 Oct 2002 23:47:13 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:18955 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265757AbSJTDrL>;
	Sat, 19 Oct 2002 23:47:11 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200210200353.g9K3rEF341645@saturn.cs.uml.edu>
Subject: Re: [ANNOUNCE] procps 3.0.4
To: jgarzik@pobox.com (Jeff Garzik)
Date: Sat, 19 Oct 2002 23:53:14 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <3DB21088.9090003@pobox.com> from "Jeff Garzik" at Oct 19, 2002 10:10:16 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Albert D. Cahalan wrote:

>> The procps-2.x.x code silently gives bad output; it does NOT work.
>
> Can you be more specific?  What bugs do you see?

In this one case:

There isn't error checking in the five_cpu_numbers function
to detect bad data. Not that bad data should ever happen; there
is a bug in the WOLK kernel.

In other cases:

Craig and I have been fixing bugs for years. Going down Red Hat's
bug list, I believe we've fixed these unclosed bugs:

35174 watch double-spaces long lines
40909 free does not return all swap space defined
53300 top + addition of i/o wait
53702 top, ps segmentation fault
54195 ps shouldn't truncate lines when outputting to a pipe
55862 top resource usage     <-- more to come
57912 size argument doesn't work in ps     <-- correctly fixed
74255 patch to top.c fixing spurious idle time percentage miscalculation
74692 type in online help
75354 sysctl variable problem when setting parameters on vlan inte

Plus we fixed the others (duplicated effort) and fixed a number
of things not reported to Red Hat. The debian-unstable users are
pretty clueful about reporting bugs.

> I am wondering if Red Hat should integrate your procps if this is so?

Red Hat should use procps 3, but not because of a problem in
the WOLK kernel. There are many other reasons to use procps 3.

Nice how SourceForge would go down right when I want to get to
the change logs. :-( There are two; when the site comes back
up you can try [Cc]hange[Ll]og(.html|.txt|) names to find it.
(only the recent stuff has a link off the front page)

http://procps.sf.net/

Obligatory linux-kernel discussion:

It's a POSIX and UNIX requirement to report per-process %cpu
over some undefined _recent_ time period. Linux does not
provide this info. Decaying averages like uptime(1) provides
would be great, maybe for 2, 10, and 60 seconds.

I could make vmstat way faster if the kernel would provide the
number of tasks that are running, swapped out, blocked, etc.
Right now vmstat has to examine every process in the system
just to count those up. Some of those are even tracked already,
such as nr_running in kernel.sched.c.

It'd be great to have an "adopted child" flag to mark processes
which have been reparented to init. This would make "ps f" better.
Also a flag for kapm-idled would be good. Note that these flags
have to be stable over time; the existing process flags have not
been stable and thus could not sanely be used.

Having a /proc/*/tty symlink would make procps run faster.


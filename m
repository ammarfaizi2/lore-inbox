Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153993AbPGIUpI>; Fri, 9 Jul 1999 16:45:08 -0400
Received: by vger.rutgers.edu id <S153877AbPGIUox>; Fri, 9 Jul 1999 16:44:53 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:24622 "EHLO sgi.com") by vger.rutgers.edu with ESMTP id <S153900AbPGIUna>; Fri, 9 Jul 1999 16:43:30 -0400
To: Robert Walsh <rjwalsh@durables.org>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: kernel profiling
References: <7m3tm8$7lvnt@fido.engr.sgi.com>
From: Dimitris Michailidis <dimitris@darkside.engr.sgi.com>
Date: 09 Jul 1999 13:43:40 -0700
In-Reply-To: Robert Walsh's message of "8 Jul 1999 21:26:48 -0700"
Message-ID: <6yrwvw9y2o3.fsf@darkside.engr.sgi.com>
X-Mailer: Gnus v5.5/XEmacs 20.4 - "Emerald"
Sender: owner-linux-kernel@vger.rutgers.edu

Robert Walsh <rjwalsh@durables.org> writes:

> Other than /dev/profile, is there any mechanism available for
> profiling the kernel?  For example, has anyone implemented a
> __mcount() function to handle a kernel compiled with -pg, or is this
> even possible?
> 
> We're currently profiling the kernel NFS daemon (the entire path from
> network to disk) using SPECsfs and other benchmarking mechanisms, and
> before I start working on a home-grown profiling mechanism I'd like to
> make sure I'm not reinventing the wheel.
> 
> BTW: /proc/profile hasn't got enough granularity for our purposes and
> doesn't provide info such as call-graph statistics.

Back in May I posted a patch to enable kernel profiling using gprof, which
should give you the call graph statistics you want.  The patch basically
implements mcount() to collect statistics, adds a couple of files to /proc to 
make the statistics available to the user land, and provides a command,
kernprof, to generate gmon.out for consumption by gprof.  kernprof, in
addition to preparing data for gprof, also does the job of readprofile, with
a number of bugs of the latter fixed.

You can get the patch from

http://linuxwww.db.erau.edu/mail_archives/linux-kernel/May_99/2383.html

or other archives.  Since there has been no response to this patch there has
been no further development since the initial release, but it probably still
applies cleanly against the 2.2.x kernels.

As noted in the initial post, due to bugs in gcc/egcs that cause
miscompilation of programs that use -pg and regparms, to use this patch you
either need a hacked version of egcs or you need to disable the FASTCALLs in
the kernel (the latter is done in the IKD patch).

Let me know if you have any suggestions to improve the patch or need other
assistance.

-- 
Dimitris Michailidis                    dimitris@engr.sgi.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

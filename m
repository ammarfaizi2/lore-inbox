Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbTEFBSc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 21:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTEFBSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 21:18:31 -0400
Received: from miranda.zianet.com ([216.234.192.169]:40714 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S262247AbTEFBS1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 21:18:27 -0400
Subject: Re: Kernel hot-swap using Kexec, BProc and CC/SMP Clusters.
From: Steven Cole <elenstev@mesatop.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <m1d6ixb8m7.fsf@frodo.biederman.org>
References: <1052140733.2163.93.camel@spc9.esa.lanl.gov>
	 <m1d6ixb8m7.fsf@frodo.biederman.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052184521.9059.660.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 05 May 2003 19:28:42 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 11:34, Eric W. Biederman wrote:
> So summarize:
> 1) Run multiple kernels (minimally kernels A and B)
> 2) Migrate processes from kernel A to kernel B
> 3) Use kexec to replace kernel A once all processes have left.
> 4) Repeat for all other kernels.

Just a small correction to the summary.  I was not assuming that
multiple kernels are running at the beginning   So the summary is more
like:

1) Make hardware available and use kexec to boot kernel B.
2) Migrate processes from kernel A to kernel B.
3) Once all processes have left kernel A, kernel B takes over A's turf,
   maybe with a really big kfree().
4) The end state is the same as the beginning, but with a new kernel.

For a machine already partitioned into clusters, your original summary
is correct.

> On two simple machines working in tandem (The most common variation
> used for high availability this should be easy to do).  And it is
> preferable to a reboot because of the additional control and speed.

Doing this on separate machines would be a good warm-up to doing it on
one machine partitioned into CC clusters.

Here is a direct link to Karim's paper on CC clusters (html version):
http://www.opersys.com/adeos/practical-smp-clusters/

I had forgotten about the nanokernel approach when I made my original
post.  If doing it this way is not everyone's cup of tea, there could be
other solutions.

Also, I've been assuming that processes to be moved would have their
dirty pages written out prior to migration.  This should eliminate the
need for moving a lot of data structures around, which would probably be
difficult anyway since those structures could arbitrarily change from
one kernel version to the next.

Steven


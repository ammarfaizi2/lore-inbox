Return-Path: <linux-kernel-owner+w=401wt.eu-S1753431AbWLOVfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbWLOVfD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbWLOVfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:35:02 -0500
Received: from smtp.saahbs.net ([70.235.213.234]:34729 "HELO smtp.saahbs.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752057AbWLOVfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:35:01 -0500
Date: Fri, 15 Dec 2006 15:35:00 -0600
From: Michal Sabala <lkml@saahbs.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 mmap hangs unrelated apps
Message-ID: <20061215213500.GA16106@prosiaczek>
Reply-To: Michael Sabala <lkml@saahbs.net>
References: <20061215023014.GC2721@prosiaczek> <1166199855.5761.34.camel@lade.trondhjem.org> <20061215175030.GG6220@prosiaczek> <20061215124208.a053f4d3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20061215124208.a053f4d3.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006/12/15 at 14:42:08 Andrew Morton <akpm@osdl.org> wrote
> On Fri, 15 Dec 2006 11:50:30 -0600
> Michal Sabala <lkml@saahbs.net> wrote:
> 
> > On 2006/12/15 at 10:24:15 Trond Myklebust <trond.myklebust@fys.uio.no> wrote
> > > On Thu, 2006-12-14 at 20:30 -0600, Michal Sabala wrote:
> > > > 
> > > > `cat /proc/*PID*/wchan` for all hanging processes contains page_sync.
> > > 
> > > Have you tried an 'echo t >/proc/sysrq-trigger' on a client with one of
> > > these hanging processes? If so, what does the output look like?
> > 
> > Hello Trond,
> > 
> > Below is the sysrq trace output for XFree86 which entered the
> > uninterruptible sleep state on the P4 machine with nfs /home. Please
> > note that XFree86 does not have any files open in /home - as reported by
> > `lsof`. Below, I also listed the output of vmstat.
> 
> We'd need to see the trace of all D-state processes, please.  Xfree86 might
> just be a victim of a deadlock elsewhere.  However there is a problem here..

Hi Andrew,

In most cases only a single process enters the D-state, this time it was
XFree, but I've seen gimp, firefox, gconfd and bash. Once or twice I did
see two or three processes ending up in uninterruptible sleep, but I
suspect they entered this state at different test-mmap.c runs (I left
test-mmap.c running in a bash loop and checked the system after a few
hours).

Would it be beneficial to keep running test-mmap.c on this machine until
two or more processes end up in D-state? I can leave this machine
running test-mmap.c over the weekend. 

Please advise,

Sincerely,

Michal

-- 
Michal "Saahbs" Sabala

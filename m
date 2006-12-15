Return-Path: <linux-kernel-owner+w=401wt.eu-S1753491AbWLOVl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbWLOVl2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbWLOVl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:41:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47020 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489AbWLOVl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:41:27 -0500
Date: Fri, 15 Dec 2006 13:41:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Sabala <lkml@saahbs.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 mmap hangs unrelated apps
Message-Id: <20061215134116.f93f471b.akpm@osdl.org>
In-Reply-To: <20061215213500.GA16106@prosiaczek>
References: <20061215023014.GC2721@prosiaczek>
	<1166199855.5761.34.camel@lade.trondhjem.org>
	<20061215175030.GG6220@prosiaczek>
	<20061215124208.a053f4d3.akpm@osdl.org>
	<20061215213500.GA16106@prosiaczek>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 15:35:00 -0600
Michal Sabala <lkml@saahbs.net> wrote:

> On 2006/12/15 at 14:42:08 Andrew Morton <akpm@osdl.org> wrote
> > On Fri, 15 Dec 2006 11:50:30 -0600
> > Michal Sabala <lkml@saahbs.net> wrote:
> > 
> > > On 2006/12/15 at 10:24:15 Trond Myklebust <trond.myklebust@fys.uio.no> wrote
> > > > On Thu, 2006-12-14 at 20:30 -0600, Michal Sabala wrote:
> > > > > 
> > > > > `cat /proc/*PID*/wchan` for all hanging processes contains page_sync.
> > > > 
> > > > Have you tried an 'echo t >/proc/sysrq-trigger' on a client with one of
> > > > these hanging processes? If so, what does the output look like?
> > > 
> > > Hello Trond,
> > > 
> > > Below is the sysrq trace output for XFree86 which entered the
> > > uninterruptible sleep state on the P4 machine with nfs /home. Please
> > > note that XFree86 does not have any files open in /home - as reported by
> > > `lsof`. Below, I also listed the output of vmstat.
> > 
> > We'd need to see the trace of all D-state processes, please.  Xfree86 might
> > just be a victim of a deadlock elsewhere.  However there is a problem here..
> 
> Hi Andrew,
> 
> In most cases only a single process enters the D-state, this time it was
> XFree, but I've seen gimp, firefox, gconfd and bash. Once or twice I did
> see two or three processes ending up in uninterruptible sleep, but I
> suspect they entered this state at different test-mmap.c runs (I left
> test-mmap.c running in a bash loop and checked the system after a few
> hours).

OK, useful info, thanks.

> Would it be beneficial to keep running test-mmap.c on this machine until
> two or more processes end up in D-state? I can leave this machine
> running test-mmap.c over the weekend. 

No, that's OK.  The next step should be for a kernel wrangler to get in
there with your testcase.  It could well be that lock_page-inside-lock_page
thing.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269460AbUIRMoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269460AbUIRMoV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 08:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbUIRMoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 08:44:21 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:5280 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269460AbUIRMoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 08:44:01 -0400
Subject: Re: nproc: So?
From: Albert Cahalan <albert@users.sf.net>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040917175130.GA7050@k3.hellgate.ch>
References: <1095440131.3874.4626.camel@cube>
	 <20040917175130.GA7050@k3.hellgate.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1095511212.4973.8.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Sep 2004 08:40:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-17 at 13:51, Roger Luethi wrote:
> On Fri, 17 Sep 2004 12:55:32 -0400, Albert Cahalan wrote:

> > The nicest think about netlink is, i think, that it might make
> > a practical interface for incremental update. As processes run
> > or get modified, monitoring apps might get notified. I did not
> > see mention of this being implemented, and I would take quite 
> > some time to support it, so it's a long-term goal. (of course,
> > people can always submit procps patches to support this)
> 
> Sounds like what wli and I have discussed as differential updates
> a few weeks ago. I agree that would be nice, for now the goal was
> to suggest something that's cleaner and faster than procfs.
> Extensions are easy to add later.

To me, this looks like the killer feature. You could even
skip the regular process info. Simply return process identification
cookies that could be passed into a separate syscall to get
the information.

> > I doubt that it is good to break down the data into so many
> > different items. It seems sensible to break down the data by 
> > locking requirements. 
> 
> True if you consider a static set of fields that never changes. Problematic
> otherwise, because as soon as you start grouping fields together, you need
> an agreement between kernel and user-space on the contents of these groups.

I suppose this is small potatoes compared to the overhead
of dealing with ASCII, but individual field handling would
be a bit slower.

For initial libproc support, I'd start by requesting info
in groups that match what /proc provides today.

> > I could use an opaque per-process cookie for process identification.
> > This would protect from PID reuse, and might allow for faster
> > lookup. Perhaps it contains: PID, address of task_struct, and the
> > system-wide or per-cpu fork count from process creation.
> 
> Agreed, that would be useful. And it would be easy to integrate with
> nproc. Just add a field to return the cookie and a selector based on
> cookies rather than PIDs.
> 
> > Something like the stat() syscall would be pretty decent.
> 
> You lost me there.

The stat() call simply fills in a struct. Given a per-process
cookie (or a PID if you tolerate the race conditions), a syscall
similar to stat() could fill in a struct.



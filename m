Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUHFRvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUHFRvw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUHFRsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:48:17 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:44192 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266073AbUHFRqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:46:18 -0400
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
From: Albert Cahalan <albert@users.sf.net>
To: Roger Luethi <rl@hellgate.ch>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20040806170832.GA898@k3.hellgate.ch>
References: <1091754711.1231.2388.camel@cube>
	 <20040806094037.GB11358@k3.hellgate.ch>
	 <20040806104630.GA17188@holomorphy.com>
	 <20040806120123.GA23081@k3.hellgate.ch> <1091800948.1231.2454.camel@cube>
	 <20040806170832.GA898@k3.hellgate.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1091805296.3547.2522.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Aug 2004 11:14:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 13:08, Roger Luethi wrote:
> On Fri, 06 Aug 2004 10:02:28 -0400, Albert Cahalan wrote:

> > > what a good solution would look like. Files like /proc/pid/status
> > > are human-readable and maintenance-friendly (the parser can recognize
> > > unknown values and gets a free label along with it; obsolete fields can
> > > be removed).
> > 
> > If you're just spewing the values with a perl script, sure.
> > I'm not sure this matters.
> 
> It matters to me. I like to have tools that don't need updates to
> cope with new fields. Having to wait for tool authors to catch up with
> kernels is annoying.

Not many people want raw data, so the tool authors
will need to put out new releases anyway.

It doesn't take more than a week generally.

> > If it's going to be this dynamic, then just give me DWARF2 debug
> > info and the raw data. Like this:
> > 
> > /proc/DWARF2
> > /proc/1000/mm_struct
> > /proc/1000/signal_struct
> > /proc/1000/sighand_struct
> > /proc/1000/task/1024/thread_info
> > /proc/1000/task/1024/task_struct
> > /proc/1000/task/1024/fs_struct
> 
> That's different. The overhead would be prohibitive. Also, this exposes
> internal kernel structures.

The overhead? I'm not seeing much, other than the multiple
files and the very fact that field locations are movable.

As long as I can fall back to the old /proc files when truly
radical kernel changes happen, exposure of kernel internals
isn't a serious problem.

If I had the DWARF2 data alone, /dev/mem might be enough.
(sadly, "top" would require some major work before I'd trust it)

> > > Or use netlink maybe? It sure would be nice to monitor all processes
> > > with lower overhead, and to have tools that can deal with new data
> > > items without an update.
> > 
> > I've been thinking netlink might be good.
> 
> Alright. Maybe we can move our discussion into this direction?

I'll need to track down some netlink documentation.
Last time I looked, there wasn't any.
 
> > > - Split proc information by new criteria: Slow, expensive items should
> > >   not be in the same file as information that tools typically
> > >   and frequently read. For instance, you could have status_basic,
> > >   status_exotic, and status_slow. Even status_basic could have a format
> > >   similar to /proc/pid/status, but would be shorter and contain only
> > >   the most frequently used values (like statm today -- with all the
> > >   problems that come with such a pre-made selection).
> > 
> > Split by:
> > 1. locking
> > 2. security.
> 
> Hmmm... How does this translate to a netlink interface? Can you elaborate?

I don't think it does.

For the existing files though:

Some SE Linux policies block all access to /proc. Some security
feature patches zero out things that would reveal addresses.
(start_code, end_code, wchan...)



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSCDK4h>; Mon, 4 Mar 2002 05:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290843AbSCDK41>; Mon, 4 Mar 2002 05:56:27 -0500
Received: from juguete.quim.ucm.es ([147.96.5.11]:59663 "EHLO
	juguete.quim.ucm.es") by vger.kernel.org with ESMTP
	id <S289272AbSCDK4R>; Mon, 4 Mar 2002 05:56:17 -0500
Date: Mon, 4 Mar 2002 11:56:11 +0100 (CET)
From: Ramon Garcia Fernandez <ramon@juguete.quim.ucm.es>
To: linux-kernel@vger.kernel.org
Subject: Re: I/O scheduling suggestion
In-Reply-To: <Pine.LNX.4.33.0203031941040.842-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.21.0203041144000.21966-100000@juguete.quim.ucm.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I hope there is no problem is replaying to linux-kernel; I feel that
this discussion should be public]

On Sun, 3 Mar 2002, Mark Hahn wrote:

> > Yes, but that I/O activity was originated by some task. So it must
> > be possible to modify the page cache to keep track of that task.
> 
> you missed the point: the pagecache permits (encourages!) the
> "responsibility" for IO to be shared among many procs.  for instance,
> who is responsible for reading a particular page of glibc?

Although a IO action can benefit several processes, there is one that
creates the request. If another process needs the same page while the
first request has not been completed, its priority can be raised.

> > That a process that is using the disk a lot would have less priority for
> > i/o. Therefore the rest of the users would be better served. Futhermore,
> 
> that does not follow.  the issue is fairness, and linux already has
> reasonably good IO fairness.  if you're worried about DOS, this wouldn't
> solve it, since the DOSer just forks a bunch before submitting IO.

It would be more fair to make the priority of a process that makes less IO
higher. In this way, an interactive user that opens an editor is less
bothered by an application that makes intensive access.

It gives more stability against a bogus application that takes too much
memory.

In order to avoid a denial of service, Linux could implement per session
or per uid limits.

> 
> > the acrobat reader or Mozilla that takes a lot of memory would not bring
> > the machine down because of swapping, because that swapping would have
> > less priority that the rest of i/o requests.
> 
> this is an excellent example of why better design is not obvious:
> swapping often needs  the *highest* priority, since one small IO could
> be preventing the whole system from making progress.

But this case is the exception, not the rule. The normal behaviour of the
system should be optimized for the most frequent case. To handle the
exception, the process can tell the kernel by raising its priority.
For instance, an unpriviledged application could be allowed to raise
its priority for a limited time, so that it can, for instance, save the
document and exit faster.

Ramon


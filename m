Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSHTKzc>; Tue, 20 Aug 2002 06:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSHTKzc>; Tue, 20 Aug 2002 06:55:32 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:11963 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S316842AbSHTKzc>; Tue, 20 Aug 2002 06:55:32 -0400
Date: Tue, 20 Aug 2002 12:36:37 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
Message-ID: <20020820123637.A800@linux-m68k.org>
References: <Pine.LNX.4.44.0208191036040.11842-100000@home.transmeta.com> <Pine.LNX.4.44.0208192004110.30255-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208192004110.30255-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Aug 19, 2002 at 08:08:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 08:08:10PM +0200, Ingo Molnar wrote:
> 
> On Mon, 19 Aug 2002, Linus Torvalds wrote:
> 
> > I'd be happy to apply this patch (well, your fixed version), but I think
> > I'd prefer even more to make the whole reparenting go away, and keep the
> > child list valid all through the lifetime of a process.  How painful
> > could that be?
> 
> the problem is that the tracing task wants to do a wait4() on all traced
> children, and the only way to get that is to have the traced tasks in the
> child list. Eg. strace -f traces a random number of tasks, and after the
> PTRACE_CONTINUE call, the wait4 done by strace must be able to 'get
> events' from pretty much any of the traced tasks. So unless the ptrace
> interface is reworked in an incompatible way, i cannot see how this would
> work. wait4 could perhaps somehow search the whole tasklist, but that
> could be a pretty big pain even for something like strace.

the whole signal driven approach of ptrace is imho not very elegant
and causes high overhead. So reworking the ptrace interface to avoid 
signals would be a good idea. Instead of wait4 the tracer could eg 
block or poll on read of /proc/#num/ptrace.

Richard

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbSJ3E0v>; Tue, 29 Oct 2002 23:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSJ3E0v>; Tue, 29 Oct 2002 23:26:51 -0500
Received: from crack.them.org ([65.125.64.184]:29714 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S263991AbSJ3E0u>;
	Tue, 29 Oct 2002 23:26:50 -0500
Date: Tue, 29 Oct 2002 23:33:43 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: ptrace support for fork/vfork/clone events [1/3]
Message-ID: <20021030043343.GA1922@nevyn.them.org>
Mail-Followup-To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <20021027185038.GA27979@nevyn.them.org> <200210271853.g9RIrHV06188@devserv.devel.redhat.com> <20021027190311.GA28506@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021027190311.GA28506@nevyn.them.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 02:03:11PM -0500, Daniel Jacobowitz wrote:
> On Sun, Oct 27, 2002 at 01:53:17PM -0500, Alan Cox wrote:
> > > I've submitted this a couple of times and gotten no feedback, but I'm a
> > > sucker for pain, so here it is again - I'd really like to see this patch in
> > > 2.6.
> > 
> > I've been ignoring this because it doesn't appear to agree with what other
> > people tell me. For example why can't you do the fork trace by building
> > a trampoline ?
> 
> This is what strace used to do.  You'll notice that Red Hat's doesn't
> any more - not sure if that's in a release yet, Roland was working on
> it.  I'm not sure exactly how it works now, but the gist of the problem
> was that it's unreliable.  I believe the exact problem he was addressing
> was that while strace held the process stopped and figured out the
> child's PID, the child got a signal.  It leaves the trampoline and goes
> off to handle the signal; strace loses track of it, and it either exits
> (confusing the tracer) or longjmps (completely escaping the tracer).
> 
> The trampolines are platform-specific, too, which is a real nuisance. 
> Some of them are still wrong in the strace source.
> 
> Another advantage of ptrace reporting this is that we can stop on these
> events without having to manage breakpoints on the syscall points in
> libc, which is good when people inline-asm a clone() for some reason;
> which does still happen.  GDB can't use PTRACE_SYSCALL to find forks,
> it's a substantial slowdown for minimal benefit.
> 
> I can probably come up with some more reasons if you want :)

Alan, did I manage to convince you this was necessary?

Meanwhile, updated patches to tonight's BK tree are at:
  http://crack.them.org/~drow/forks/
and
  bk://nevyn.them.org:5000

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
